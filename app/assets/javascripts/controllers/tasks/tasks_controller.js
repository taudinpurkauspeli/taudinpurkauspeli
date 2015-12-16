var app = angular.module('diagnoseDiseases');

app.controller("TasksController", [
    "$scope","$http","$stateParams", "$resource", "$location", "$window", "$state",
    function($scope , $http , $stateParams, $resource, $location, $window, $state) {
        $scope.tasksList = [];

        var TaskDown = $resource('/tasks/:id/down.json',
            {"id": "@id"});

        var TaskUp = $resource('/tasks/:id/up.json',
            {"id": '@id'});

        var Tasks = $resource('/tasks_all.json');
        $scope.tasksList = Tasks.query({"exercise_id": $stateParams.id}, function(data){
            $scope.prettyList = JSON.stringify(data, null, ' ');
        });

        $scope.moveTaskFromLevelToLevel = function(task, sourceLevel, destinationLevel) {
            console.log(task.id + " was dragged from list " +
            sourceLevel + " to list " + destinationLevel);

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


            return task;
        };

        $scope.moveTaskToNewLevel = function(index, item) {
            console.log(item.id + " was dragged from list X to index " + index);

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