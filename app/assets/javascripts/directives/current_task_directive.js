var app = angular.module('diagnoseDiseases');

app.directive('currentTask', [
    function() {
        return {
            templateUrl: "tasks/show.html"
        };
    }
]);