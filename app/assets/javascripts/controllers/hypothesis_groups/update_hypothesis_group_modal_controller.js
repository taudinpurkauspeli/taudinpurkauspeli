var app = angular.module('diagnoseDiseases');

app.controller("UpdateHypothesisGroupModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', 'hypothesisGroup',
    function($scope, $uibModalInstance, $resource, $window, hypothesisGroup) {

        $scope.hypothesisGroup = hypothesisGroup;

        var HypothesisGroup = $resource('/hypothesis_groups/:hypothesisGroupId.json',
            { hypothesisGroupId: "@id"},
            { update: { method: 'PUT' }});

        $scope.deleteHypothesisGroup = function() {
            var deleteConfirmation = $window.confirm("VAROITUS: TÄMÄ OPERAATIO POISTAA KAIKKI TÄMÄN DIFFIRYHMÄN DIFFIT MYÖS CASEISTA! Oletko aivan varma, että haluat poistaa diffiryhmän ja kaikki siihen liittyvät diffit?");

            if (deleteConfirmation) {
                HypothesisGroup.delete({hypothesisGroupId : hypothesisGroup.id}, function() {
                    $.notify({
                        message: "Diffiryhmän poistaminen onnistui!"
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
                    message: "Diffiryhmää '" + hypothesisGroup.name + "' ei poistettu."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            }
        };

        $scope.updateHypothesisGroup = function() {
            if ($scope.updateHypothesisGroupForm.$valid) {
                HypothesisGroup.update({hypothesisGroupId: hypothesisGroup.id}, $scope.hypothesisGroup, function() {
                    $.notify({
                        message: "Diffiryhmän päivitys onnistui!"
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
                        message: "Diffiryhmän päivitys epäonnistui!"
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