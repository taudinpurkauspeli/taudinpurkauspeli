var app = angular.module('diagnoseDiseases');

app.controller("ShowExerciseHypothesisModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', 'exerciseHypothesis', 'correctDiagnosis', '$stateParams',
    function($scope, $uibModalInstance, $resource, $window, exerciseHypothesis, correctDiagnosis, $stateParams) {

        $scope.exerciseHypothesis = exerciseHypothesis;
        $scope.correctDiagnosis = correctDiagnosis;

        $scope.hypothesisIsCorrectDiagnosis = function(exerciseHypothesis) {
            return $scope.correctDiagnosis.id == exerciseHypothesis.id;
        };

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);