var app = angular.module('diagnoseDiseases');

app.directive('completedMultichoice', [
    function() {
        return {
            restrict: 'E',
            templateUrl: "multichoices/completed_multichoice.html",
            controller: "CompletedMultichoiceController",
            scope: {
                subtask: '=subtask'
            }
        };
    }
]);