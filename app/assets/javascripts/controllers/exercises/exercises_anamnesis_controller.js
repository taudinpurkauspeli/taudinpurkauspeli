var app = angular.module('diagnoseDiseases');

app.controller("ExercisesAnamnesisController", [
    "$scope", "$uibModal",
    function($scope, $uibModal) {
        $scope.updateExercise = function () {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'exercises/update_exercise_modal.html',
                controller: 'UpdateExerciseModalController',
                size: 'lg',
                resolve: {
                    exercise: $scope.exercise
                }
            });

            modalInstance.result.then(function (data) {
                $scope.setExercise();

            }, function () {
                alert("Casen päivitys peruttu.");
            });
        };


    }
]);