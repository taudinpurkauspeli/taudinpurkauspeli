var app = angular.module('diagnoseDiseases');

app.controller("TasksCompletedSubtaskController", [
    "$scope", "$stateParams",
    function($scope, $stateParams) {

        $scope.setSubtask = function() {
            if($scope.subtask.multichoice){
                //get options

            } else if($scope.subtask.interview){
                //get questions

            } else if($scope.subtask.conclusion){
                //get something
            }
        };
    }
]);