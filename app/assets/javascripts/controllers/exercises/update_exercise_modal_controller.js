var app = angular.module('diagnoseDiseases');

app.controller("UpdateExerciseModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', 'exercise',
    function($scope, $uibModalInstance, $resource, $window, exercise) {

        $scope.exercise = exercise;

        var Exercise = $resource('/exercises/:exerciseId.json',
            { exerciseId: "@id"},
            { update: { method: 'PUT' }});

        $scope.updateExercise = function() {
            if ($scope.updateExerciseForm.$valid) {
                Exercise.update({exerciseId: exercise.id}, $scope.exercise, function() {
                    $.notify({
                        message: "Casen päivitys onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                    $uibModalInstance.close();
                }, function() {
                    $.notify({
                        message: "Casen päivitys epäonnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "danger",
                        offset: 100
                    });
                });
            }
        };

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);