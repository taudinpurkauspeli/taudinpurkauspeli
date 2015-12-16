var app = angular.module('diagnoseDiseases');

app.controller("TasksController", [
    "$scope","$http","$stateParams", "$resource", "$location", "$window", "$state",
    function($scope , $http , $stateParams, $resource, $location, $window, $state) {
        $scope.tasksList = [];

        var TaskMoveUp = $resource('/tasks/:id/move_up.json',
            {"id": "@id"});

        var MoveTaskUp = $resource('/tasks/:id/move_task_up.json',
            {"id": "@id"});

        var TaskMoveDown = $resource('/tasks/:id/move_down.json',
            {"id": '@id'});

        var MoveTaskDown = $resource('/tasks/:id/move_task_down.json',
            {"id": '@id'});

        var Tasks = $resource('/tasks_all.json');
        $scope.tasksList = Tasks.query({"exercise_id": $stateParams.id});

        $scope.updateTasksList = function(){
            Tasks.query({"exercise_id": $stateParams.id}, function(data){
                $scope.tasksList = data;
            });
        };

        $scope.moveTaskFromLevelToLevel = function(task, sourceLevel, destinationLevel) {
            // console.log(task.id + " was dragged from list " +
            // sourceLevel + " to list " + destinationLevel);

            if(destinationLevel < sourceLevel){
                TaskMoveUp.save({id: task.id, new_level: destinationLevel}, function(){
                    $scope.updateTasksList();
                    console.log("Ylöspäin päivitys onnistui");
                });
            } else if (destinationLevel > sourceLevel){
                TaskMoveDown.save({id: task.id, new_level: destinationLevel}, function(){
                    $scope.updateTasksList();
                    console.log("Alaspäin päivitys onnistui");
                });
            }

            return task;
        };

        $scope.moveTaskToNewLevel = function(levelIndex, task) {
            // console.log(task.id + " was dragged from list X to levelIndex " + levelIndex);

            var newLevel = levelIndex + 1;

            if(levelIndex < task.level){
                MoveTaskUp.save({id: task.id, new_level: newLevel}, function(){
                    $scope.updateTasksList();
                    console.log("Taskin ylöspäin siirto onnistui");
                });
            } else if (levelIndex >= task.level){
                MoveTaskDown.save({id: task.id, new_level: newLevel}, function(){
                    $scope.updateTasksList();
                    console.log("Taskin alaspäin siirto onnistui");
                });
            }

            return task;
        };

    }
]);