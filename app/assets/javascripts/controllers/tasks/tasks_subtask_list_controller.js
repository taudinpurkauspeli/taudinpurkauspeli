var app = angular.module('diagnoseDiseases');

app.controller("TasksSubtaskListController", [
    "$scope", "$resource", "$window",
    function($scope, $resource, $window) {

        var MoveSubtaskUp = $resource('/subtasks/:id/move_up.json',
            {id: "@id"});

        var MoveSubtaskDown = $resource('/subtasks/:id/move_down.json',
            {id: '@id'});

        $scope.moveSubaskToNewLevel = function(newLevel, subtask, previousLevel) {
            console.log("uusi taso: " + newLevel + " edellinen taso: " + previousLevel + " subtask taso: " + subtask.level);

            if(newLevel >= 0 && newLevel != previousLevel){

                var levelChange = newLevel - subtask.level;

                if(levelChange < 0){
                    var realNewLevel = newLevel + 1;
                    console.log("ylöspäin tasolle " + realNewLevel);
                    MoveSubtaskUp.save({id: subtask.id, new_level: realNewLevel}, function() {
                        console.log("Siirretty ylös");
                        $scope.setCurrentTask();
                    });

                } else if(levelChange > 0){
                    console.log("alaspäin tasolle " + newLevel);
                    MoveSubtaskDown.save({id: subtask.id, new_level: newLevel}, function() {
                        console.log("Siirretty alas");
                        $scope.setCurrentTask();
                    });
                }
            }

            return subtask;
        }

    }
]);