var app = angular.module('diagnoseDiseases');

app.controller("ExercisesShowController", [
    "$scope","$http","$stateParams", "$resource", "$state",
    function($scope , $http , $stateParams, $resource, $state) {
        var exerciseId = $stateParams.id;
        var Exercise = $resource('/exercises_one/:exerciseId.json',
            {"exerciseId": "@id"},
            { "save": { "method": "PUT" }});

        $scope.exercise = Exercise.get({"exerciseId" : exerciseId});

        $scope.current_tab = 1;
    }
]);