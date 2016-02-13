var app = angular.module('diagnoseDiseases');

app.controller("ExercisesShowController", [
    "$scope","$http","$stateParams", "$resource", "$state", "LocalStorageService", "$uibModal",
    function($scope , $http , $stateParams, $resource, $state, LocalStorageService, $uibModal) {
        $scope.exercise = {};
        
        var exerciseId = $stateParams.id;
        var ExerciseOne = $resource('/exercises_one/:exerciseId.json',
            { exerciseId: "@id"});

        $scope.setExercise = function(){
            ExerciseOne.get({exerciseId : exerciseId}, function(data){
                $scope.exercise = data;
            });
        };

        $scope.setExercise();

        $scope.setCurrentTab = function(){
            $scope.current_tab = LocalStorageService.get("current_tab", "1");
        };

        $scope.setCurrentTab();

        $scope.changeCurrentTab = function(newTab){
            $scope.current_tab = newTab;
            LocalStorageService.set("current_tab", newTab);
        };

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