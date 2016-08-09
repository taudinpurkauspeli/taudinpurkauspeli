var app = angular.module('diagnoseDiseases');

app.directive('completedExercise', [
    function() {
        return {
            restrict: 'E',
            templateUrl: "exercises/completed_exercise.html"
        };
    }
]);