var app = angular.module('diagnoseDiseases');

app.directive('completeMultichoice', [
    function() {
        return {
            restrict: 'E',
            templateUrl: "multichoices/complete_multichoice.html",
            controller: "CompleteMultichoiceController",
            scope: {
                subtask: '=subtask',
                'setTask': '&afterCompletion'
            }
        };
    }
]);