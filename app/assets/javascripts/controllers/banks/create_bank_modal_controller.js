var app = angular.module('diagnoseDiseases');

app.controller("CreateBankModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window',
    function($scope, $uibModalInstance, $resource, $window) {

        $scope.newBank = {};

        var Bank = $resource('/banks.json');

        $scope.createBank = function() {
            if ($scope.createBankForm.$valid) {
                Bank.save($scope.newBank,
                    function() {
                        $.notify({
                            message: "Kysymyspankin luominen onnistui!"
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
                            message: "Kysymyspankin luominen epäonnistui!"
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