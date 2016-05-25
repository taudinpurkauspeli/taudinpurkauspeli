var app = angular.module('diagnoseDiseases');

app.directive('uncompletedSubtask', [
    function() {
        return {
            restrict: 'E',
            templateUrl: "tasks/uncompleted_subtask.html",
            controller: "TasksUncompletedSubtaskController",
            scope: {
                subtask: '=subtask'
            }
        };
    }
]);