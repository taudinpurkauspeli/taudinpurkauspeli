var app = angular.module('diagnoseDiseases');

app.directive('completedSubtask', [
    function() {
        return {
            restrict: 'E',
            templateUrl: "tasks/completed_subtask.html",
            controller: "TasksCompletedSubtaskController",
            scope: {
                subtask: '=subtask'
            }
        };
    }
]);