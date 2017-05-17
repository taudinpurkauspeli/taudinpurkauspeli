var app = angular.module('diagnoseDiseases');

app.controller("UpdateBankModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', 'bank',
    function($scope, $uibModalInstance, $resource, $window, bank) {

        $scope.bank = bank;

        var Bank = $resource('/banks/:bankId.json',
            { bankId: "@id"},
            { update: { method: 'PUT' }});

        $scope.deleteBank = function() {
            var deleteConfirmation = $window.confirm("VAROITUS: TÄMÄ OPERAATIO POISTAA KAIKKI TÄMÄN KYSYMYSPANKIN KYSYMYKSET MYÖS POHDINNOISTA!" +
                " Oletko aivan varma, että haluat poistaa kysymyspankin ja kaikki siihen liittyvät kysymykset?");

            if (deleteConfirmation) {
                Bank.delete({bankId: bank.id}, function() {
                    $.notify({
                        message: "Kysymyspankin poistaminen onnistui!"
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
                    message: "Kysymyspankkia '" + bank.name + "' ei poistettu."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            }
        };

        $scope.updateBank = function() {
            if ($scope.updateBankForm.$valid) {
                Bank.update({bankId: bank.id}, $scope.bank, function() {
                    $.notify({
                        message: "Kysymyspankin päivitys onnistui!"
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
                        message: "Kysymyspankin päivitys epäonnistui!"
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