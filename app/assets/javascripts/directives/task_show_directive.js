var app = angular.module('diagnoseDiseases');

app.directive('taskShow', [
    function() {
        return {
            restrict: 'E',
            templateUrl: "tasks/show_directive.html",
            controller: "TasksShowDirectiveController",
            scope: {
                task: '=task',
                currentUser: '=currentUser'
            }
        };
    }
]);