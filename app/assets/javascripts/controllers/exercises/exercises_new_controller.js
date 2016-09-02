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
                        $.notify({
                            message: "Casen luominen onnistui!"
                        }, {
                            placement: {
                                align: "center"
                            },
                            type: "success",
                            offset: 100
                        });
                        $state.go('exercises_show.anamnesis', {exerciseShowId: data.id});
                    },
                    function() {
                        $.notify({
                            message: "Casen luominen epäonnistui!"
                        }, {
                            placement: {
                                align: "center"
                            },
                            type: "danger",
                            offset: 100
                        });
                    }
                );
            }
        };

    }
]);
