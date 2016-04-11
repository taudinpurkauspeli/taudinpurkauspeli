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
                    $window.alert("Diffiryhmän poistaminen onnistui!");
                    $uibModalInstance.close();
                });

            } else {
                $window.alert("Diffiryhmää '" + hypothesisGroup.name + "' ei poistettu");
            }
        };

        $scope.updateHypothesisGroup = function() {
            if ($scope.updateHypothesisGroupForm.$valid) {
                HypothesisGroup.update({hypothesisGroupId: hypothesisGroup.id}, $scope.hypothesisGroup, function() {
                    $window.alert("Diffiryhmän päivitys onnistui!");
                    $uibModalInstance.close();
                }, function() {
                    $window.alert("Diffiryhmän päivitys epäonnistui!");
                });
            }
        };

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);