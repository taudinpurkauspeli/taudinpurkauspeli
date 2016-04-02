var app = angular.module('diagnoseDiseases');

app.controller("TasksController", [
    "$scope", "$stateParams", "$resource", "$uibModal", "$window",
    function($scope, $stateParams, $resource, $uibModal, $window) {

        $scope.tasksList = [];

        var TaskMoveUp = $resource('/tasks/:id/move_up.json',
            {id: "@id"});

        var MoveTaskUp = $resource('/tasks/:id/move_task_up.json',
            {id: "@id"});

        var TaskMoveDown = $resource('/tasks/:id/move_down.json',
            {id: '@id'});

        var MoveTaskDown = $resource('/tasks/:id/move_task_down.json',
            {id: '@id'});

        var TasksByLevel = $resource('/tasks_all_by_level.json');

        $scope.updateTasksList = function() {
            TasksByLevel.query({"exercise_id": $stateParams.exerciseShowId}, function(data) {
                $scope.tasksList = data;
            });
        };

        $scope.updateTasksList();

        $scope.moveTaskFromLevelToLevel = function(task, sourceLevel, destinationLevel) {

            if(destinationLevel < sourceLevel){
                TaskMoveUp.save({id: task.id, new_level: destinationLevel}, function() {
                    $scope.updateTasksList();
                });
            } else if (destinationLevel > sourceLevel){
                TaskMoveDown.save({id: task.id, new_level: destinationLevel}, function() {
                    $scope.updateTasksList();
                });
            }

            return task;
        };

        $scope.moveTaskToNewLevel = function(levelIndex, task) {

            var newLevel = levelIndex + 1;

            if(levelIndex < task.level){
                MoveTaskUp.save({id: task.id, new_level: newLevel}, function() {
                    $scope.updateTasksList();
                });
            } else if (levelIndex >= task.level){
                MoveTaskDown.save({id: task.id, new_level: newLevel}, function() {
                    $scope.updateTasksList();
                });
            }

            return task;
        };

        $scope.createTask = function() {
            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'tasks/create_task_modal.html',
                controller: 'CreateTaskModalController',
                resolve: {
                    exercise: $scope.exercise
                }
            });

            modalInstance.result.then(function(data) {
                $scope.updateTasksList();
                $scope.goToCurrentTask(data.id);
            }, function() {
                $window.alert("Toimenpiteen luominen peruttu.");
            });
        };
    }
]);