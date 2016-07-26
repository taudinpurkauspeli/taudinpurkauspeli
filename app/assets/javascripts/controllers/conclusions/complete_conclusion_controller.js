var app = angular.module('diagnoseDiseases');

app.controller("CompleteConclusionController", [
    "$scope", "$resource", "$window", "$uibModal", "$stateParams", "$state", "$filter",
    function($scope, $resource, $window, $uibModal, $stateParams, $state, $filter) {

        var ExerciseHypotheses = $resource('/exercise_hypotheses_conclusion.json');
        var CheckAnswersConclusion = $resource('/conclusions/:id/check_answers.json',
            {id: '@id'});
        var CheckedHypotheses = $resource('/checked_hypotheses.json');
        var CorrectDiagnosis = $resource('/correct_diagnosis.json');

        $scope.setCheckedHypotheses = function() {
            CheckedHypotheses.query({"exercise_id": $stateParams.exerciseShowId}, function(data) {
                $scope.checkedHypotheses = data;
            });
        };

        $scope.setExerciseHypotheses = function() {
            ExerciseHypotheses.query({ exercise_id : $stateParams.exerciseShowId}, function(data) {
                $scope.exerciseHypotheses = data;
            });
        };

        $scope.setCorrectDiagnosis = function() {
            CorrectDiagnosis.get({"exercise_id": $stateParams.exerciseShowId}, function(data) {
                $scope.correctDiagnosis = data;
            });
        };

        $scope.$watch(function(){
            return $scope.subtask.conclusion.id;
        },function(newValue, oldValue){
            $scope.setAllExerciseHypotheses();
        });

        $scope.setAllExerciseHypotheses = function() {
            $scope.setExerciseHypotheses();
            $scope.setCheckedHypotheses();
            $scope.setCorrectDiagnosis();

        };

        $scope.setAllExerciseHypotheses();

        $scope.checkAnswers = function(exerciseHypothesis) {
            CheckAnswersConclusion.save({ id: $scope.subtask.conclusion.id, exhyp_id: exerciseHypothesis.id }, function(data) {
                if(data.status == 202){
                    $window.alert("Onneksi olkoon suoritit casen!");
                }
                $scope.setExerciseHypothesisId(exerciseHypothesis.id);
                $scope.setTask();
            }, function(result) {
                $window.alert("Et ole vielä valinnut kaikkia tarpeellisia vaihtoehtoja");
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

        $scope.checkExerciseHypothesisIsRightAnswer = function(exerciseHypothesis) {
            if($scope.userHasCheckedHypothesis(exerciseHypothesis)){
                $scope.setExerciseHypothesisId(exerciseHypothesis.id);
            } else {

                if($scope.hypothesisIsCorrectDiagnosis(exerciseHypothesis)){
                    $scope.checkAnswers(exerciseHypothesis);
                } else {
                    var newCheckedHypothesis = {
                        exercise_hypothesis_id: exerciseHypothesis.id,
                        user_id: $scope.currentUser
                    };
                    CheckedHypotheses.save({checked_hypothesis: newCheckedHypothesis},
                        function(data) {
                            $window.alert(exerciseHypothesis.hypothesis.name + " poissuljettu!");
                            $scope.setExerciseHypothesisId(exerciseHypothesis.id);
                            $scope.setAllExerciseHypotheses();
                        },
                        function() {
                            $window.alert("Sinulla ei ole vielä tarpeeksi tietoa voidaksesi poissulkea tämän diffin.");
                        }
                    );
                }
            }

        };

        $scope.userClickedCheckedHypothesis = function(exerciseHypothesis) {
            return exerciseHypothesis.id == $scope.lastClickedExerciseHypothesis;
        };

    }
]);