var app = angular.module('diagnoseDiseases');

app.controller("TasksShowController", [
    "$scope", "$resource", "$window",
    function($scope, $resource, $window) {

        $scope.taskText = null;

        var Task = $resource('/tasks/:taskId.json',
            { taskId: "@id"},
            { update: { method: 'PUT' }});

        var TaskText = $resource('/task_texts/:taskTextId.json',
            { taskTextId: "@id"},
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

        $scope.deleteTask = function() {
            var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa toimenpiteen ja kaikki sen alakohdat?");

            if (deleteConfirmation) {
                Task.delete({taskId : $scope.taskForShow.id}, function() {
                    $window.alert("Toimenpiteen poistaminen onnistui!");
                    $scope.updateTasksList();
                    $scope.removeCurrentTask();
                });
            } else {
                $window.alert("Toimenpidettä '" + $scope.taskForShow.name + "' ei poistettu");
            }
        };

        $scope.editTaskText = function(task_text) {
            $scope.taskText = task_text;
        };

        $scope.returnToTask = function() {
            $scope.taskText = null;
        };


    }
]);