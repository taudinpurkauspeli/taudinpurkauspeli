var app = angular.module('diagnoseDiseases');

app.controller("TasksUncompletedSubtaskController", [
    "$scope", "$stateParams",
    function($scope, $stateParams) {

        $scope.setSubtask = function() {
            if($scope.subtask.task_text){
                return;
            } else if($scope.subtask.multichoice){
                //get options

            } else if($scope.subtask.interview){
                //get questions

            } else if($scope.subtask.conclusion){
                //get something
            }
        };

    }
]);