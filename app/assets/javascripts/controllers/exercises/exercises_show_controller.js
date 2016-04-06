var app = angular.module('diagnoseDiseases');

app.controller("ExercisesShowController", [
    "$scope", "$stateParams", "$resource", "LocalStorageService", "$state",
    function($scope, $stateParams, $resource, LocalStorageService, $state) {
        $scope.exercise = {};
        $scope.taskForShow = {};

        $scope.links = [
            {tabName: "AnamnesisTab",
                tabState: "exercises_show.anamnesis",
                title: "Anamneesi"},
            {tabName: "TaskTab",
                tabState: "exercises_show.tasks",
                title: "Toimenpidelista"},
            {tabName: "HypothesisTab",
                tabState: "exercises_show.hypotheses",
                title: "Diffilista"}
        ];

        var exerciseId = $stateParams.exerciseShowId;
        var ExerciseOne = $resource('/exercises_one/:exerciseId.json',
            { exerciseId: "@id"});
        var TaskOne = $resource('/tasks_one/:taskId.json',
            { taskId: "@id"});

        $scope.setExercise = function() {
            ExerciseOne.get({exerciseId : exerciseId}, function(data) {
                $scope.exercise = data.exercise;
                $scope.hasConclusion = data.has_conclusion;
            });
        };

        $scope.setTaskForShow = function(current_task){
            if(current_task){
                TaskOne.get({taskId : current_task}, function(data) {
                    $scope.taskForShow = data;
                });
            } else {
                $scope.taskForShow = {};
            }
        };

        $scope.setCurrentTask = function() {
            $scope.current_task = LocalStorageService.get("current_task", null);
            $scope.setTaskForShow($scope.current_task);
        };

        $scope.setTaskTabPath = function() {
            $scope.current_task_show_path = LocalStorageService.getObject("current_task_tab_path", '{"state": "", "parameters": "{}"}');
        };

        $scope.setExercise();
        $scope.setCurrentTask();
        $scope.setTaskTabPath();

        $scope.goToState = function(newState){
            $state.go(newState.state, newState.parameters);
        };

        $scope.goToCurrentTask = function(newTask) {
            $state.go("exercises_show.current_task.show", {taskShowId: newTask});
        };

        $scope.removeCurrentTask = function() {
            LocalStorageService.remove("current_task");
            LocalStorageService.remove("current_task_tab_path");
            $scope.setCurrentTask();
        };

    }
]);