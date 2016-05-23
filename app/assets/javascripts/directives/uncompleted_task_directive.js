var app = angular.module('diagnoseDiseases');

app.directive('uncompletedTask', [
    function() {
        return {
            restrict: 'E',
            templateUrl: "tasks/uncompleted_task.html",
            controller: "TasksUncompletedTaskController",
            scope: {
                subtask: '=subtask'
            }
        };
    }
]);