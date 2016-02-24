var app = angular.module('diagnoseDiseases');

app.controller("TasksShowController", [
    "$scope", "$resource", "$window",
    function($scope, $resource, $window) {

        var Task = $resource('/tasks/:taskId.json',
            { taskId: "@id"},
            { update: { method: 'PUT' }});

        $scope.updateTask = function(){
            if ($scope.updateTaskForm.$valid) {
                Task.update({taskId: $scope.taskForShow.id}, $scope.taskForShow, function() {
                    $window.alert("Toimenpiteen päivitys onnistui!");
                    $scope.updateTaskForm.$setPristine();
                    $scope.updateTaskForm.$setUntouched();
                    $scope.updateTasksList();
                }, function() {
                    $window.alert("Toimenpiteen päivitys epäonnistui!");
                });
            }
        };


    }
]);