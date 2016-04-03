var app = angular.module('diagnoseDiseases');

app.controller("UpdateMultichoiceModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', "multichoice",
    function($scope, $uibModalInstance, $resource, $window, multichoice) {

        $scope.multichoice = multichoice;

        var Multichoice = $resource('/multichoices/:multichoiceId.json',
            { multichoiceId: "@id"},
            { update: { method: 'PUT' }});

        $scope.updateMultichoice = function() {
            if ($scope.updateMultichoiceForm.$valid) {
                Multichoice.update({multichoiceId: $scope.multichoice.id}, $scope.multichoice, function() {
                    $window.alert("Monivalinnan päivitys onnistui!");
                    $uibModalInstance.close({multichoiceRemoved: false});
                }, function() {
                    $window.alert("Monivalinnan päivitys epäonnistui!");
                });
            }
        };

        $scope.deleteMultichoice = function() {
            var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa monivalinta-alakohdan?");

            if (deleteConfirmation) {
                Multichoice.delete({multichoiceId : $scope.multichoice.id}, function() {
                    $window.alert("Monivalinnan poistaminen onnistui!");
                    $uibModalInstance.close({multichoiceRemoved: true});
                });
            } else {
                $window.alert("Monivalintaa ei poistettu!");
            }
        };

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);