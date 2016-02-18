var app = angular.module('diagnoseDiseases');

app.controller("ExercisesShowController", [
    "$scope", "$stateParams", "$resource", "LocalStorageService",
    function($scope, $stateParams, $resource, LocalStorageService) {
        $scope.exercise = {};

        $scope.views = [
            {viewName: "anamnesis_tab",
                tabId: "1",
                visibility: true},
            {viewName: "task_list",
                tabId: "2",
                visibility: true},
            {viewName: "exercise_hypothesis_list",
                tabId: "3",
                visibility: true}
        ];

        $scope.links = [
            {tabName: "AnamnesisTab",
                tabId: "1",
                title: "Anamneesi",
                visibility: true},
            {tabName: "TaskTab",
                tabId: "2",
                title: "Toimenpidelista",
                visibility: true},
            {tabName: "HypothesisTab",
                tabId: "3",
                title: "Diffilista",
                visibility: true}
        ];

        var exerciseId = $stateParams.id;
        var ExerciseOne = $resource('/exercises_one/:exerciseId.json',
            { exerciseId: "@id"});

        $scope.setExercise = function() {
            ExerciseOne.get({exerciseId : exerciseId}, function(data) {
                $scope.exercise = data;
            });
        };

        $scope.setExercise();

        $scope.setCurrentTab = function() {
            $scope.current_tab = LocalStorageService.get("current_tab", "1");
        };

        $scope.setCurrentTab();

        $scope.changeCurrentTab = function(newTab, tabID) {
            $scope.current_tab = newTab;
            LocalStorageService.set("current_tab", newTab);

            if (tabID != undefined){
                $(".exerciseTabLink").removeClass("active");
                $("#" + tabID).addClass("active");
            }
        };
    }
]);