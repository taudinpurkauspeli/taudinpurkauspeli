var app = angular.module('diagnoseDiseases');

app.controller("ExercisesShowController", [
    "$scope", "$stateParams", "$resource", "LocalStorageService", "$state",
    function($scope, $stateParams, $resource, LocalStorageService, $state) {
        $scope.exercise = {};
        $scope.taskForShow = {};

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

        var exerciseId = $stateParams.exerciseShowId;
        var ExerciseOne = $resource('/exercises_one/:exerciseId.json',
            { exerciseId: "@id"});
        var TaskOne = $resource('/tasks_one/:taskId.json',
            { taskId: "@id"});

        $scope.setExercise = function() {
            ExerciseOne.get({exerciseId : exerciseId}, function(data) {
                $scope.exercise = data;
            });
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

        $scope.setExercise();
        $scope.setCurrentTask();

        $scope.changeCurrentTask = function(newTask) {
            LocalStorageService.set("current_task", newTask);
            $scope.setCurrentTask();
            $state.go("exercises_show.current_task.show", {taskShowId: newTask});
        };

        $scope.removeCurrentTask = function() {
            LocalStorageService.remove("current_task");
            $scope.setCurrentTask();
        };

    }
]);