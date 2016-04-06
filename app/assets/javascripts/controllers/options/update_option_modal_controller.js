var app = angular.module('diagnoseDiseases');

app.controller("UpdateOptionModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', "option",
    function($scope, $uibModalInstance, $resource, $window, option) {

        $scope.option = option;

        var Option = $resource('/options/:optionId.json',
            { optionId: "@id"},
            { update: { method: 'PUT' }});

        $scope.updateOption = function() {
            if ($scope.updateOptionForm.$valid) {
                Option.update({optionId: $scope.option.id}, $scope.option, function() {
                    $window.alert("Vastausvaihtoehdon päivitys onnistui!");
                    $uibModalInstance.close();
                }, function() {
                    $window.alert("Vastausvaihtoehdon päivitys epäonnistui!");
                });
            }
        };

        $scope.deleteOption = function() {
            var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa vastausvaihtoehdon?");

            if (deleteConfirmation) {
                Option.delete({optionId: $scope.option.id}, function() {
                    $window.alert("Vastausvaihtoehdon poistaminen onnistui!");
                    $uibModalInstance.close();
                });

            } else {
                $window.alert("Vastausvaihtoehtoa ei poistettu");
            }
        };

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);