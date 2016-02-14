var app = angular.module('diagnoseDiseases');

app.controller("UpdateHypothesisModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', 'hypothesis',
    function($scope, $uibModalInstance, $resource, $window, hypothesis) {

        $scope.hypothesis = hypothesis;

        var Hypothesis = $resource('/hypotheses/:hypothesisId.json',
            { hypothesisId: "@id"},
            { update: { method: 'PUT' }});

        $scope.deleteHypothesis = function() {
            var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa diffin ja sen kaikki caseihin liittyvät diffit?");

            if (deleteConfirmation) {
                Hypothesis.delete({hypothesisId : hypothesis.id}, function() {
                    $window.alert("Diffin poistaminen onnistui!");
                    $uibModalInstance.close();
                });

            } else {
                $window.alert("Diffiä '" + hypothesis.name + "' ei poistettu");
            }
        };

        $scope.updateHypothesis = function() {
            if ($scope.updateHypothesisForm.$valid) {
                Hypothesis.update({hypothesisId: hypothesis.id}, $scope.hypothesis, function(){
                    $window.alert("Diffin päivitys onnistui!");
                    $uibModalInstance.close();
                }, function() {
                    $window.alert("Diffin päivitys epäonnistui!");
                });
            }
        };

        $scope.cancel = function () {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);