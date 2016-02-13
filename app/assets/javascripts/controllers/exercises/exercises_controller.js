var app = angular.module('diagnoseDiseases');

app.controller("ExercisesController", [
    "$scope","$http","$stateParams", "$resource", "$state",
    function($scope , $http , $stateParams, $resource, $state) {
        $scope.exercisesList = [];

        var Exercises = $resource('/exercises.json');
        $scope.exercisesList = Exercises.query();


        $scope.viewExercise = function(exercise) {
            $state.go('exercises_show', {id: exercise.id});
        };

        $scope.newExercisePage = function(){
            $state.go('exercises_new');
        }


    }
]);