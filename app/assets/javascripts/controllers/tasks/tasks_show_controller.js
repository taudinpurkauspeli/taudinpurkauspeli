var app = angular.module('diagnoseDiseases');

app.controller("TasksShowController", [
    "$scope", "$resource", "$window", "$uibModal",
    function($scope, $resource, $window, $uibModal) {

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


        $scope.createTaskText = function(task) {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'task_texts/create_task_text_modal.html',
                controller: 'CreateTaskTextModalController',
                size: 'lg',
                resolve: {
                    task: task
                }
            });

            modalInstance.result.then(function(data) {
                $scope.setCurrentTask();
                $scope.editTaskText(data);
            }, function() {
                $window.alert("Tekstialakohdan luominen peruttu.");
            });
        };

        $scope.editTaskText = function(task_text) {
            $scope.taskText = task_text;
        };

        $scope.returnToTask = function() {
            $scope.taskText = null;
        };


    }
]);