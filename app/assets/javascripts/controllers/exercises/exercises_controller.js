var app = angular.module('diagnoseDiseases');

app.controller("ExercisesController", [
    "$scope","$http","$stateParams", "$resource", "$state", "$window",
    function($scope , $http , $stateParams, $resource, $state, $window) {
        $scope.exercisesList = [];

        var Exercises = $resource('/exercises.json');

        var Exercise = $resource('/exercises/:exerciseId.json',
            { exerciseId: "@id"},
            { update: { method: 'PUT' }});

        $scope.updateExercisesList = function(){
            Exercises.query(function(data){
                $scope.exercisesList = data;
            });
        };

        $scope.updateExercisesList();

        $scope.viewExercise = function(exercise) {
            $state.go('exercises_show', {id: exercise.id});
        };

        $scope.removeExercise = function(exercise) {

            var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa casen?");

            if (deleteConfirmation) {
                Exercise.delete({exerciseId : exercise.id}, function(){
                    $window.alert("Casen poistaminen onnistui!");
                    $scope.updateExercisesList();
                });
            } else {
                $window.alert("Casea '" + exercise.name + "' ei poistettu");
            }
        };

        $scope.newExercisePage = function(){
            $state.go('exercises_new');
        }


    }
]);