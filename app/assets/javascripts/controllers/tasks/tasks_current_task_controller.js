var app = angular.module('diagnoseDiseases');

app.controller("TasksCurrentTaskController", [
    "$scope", "$resource", "$window", "$uibModal", "$stateParams", "LocalStorageService", "$state",
    function($scope, $resource, $window, $uibModal, $stateParams, LocalStorageService, $state) {

        var Task = $resource('/tasks/:taskId.json',
            { taskId: "@id"},
            { update: { method: 'PUT' }});

        $scope.setTask = function() {
            LocalStorageService.set("current_task", $stateParams.taskShowId);
            $scope.setCurrentTask();
        };

        $scope.setTask();

    }
]);