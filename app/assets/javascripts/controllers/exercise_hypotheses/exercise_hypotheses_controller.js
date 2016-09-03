var app = angular.module('diagnoseDiseases');

app.controller("ExerciseHypothesesController", [
    "$scope", "$stateParams", "$resource", "$window", "$uibModal",
    function($scope, $stateParams, $resource, $window, $uibModal) {

        var ExerciseHypotheses = $resource('/exercise_hypotheses.json');
        var ExerciseHypothesesOnly = $resource('/exercise_hypotheses_only.json');
        var CheckedHypotheses = $resource('/checked_hypotheses.json');
        var CorrectDiagnosis = $resource('/correct_diagnosis.json');

        $scope.setExerciseHypotheses = function(exerciseHypothesis) {
            ExerciseHypotheses.get({"exercise_id": $stateParams.exerciseShowId}, function(data) {
                $scope.exerciseHypotheses = data;
                console.log(exerciseHypothesis);
                console.log(data);
                if(exerciseHypothesis) {
                    angular.forEach(data, function(exerciseHypothesisGroup, key) {
                        for(var i = 0; i < exerciseHypothesisGroup.length; i++) {
                            if(exerciseHypothesisGroup[i].id == exerciseHypothesis.id){
                                $scope.setExerciseHypothesisCollapse(exerciseHypothesisGroup[i]);
                                break;
                            }
                        }
                    });
                }
            });
        };

        $scope.setExerciseHypothesesOnly = function() {
            ExerciseHypothesesOnly.query({"exercise_id": $stateParams.exerciseShowId}, function(data) {
                $scope.exerciseHypothesesOnly = data;
            });
        };

        $scope.setCheckedHypotheses = function() {
            CheckedHypotheses.query({"exercise_id": $stateParams.exerciseShowId}, function(data) {
                $scope.checkedHypotheses = data;
            });
        };

        $scope.setCorrectDiagnosis = function() {
            CorrectDiagnosis.get({"exercise_id": $stateParams.exerciseShowId}, function(data) {
                $scope.correctDiagnosis = data;
            });
        };

        $scope.setAllExerciseHypotheses = function(exerciseHypothesis) {
            $scope.setExerciseHypotheses(exerciseHypothesis);

            if($scope.currentUserAdmin){
                $scope.setExerciseHypothesesOnly();
            }

            if($scope.currentUser && !$scope.currentUserAdmin){
                $scope.setCheckedHypotheses();
                $scope.setCorrectDiagnosis();
            }
        };

        $scope.setAllExerciseHypotheses();
        $scope.setActiveTab("HypothesisTab");

        $scope.addToExercise = function(hypothesis) {
            var newExerciseHypothesis = {
                exercise_id: $stateParams.exerciseShowId,
                hypothesis_id: hypothesis.id,
                explanation: ""
            };

            ExerciseHypotheses.save(newExerciseHypothesis,
                function() {
                    $scope.setAllExerciseHypotheses();
                    $.notify({
                        message: "Diffin lisääminen caseen onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                },
                function() {
                    $.notify({
                        message: "Diffiä ei voitu lisätä caseen."
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "danger",
                        offset: 100
                    });
                }
            );
        };

        $scope.belongsToExercise = function(hypothesis) {

            for(var i = 0; i < $scope.exerciseHypothesesOnly.length; i++) {
                var hypothesisValue = $scope.exerciseHypothesesOnly[i];
                if(hypothesisValue.id == hypothesis.id){
                    return true;
                }
            }
            return false;
        };


        $scope.updateExerciseHypothesis = function(exerciseHypothesis) {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'exercise_hypotheses/update_exercise_hypothesis_modal.html',
                controller: 'UpdateExerciseHypothesisModalController',
                size: 'lg',
                resolve: {
                    exerciseHypothesis: exerciseHypothesis
                }
            });

            modalInstance.result.then(function() {
                $scope.setAllExerciseHypotheses();
            }, function() {
                $.notify({
                    message: "Casen diffin päivitys peruttu"
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            });
        };

        $scope.hypothesisIsCorrectDiagnosis = function(exerciseHypothesis) {
            return $scope.correctDiagnosis.id == exerciseHypothesis.id;
        };

        $scope.userHasCheckedHypothesis = function(exerciseHypothesis) {
            for(var i = 0; i < $scope.checkedHypotheses.length; i++) {
                var checkedHypothesis = $scope.checkedHypotheses[i];
                if(checkedHypothesis.exercise_hypothesis_id == exerciseHypothesis.id){
                    return true;
                }
            }
            return false;
        };

        $scope.setExerciseHypothesisId = function(exerciseHypothesisId){
            if($scope.lastClickedExerciseHypothesis == exerciseHypothesisId){
                $scope.lastClickedExerciseHypothesis = null;
            } else {
                $scope.lastClickedExerciseHypothesis = exerciseHypothesisId;
            }
        };

        $scope.openCheckedHypothesis = function(exerciseHypothesis){
            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'exercise_hypotheses/show_exercise_hypothesis_modal.html',
                controller: 'ShowExerciseHypothesisModalController',
                size: 'md',
                resolve: {
                    exerciseHypothesis: exerciseHypothesis,
                    correctDiagnosis: $scope.correctDiagnosis
                }
            });

            modalInstance.result.then(function() {
            }, function() {
            });
        };

        $scope.setExerciseHypothesisCollapse = function(exerciseHypothesis) {
            exerciseHypothesis.collapsed = !exerciseHypothesis.collapsed;
        };

        $scope.checkExerciseHypothesis = function(exerciseHypothesis) {
            if($scope.userHasCheckedHypothesis(exerciseHypothesis)){
                $scope.setExerciseHypothesisCollapse(exerciseHypothesis);
            } else {
                var newCheckedHypothesis = {
                    exercise_hypothesis_id: exerciseHypothesis.id,
                    user_id: $scope.currentUser
                };
                CheckedHypotheses.save(newCheckedHypothesis,
                    function(data) {
                        $.notify({
                            message: exerciseHypothesis.hypothesis.name + " poissuljettu!"
                        }, {
                            placement: {
                                align: "center"
                            },
                            type: "success",
                            offset: 100
                        });
                        $scope.setAllExerciseHypotheses(exerciseHypothesis);
                    },
                    function() {
                        $.notify({
                            message: "Sinulla ei ole vielä tarpeeksi tietoa voidaksesi poissulkea tämän diffin."
                        }, {
                            placement: {
                                align: "center"
                            },
                            type: "danger",
                            offset: 100
                        });

                    }
                );
            }

        };

        $scope.userClickedCheckedHypothesis = function(exerciseHypothesis) {
            return exerciseHypothesis.id == $scope.lastClickedExerciseHypothesis;
        };

    }
]);