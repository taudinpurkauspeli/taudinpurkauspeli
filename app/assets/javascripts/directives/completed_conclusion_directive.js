var app = angular.module('diagnoseDiseases');

app.directive('completedConclusion', [
    function() {
        return {
            restrict: 'E',
            templateUrl: "conclusions/completed_conclusion.html",
            controller: "CompletedConclusionController",
            scope: {
                subtask: '=subtask'
            }
        };
    }
]);