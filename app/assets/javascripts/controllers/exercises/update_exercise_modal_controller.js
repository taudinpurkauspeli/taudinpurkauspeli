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
                Exercise.update({exerciseId: exercise.id}, $scope.exercise, function(){
                    alert("Casen päivitys onnistui!");
                    $uibModalInstance.close();
                }, function() {
                    alert("Casen päivitys epäonnistui!");
                });
            }
        };

        $scope.cancel = function () {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);