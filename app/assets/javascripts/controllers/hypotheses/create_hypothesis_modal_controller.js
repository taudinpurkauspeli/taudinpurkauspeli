var app = angular.module('diagnoseDiseases');

app.controller("CreateHypothesisModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', 'hypothesisGroup',
    function($scope, $uibModalInstance, $resource, $window, hypothesisGroup) {

        $scope.newHypothesis = {
            hypothesis_group_id: hypothesisGroup.id
        };

        var Hypothesis = $resource('/hypotheses.json');

        $scope.createHypothesis = function() {
            if ($scope.createHypothesisForm.$valid) {
                Hypothesis.save($scope.newHypothesis,
                    function() {
                        $window.alert("Diffin luominen onnistui!");
                        $uibModalInstance.close();
                    },
                    function() {
                        $window.alert("Diffin luominen epäonnistui!");
                    }
                );
            }
        };

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);