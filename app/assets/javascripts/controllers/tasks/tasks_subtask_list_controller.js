var app = angular.module('diagnoseDiseases');

app.controller("TasksSubtaskListController", [
    "$scope", "$resource",
    function($scope, $resource) {

        var MoveSubtaskUp = $resource('/subtasks/:id/move_up.json',
            {id: "@id"});

        var MoveSubtaskDown = $resource('/subtasks/:id/move_down.json',
            {id: '@id'});

        $scope.moveSubaskToNewLevel = function(newLevel, subtask, previousLevel) {
            if(newLevel >= 0 && newLevel != previousLevel){

                var levelChange = newLevel - subtask.level;

                if(levelChange < 0){
                    var realNewLevel = newLevel + 1;
                    MoveSubtaskUp.save({id: subtask.id, new_level: realNewLevel}, function() {
                        $scope.setTask();
                    });

                } else if(levelChange > 0){
                    MoveSubtaskDown.save({id: subtask.id, new_level: newLevel}, function() {
                        $scope.setTask();
                    });
                }
            }
            return subtask;
        };

        $scope.getDndType = function(dndTypeAsNumber) {
            return dndTypeAsNumber.toString();
        };

        $scope.editSubtask = function(subtask) {
            if(subtask.task_text){
                $scope.editTaskText(subtask.task_text);

            } else if(subtask.multichoice){
                $scope.editMultichoice(subtask.multichoice);

            } else if(subtask.interview){
                $scope.editInterview(subtask.interview);

            } else if(subtask.conclusion){
                $scope.editConclusion(subtask.conclusion);
            }
        };

        $scope.subtaskTitle = function(subtask) {

            if(subtask.task_text){
                return taskTextTitle(subtask.task_text);

            } else if(subtask.interview){
                return interviewTitle(subtask.interview);

            } else if(subtask.multichoice){
                return multichoiceTitle(subtask.multichoice);

            } else if(subtask.conclusion){
                return conclusionTitle(subtask.conclusion);
            }
        };

        var taskTextTitle = function(task_text){
            return "Tekstialakohta";
        };

        var interviewTitle = function(interview){
            return "Pohdinta: " + interview.title;
        };

        var conclusionTitle = function(conclusion){
            return "Diagnoosi: " + conclusion.title;
        };

        var multichoiceTitle = function(multichoice){
            var returnString = "";
            if(multichoice.is_radio_button){
                returnString += "Radio button: ";
            } else {
                returnString += "Monivalinta: ";
            }
            return returnString + multichoice.question;
        };


    }
]);