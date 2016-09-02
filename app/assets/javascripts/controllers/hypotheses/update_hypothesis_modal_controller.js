var app = angular.module('diagnoseDiseases');

app.controller("UpdateHypothesisModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', 'hypothesis',
    function($scope, $uibModalInstance, $resource, $window, hypothesis) {

        $scope.hypothesis = hypothesis;

        var Hypothesis = $resource('/hypotheses/:hypothesisId.json',
            { hypothesisId: "@id"},
            { update: { method: 'PUT' }});

        $scope.deleteHypothesis = function() {
            var deleteConfirmation = $window.confirm("VAROITUS: TÄMÄ OPERAATIO POISTAA TÄMÄN DIFFIN MYÖS CASEISTA! Oletko aivan varma, että haluat poistaa diffin ja sen kaikki caseihin liittyvät diffit?");

            if (deleteConfirmation) {
                Hypothesis.delete({hypothesisId : hypothesis.id}, function() {
                    $.notify({
                        message: "Diffin poistaminen onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                    $uibModalInstance.close();
                });
            } else {
                $.notify({
                    message: "Diffiä '" + hypothesis.name + "' ei poistettu."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            }
        };

        $scope.updateHypothesis = function() {
            if ($scope.updateHypothesisForm.$valid) {
                Hypothesis.update({hypothesisId: hypothesis.id}, $scope.hypothesis, function() {
                    $.notify({
                        message: "Diffin päivitys onnistui!"
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
                        message: "Diffin päivitys epäonnistui!"
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