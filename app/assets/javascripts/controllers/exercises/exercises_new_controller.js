var app = angular.module('diagnoseDiseases');

app.controller("ExercisesNewController", [
    "$scope", "$resource", "$state", "$window",
    function($scope, $resource, $state, $window) {
        $scope.newExercise = {
            hidden: false,
            anamnesis: ""
        };

        var Exercise = $resource('/exercises.json');

        $scope.createExercise = function() {
            if ($scope.createExerciseForm.$valid) {
                Exercise.save($scope.newExercise,
                    function(data) {
                        $window.alert("Casen luominen onnistui!");
                        $state.go('exercises_show.anamnesis', {exerciseShowId: data.id});
                    },
                    function() {
                        $window.alert("Casen luominen epäonnistui!");
                    }
                );
            }
        };

    }
]);
