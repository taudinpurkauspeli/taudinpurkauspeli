var app = angular.module('diagnoseDiseases');

app.directive('completeConclusion', [
    function() {
        return {
            restrict: 'E',
            templateUrl: "conclusions/complete_conclusion.html",
            controller: "CompleteConclusionController",
            scope: {
                subtask: '=subtask',
                currentUser: '=currentUser',
                'setTask': '&afterCompletion'
            }
        };
    }
]);