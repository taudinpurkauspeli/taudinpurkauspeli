var app = angular.module('diagnoseDiseases');

app.controller("ExercisesShowController", [
    "$scope", "$stateParams", "$resource", "LocalStorageService",
    function($scope, $stateParams, $resource, LocalStorageService) {
        $scope.exercise = {};
        $scope.taskForShow = {};

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
        var TaskOne = $resource('/tasks_one/:taskId.json',
            { taskId: "@id"});

        $scope.setExercise = function() {
            ExerciseOne.get({exerciseId : exerciseId}, function(data) {
                $scope.exercise = data;
            });
        };

        $scope.setCurrentTab = function() {
            $scope.current_tab = LocalStorageService.get("current_tab", "1");
        };

        $scope.setCurrentTask = function() {
            $scope.current_task = LocalStorageService.get("current_task", null);
            if($scope.current_task){
                TaskOne.get({taskId : $scope.current_task}, function(data) {
                    $scope.taskForShow = data;
                });
            } else {
                $scope.taskForShow = {};
            }
        };

        $scope.setCurrentTab();
        $scope.setExercise();
        $scope.setCurrentTask();

        $scope.changeCurrentTab = function(newTab, tabID) {
            $scope.current_tab = newTab;
            LocalStorageService.set("current_tab", newTab);

            if (tabID != undefined){
                $(".exerciseTabLink").removeClass("active");
                $("#" + tabID).addClass("active");
            }
        };

        $scope.changeCurrentTask = function(newTask) {
            LocalStorageService.set("current_task", newTask);
            $scope.setCurrentTask();
            $scope.changeCurrentTab("4", "CurrentTaskTab");
        };

        $scope.removeCurrentTask = function() {
            LocalStorageService.remove("current_task");
            $scope.setCurrentTask();
            $scope.changeCurrentTab("2", "TaskTab");
        };
    }
]);