var app = angular.module('diagnoseDiseases');

app.directive('completeInterview', [
    function() {
        return {
            restrict: 'E',
            templateUrl: "interviews/complete_interview.html",
            controller: "CompleteInterviewController",
            scope: {
                subtask: '=subtask',
                'setTask': '&afterCompletion'
            }
        };
    }
]);