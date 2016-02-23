var app = angular.module('diagnoseDiseases');

app.directive('currentTask', [
    function() {
        return {
            restrict: 'E',
            scope: {
              taskAtHand: '=taskForShow'
            },
            templateUrl: "tasks/show.html"
        };
    }
]);