var app = angular.module('diagnoseDiseases');

app.directive('currentTask', [
    function() {
        return {
            restrict: 'E',
            scope: {
                currentTask: '=taskForShow',
                currentExercise: '=currentExercise'
            },
            templateUrl: "tasks/show.html"
        };
    }
]);