var app = angular.module('diagnoseDiseases');

app.controller("ExercisesController", [
    "$scope","$http","$routeParams", "$resource", "$location",
    function($scope , $http , $routeParams, $resource, $location) {
        $scope.exercisesList = [];

        var Exercises = $resource('/exercises.json');
        $scope.exercisesList = Exercises.query();
    }
]);