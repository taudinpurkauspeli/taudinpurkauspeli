var app = angular.module('diagnoseDiseases');

app.controller("ExercisesShowController", [
    "$scope","$http","$stateParams", "$resource", "$state", "LocalStorageService",
    function($scope , $http , $stateParams, $resource, $state, LocalStorageService) {
        var exerciseId = $stateParams.id;
        var Exercise = $resource('/exercises_one/:exerciseId.json',
            {"exerciseId": "@id"},
            { "save": { "method": "PUT" }});

        Exercise.get({"exerciseId" : exerciseId}, function(data){
            $scope.exercise = data;
        });

        $scope.setCurrentTab = function(){
            $scope.current_tab = LocalStorageService.get("current_tab", "1");
        };

        $scope.setCurrentTab();

        $scope.changeCurrentTab = function(newTab, tabID){
            $scope.current_tab = newTab;
            LocalStorageService.set("current_tab", newTab);

            if (tabID != undefined){
                $(".exerciseTabLink").removeClass("active")
                $("#" + tabID).addClass("active")
            }
        };

    }
]);