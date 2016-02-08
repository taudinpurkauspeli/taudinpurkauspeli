var app = angular.module('diagnoseDiseases');

app.controller("UpdateExerciseHypothesisModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', 'exerciseHypothesis',
    function($scope, $uibModalInstance, $resource, $window, exerciseHypothesis) {

        $scope.exerciseHypothesis = exerciseHypothesis;

        var ExerciseHypothesis = $resource('/exercise_hypotheses/:exerciseHypothesisId.json',
            { exerciseHypothesisId: "@id"},
            { update: { method: 'PUT' }});


        $scope.updateExerciseHypothesis = function() {
            if ($scope.updateExerciseHypothesisForm.$valid) {
                ExerciseHypothesis.update({exerciseHypothesisId: exerciseHypothesis.id}, $scope.exerciseHypothesis, function(){
                    alert("Caseen liitetyn diffin päivitys onnistui!");
                    $uibModalInstance.close();
                }, function() {
                    alert("Caseen liitetyn diffin päivitys epäonnistui!");
                });
            }
        };



        $scope.removeFromExercise = function(){
            var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa diffin casesta?");

            if (deleteConfirmation) {
                ExerciseHypothesis.delete({exerciseHypothesisId: exerciseHypothesis.id}, function() {
                    $window.alert("Diffi poistettu casesta");
                    $uibModalInstance.close();
                });

            } else {
                $window.alert("Diffiä ei poistettu casesta.");
            }
        };

        $scope.cancel = function () {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);