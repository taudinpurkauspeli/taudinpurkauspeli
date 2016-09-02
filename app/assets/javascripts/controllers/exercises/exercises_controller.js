var app = angular.module('diagnoseDiseases');

app.controller("ExercisesController", [
    "$scope", "$resource", "$state", "$window",
    function($scope, $resource, $state, $window) {
        $scope.exercisesList = [];

        var Exercises = $resource('/exercises.json');

        var Exercise = $resource('/exercises/:exerciseId.json',
            { exerciseId: "@id"},
            { update: { method: 'PUT' }});

        var ExerciseDuplicate = $resource('/exercises/:exerciseId/dup.json',
            { exerciseId: "@id"});

        $scope.setExercises = function() {
            Exercises.query(function(data) {
                $scope.exercisesList = data;
            });
        };

        $scope.setExercises();

        $scope.viewExercise = function(exercise) {
            $state.go('exercises_show.anamnesis', {exerciseShowId: exercise.id});
        };

        $scope.removeExercise = function(exercise) {

            var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa casen?");

            if (deleteConfirmation) {
                Exercise.delete({exerciseId : exercise.id}, function() {
                    $.notify({
                        message: "Casen poistaminen onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                    $scope.setExercises();
                });
            } else {
                $.notify({
                    message: "Casea '" + exercise.name + "' ei poistettu."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            }
        };

        $scope.newExercisePage = function() {
            $state.go('exercises_new');
        };

        $scope.toggleHiddenExercise = function(exercise) {
            exercise.hidden = !exercise.hidden;
            Exercise.update({exerciseId : exercise.id}, exercise, function() {
                $.notify({
                    message: "Casen näkyvyyttä muokattu!"
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "success",
                    offset: 100
                });
                $scope.setExercises();
            }, function() {
                $.notify({
                    message: "Casen näkyvyyden muokkaus epäonnistui!"
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "danger",
                    offset: 100
                });
            });
        };

        $scope.copyExercise = function(exercise) {

            var duplicateConfirmation = $window.confirm("Oletko aivan varma, että haluat kopioida koko casen?");

            if (duplicateConfirmation) {
                ExerciseDuplicate.save({exerciseId : exercise.id}, exercise, function() {
                    $.notify({
                        message: "Casen kopiointi onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                    $scope.setExercises();
                }, function() {
                    $.notify({
                        message: "Casen kopiointi epäonnistui."
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "danger",
                        offset: 100
                    });
                });
            } else {
                $.notify({
                    message: "Casea ei kopioitu!"
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            }
        };

    }
]);