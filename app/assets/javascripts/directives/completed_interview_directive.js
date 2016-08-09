var app = angular.module('diagnoseDiseases');

app.directive('completedInterview', [
    function() {
        return {
            restrict: 'E',
            templateUrl: "interviews/completed_interview.html",
            controller: "CompletedInterviewController",
            scope: {
                subtask: '=subtask'
            }
        };
    }
]);