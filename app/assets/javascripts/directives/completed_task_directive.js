var app = angular.module('diagnoseDiseases');

app.directive('completedTask', [
    function() {
        return {
            restrict: 'E',
            templateUrl: "tasks/completed_task.html"
        };
    }
]);