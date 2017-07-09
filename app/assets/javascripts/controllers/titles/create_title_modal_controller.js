var app = angular.module('diagnoseDiseases');

app.controller("CreateTitleModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', 'bank',
    function($scope, $uibModalInstance, $resource, $window, bank) {

        $scope.newTitle = {
            bank_id: bank.id
        };

        var Title = $resource('/titles.json');

        $scope.createTitle = function() {
            if ($scope.createTitleForm.$valid) {
                Title.save($scope.newTitle,
                    function() {
                        $.notify({
                            message: "Kysymyksen luominen onnistui!"
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
                            message: "Kysymyksen luominen epäonnistui!"
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