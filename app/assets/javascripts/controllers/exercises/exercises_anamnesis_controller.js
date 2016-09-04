var app = angular.module('diagnoseDiseases');

app.controller("ExercisesAnamnesisController", [
    "$scope", "$uibModal", "$window", "$state", "$resource",
    function($scope, $uibModal, $window, $state, $resource) {

        $scope.setActiveTab("AnamnesisTab");

        var Exercise = $resource('/exercises/:exerciseId.json',
            { exerciseId: "@id"},
            { update: { method: 'PUT' }});

        $scope.updateExercise = function() {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'exercises/update_exercise_modal.html',
                controller: 'UpdateExerciseModalController',
                size: 'lg',
                resolve: {
                    exercise: $scope.exercise
                }
            });

            modalInstance.result.then(function() {
                $scope.setExercise();
            }, function() {
                $.notify({
                    message: "Casen päivitys peruttu!"
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            });
        };

        $scope.removeExercise = function(exercise) {

            var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa casen?");

            if (deleteConfirmation) {
                Exercise.delete({exerciseId : exercise.id}, function() {
                    $.notify({
                        message: "Casen poistaminen onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                    $state.go('app_root');
                });
            } else {
                $.notify({
                    message: "Casea '" + exercise.name + "' ei poistettu."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            }
        };

    }
]);