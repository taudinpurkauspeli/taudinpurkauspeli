var app = angular.module('diagnoseDiseases');

app.controller("UpdateTaskModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', 'task',
    function($scope, $uibModalInstance, $resource, $window, task) {

        $scope.task = task;

        var Task = $resource('/tasks/:taskId.json',
            { taskId: "@id"},
            { update: { method: 'PUT' }});

        $scope.updateTask = function() {
            if ($scope.updateTaskForm.$valid) {
                Task.update({taskId: $scope.task.id}, $scope.task, function() {
                    $window.alert("Toimenpiteen päivitys onnistui!");
                    $uibModalInstance.close();
                }, function() {
                    $window.alert("Toimenpiteen päivitys epäonnistui!");
                });
            }
        };

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);