var app = angular.module('diagnoseDiseases');

app.controller("TasksSubtaskListController", [
    "$scope", "$resource", "$window",
    function($scope, $resource, $window) {

        $scope.moveSubaskToNewLevel = function(newLevel, subtask, previousLevel) {
            console.log("uusi taso: " + newLevel + " edellinen taso: " + previousLevel + " subtask taso: " + subtask.level);

            if(newLevel >= 0 && newLevel != previousLevel){

                var levelChange = newLevel - subtask.level;

                if(levelChange < 0){
                    var realNewLevel = newLevel + 1;
                    console.log("ylöspäin tasolle " + realNewLevel);

                }

                if(levelChange > 0){
                    console.log("alaspäin tasolle " + newLevel);
                }

            }
        }

    }
]);