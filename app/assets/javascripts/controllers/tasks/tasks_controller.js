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

        var Tasks = $resource('/tasks_all.json');
        $scope.tasksList = Tasks.query({"exercise_id": $stateParams.id});

        $scope.moveTaskFromLevelToLevel = function(task, sourceLevel, destinationLevel) {
            console.log(task.id + " was dragged from list " +
            sourceLevel + " to list " + destinationLevel);

            var sourceInt = parseInt(sourceLevel);
            var destinationInt = parseInt(destinationLevel);

            var movement = destinationInt - sourceInt;

            if(movement < 0){
                TaskMoveUp.save({id: task.id, new_level: destinationLevel}, function(){
                    Tasks.query({"exercise_id": $stateParams.id}, function(data){
                        $scope.tasksList = data;
                    });
                    console.log("ylöspäin päivitys onnistui");
                });
            } else if (movement > 0){
                TaskMoveDown.save({id: task.id, new_level: destinationLevel}, function(){
                    Tasks.query({"exercise_id": $stateParams.id}, function(data){
                        $scope.tasksList = data;
                    });
                    console.log("alaspäin päivitys onnistui");
                });
            }

            return task;
        };

        $scope.moveTaskToNewLevel = function(index, item) {
            console.log(item.id + " was dragged from list X to index " + index);

            var newLevel = index + 1;

            MoveTaskUp.save({id: item.id, new_level: newLevel}, function(){
                Tasks.query({"exercise_id": $stateParams.id}, function(data){
                    $scope.tasksList = data;
                });
                console.log("taskin ylöspäin siirto onnistui");
            });

/*
            var sourceInt = parseInt(sourceLevel);
            var destinationInt = parseInt(destinationLevel);

            var movement = destinationInt - sourceInt;

            if(movement < 0){
                for(var i = movement; i < 0; i++){

                    TaskUp.save({id: task.id}, function(){
                        Tasks.get({"exercise_id": $stateParams.id}, function(data){
                            $scope.tasksList = data;
                        });
                    });
                }
            } else if (movement > 0){
                for(var j = movement; j > 0; j--){
                    TaskDown.save({id: task.id}, function(){
                        Tasks.get({"exercise_id": $stateParams.id}, function(data){
                            $scope.tasksList = data;
                        });
                    });
                }
            }
*/


            return item;
        };


    }
]);