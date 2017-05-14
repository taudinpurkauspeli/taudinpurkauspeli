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
                        $.notify({
                            message: "Diffin luominen onnistui!"
                        }, {
                            placement: {
                                align: "center"
                            },
                            type: "success",
                            offset: 100
                        });
                        $uibModalInstance.close();
                    },
                    function() {
                        $.notify({
                            message: "Diffin luominen epäonnistui!"
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

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);