var app = angular.module('diagnoseDiseases');

app.controller("ExercisesController", [
    "$scope","$http","$stateParams", "$resource", "$location",
    function($scope , $http , $stateParams, $resource, $location) {
        $scope.exercisesList = [];

        var Exercises = $resource('/exercises.json');
        $scope.exercisesList = Exercises.query();


        $scope.viewExercise = function(exercise) {
            $location.path("/exercises/" + exercise.id);
        };

        $scope.newExercisePage = function(){
            $location.path("/exercises/new");
        }


    }
]);