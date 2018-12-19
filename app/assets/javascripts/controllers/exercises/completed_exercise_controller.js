var app = angular.module('diagnoseDiseases');

app.controller("CompletedExerciseController", [
    "$scope", "$resource", "$window", "$uibModal", "$stateParams", "$state",
    function($scope, $resource, $window, $uibModal, $stateParams, $state) {

        var RestartExercise = $resource('/exercises_one/:exerciseId/restart.json',
            { exerciseId: "@id"},
            { restart: { method: 'PUT' }});

        $scope.restartExercise = function() {
            var restartConfirmation = $window.confirm("Oletko aivan varma, että haluat aloittaa casen alusta? Etenemisesi casessa nollautuu, mutta aiemmasta etenemisestä tallentuu merkintä " +
                "siitä, kuinka pitkälle olit casea pelannut.");

            if (restartConfirmation) {
                RestartExercise.restart({exerciseId : $scope.exercise.id}, {}, function() {
                    $.notify({
                        message: "Casen uudelleen aloittaminen onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                    $scope.removeCurrentTask();
                    $state.go('exercises_show.anamnesis', {exerciseShowId: $scope.exercise.id}, {reload: true});
                });
            } else {
                $.notify({
                    message: "Casea '" + $scope.exercise.name + "' ei aloitettu uudelleen."
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