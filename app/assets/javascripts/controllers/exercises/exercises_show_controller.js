var app = angular.module('diagnoseDiseases');

app.controller("ExercisesShowController", [
    "$scope","$http","$routeParams", "$resource",
    function($scope , $http , $routeParams, $resource) {
        var exerciseId = $routeParams.id;
        var Exercise = $resource('/exercises_one/:exerciseId.json',
            {"exerciseId": "@id"},
            { "save": { "method": "PUT" }});

        $scope.exercise = Exercise.get({"exerciseId" : exerciseId});

    }
]);