var app = angular.module('diagnoseDiseases');

app.directive('currentTask', [
    function() {
        return {
            restrict: 'E',
            templateUrl: "tasks/show.html",
            controller: "TasksShowController"
        };
    }
]);