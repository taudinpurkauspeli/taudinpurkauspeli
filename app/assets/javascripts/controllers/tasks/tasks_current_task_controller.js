var app = angular.module('diagnoseDiseases');

app.controller("TasksCurrentTaskController", [
    "$scope", "$resource", "$stateParams", "LocalStorageService",
    function($scope, $resource, $stateParams, LocalStorageService) {

        var Task = $resource('/tasks/:taskId.json',
            { taskId: "@id"},
            { update: { method: 'PUT' }});

        $scope.setTask = function() {
            LocalStorageService.set("current_task", $stateParams.taskShowId);
            $scope.setCurrentTask();
        };

        $scope.setTaskShowPath = function(state, parameters) {
            var path = {};
            parameters.taskShowId = $stateParams.taskShowId;

            path.state = state;
            path.parameters = parameters;

            LocalStorageService.setObject("current_task_show_path", path);
            $scope.setCurrentTaskShowPath();
        };

        $scope.setTask();
        $scope.setActiveTab("CurrentTaskTab");

    }
]);