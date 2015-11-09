var app = angular.module('diagnoseDiseases');

app.controller("ExercisesController", [
    "$scope","$http","$routeParams", "$resource",
    function($scope , $http , $routeParams, $resource) {
        $scope.exercise = "Taudinpurkauspelin caset";
    }
]);