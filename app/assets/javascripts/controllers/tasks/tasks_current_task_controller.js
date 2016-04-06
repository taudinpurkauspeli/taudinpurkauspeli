var app = angular.module('diagnoseDiseases');

app.controller("TasksCurrentTaskController", [
    "$scope", "$stateParams", "LocalStorageService",
    function($scope, $stateParams, LocalStorageService) {

        $scope.setTask = function() {
            LocalStorageService.set("current_task", $stateParams.taskShowId);
            $scope.setCurrentTask();
        };

        $scope.setTaskShowPath = function(state, parameters) {
            var path = {};
            parameters.taskShowId = $stateParams.taskShowId;

            path.state = state;
            path.parameters = parameters;

            LocalStorageService.setObject("current_task_tab_path", path);
            $scope.setTaskTabPath();
        };

        $scope.setTask();
        $scope.setActiveTab("CurrentTaskTab");

    }
]);