var app = angular.module('diagnoseDiseases');

app.controller("ExercisesAnamnesisController", [
    "$scope", "$uibModal", "$window",
    function($scope, $uibModal, $window) {

        $scope.setActiveTab("AnamnesisTab");

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
                $window.alert("Casen päivitys peruttu.");
            });
        };


    }
]);