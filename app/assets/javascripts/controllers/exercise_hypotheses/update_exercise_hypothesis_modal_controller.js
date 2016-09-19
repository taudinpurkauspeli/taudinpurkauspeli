var app = angular.module('diagnoseDiseases');

app.controller("UpdateExerciseHypothesisModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', 'exerciseHypothesis', '$stateParams',
    function($scope, $uibModalInstance, $resource, $window, exerciseHypothesis, $stateParams) {

        $scope.exerciseHypothesis = exerciseHypothesis;
        $scope.allTasks = [];

        var AllTasks = $resource('/tasks_all.json');

        var ExerciseHypothesis = $resource('/exercise_hypotheses/:exerciseHypothesisId.json',
            { exerciseHypothesisId: "@id"},
            { update: { method: 'PUT' }});


        $scope.setAllTasks = function() {
            AllTasks.query({"exercise_id": $stateParams.exerciseShowId}, function(data){
                $scope.allTasks = data;
            });
        };

        $scope.setAllTasks();

        $scope.updateExerciseHypothesis = function() {
            if ($scope.updateExerciseHypothesisForm.$valid) {
                ExerciseHypothesis.update({exerciseHypothesisId: exerciseHypothesis.id}, $scope.exerciseHypothesis, function(){
                    $.notify({
                        message: "Caseen liitetyn diffin päivitys onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                    $uibModalInstance.close();
                }, function() {
                    $.notify({
                        message: "Caseen liitetyn diffin päivitys epäonnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "danger",
                        offset: 100
                    });
                });
            }
        };

        $scope.removeFromExercise = function() {
            var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa diffin casesta?");

            if (deleteConfirmation) {
                ExerciseHypothesis.delete({exerciseHypothesisId: exerciseHypothesis.id}, function() {
                    $.notify({
                        message: "Diffi poistettu casesta!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                    $uibModalInstance.close();
                });
            } else {
                $.notify({
                    message: "Diffiä ei poistettu casesta."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            }
        };

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);