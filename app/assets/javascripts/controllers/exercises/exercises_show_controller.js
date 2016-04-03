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

        $scope.setCurrentTaskShowPath = function() {
            $scope.current_task_show_path = LocalStorageService.getObject("current_task_show_path", '{"state": "", "parameters": "{}"}');
        };

        $scope.setActiveTab = function(tabId){
            if (tabId != undefined){
                $(".exerciseTabLink").removeClass("active");
                $("#" + tabId).addClass("active");
            }
        };

        $scope.setExercise();
        $scope.setCurrentTask();
        $scope.setCurrentTaskShowPath();

        $scope.goToState = function(newState){
            $state.go(newState.state, newState.parameters);
        };

        $scope.goToCurrentTask = function(newTask) {
            $state.go("exercises_show.current_task.show", {taskShowId: newTask});
        };

        $scope.removeCurrentTask = function() {
            LocalStorageService.remove("current_task");
            $scope.setCurrentTask();
        };

    }
]);