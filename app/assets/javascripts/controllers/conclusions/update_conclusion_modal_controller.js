var app = angular.module('diagnoseDiseases');

app.controller("UpdateConclusionModalController", [
    "$scope", "$resource", "$window", "$uibModalInstance", "conclusion", "$stateParams",
    function($scope, $resource, $window, $uibModalInstance, conclusion, $stateParams) {

        $scope.conclusion = conclusion;
        $scope.exerciseHypotheses = [];

        var Conclusion = $resource('/conclusions_json/:conclusionId.json',
            { conclusionId: "@id"},
            { update: { method: 'PUT' }});
        var ExerciseHypotheses = $resource('/exercise_hypotheses_json_index.json');

        $scope.setExerciseHypotheses = function() {
            ExerciseHypotheses.query({"exercise_id": $stateParams.exerciseShowId}, function(data){
                $scope.exerciseHypotheses = data;
            });
        };

        $scope.setExerciseHypotheses();

        $scope.updateConclusion = function() {
            if ($scope.updateConclusionForm.$valid) {
                Conclusion.update({conclusionId: $scope.conclusion.id}, $scope.conclusion, function() {
                    $window.alert("Diagnoosi-alakohdan päivitys onnistui!");
                    $uibModalInstance.close({conclusionRemoved: false});
                }, function() {
                    $window.alert("Diagnoosi-alakohdan päivitys epäonnistui!");
                });
            }
        };

        $scope.deleteConclusion = function() {
            var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa diagnoosi-alakohdan?");

            if (deleteConfirmation) {
                Conclusion.delete({conclusionId: $scope.conclusion.id}, function() {
                    $window.alert("Diagnoosi-alakohdan poistaminen onnistui!");
                    $uibModalInstance.close({conclusionRemoved: true});
                });

            } else {
                $window.alert("Diagnoosi-alakohtaa ei poistettu!");
            }
        };

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);