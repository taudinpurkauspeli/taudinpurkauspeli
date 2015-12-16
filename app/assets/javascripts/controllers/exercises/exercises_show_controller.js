var app = angular.module('diagnoseDiseases');

app.controller("ExercisesShowController", [
    "$scope","$http","$stateParams", "$resource", "$state", "LocalStorageService",
    function($scope , $http , $stateParams, $resource, $state, LocalStorageService) {
        var exerciseId = $stateParams.id;
        var Exercise = $resource('/exercises_one/:exerciseId.json',
            {"exerciseId": "@id"},
            { "save": { "method": "PUT" }});

        $scope.exercise = Exercise.get({"exerciseId" : exerciseId});

        $scope.setCurrentTab = function(){
            $scope.current_tab = LocalStorageService.get("current_tab", "1");
        };

        $scope.setCurrentTab();

        $scope.changeCurrentTab = function(newTab){
            $scope.current_tab = newTab;
            LocalStorageService.set("current_tab", newTab);
        };


    }
]);