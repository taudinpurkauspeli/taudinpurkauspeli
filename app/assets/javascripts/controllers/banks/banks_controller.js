var app = angular.module('diagnoseDiseases');

app.controller("BanksController", [
    '$scope', '$resource', '$window', '$uibModal',
    function($scope, $resource, $window, $uibModal) {
        $scope.banksList = [];

        var Banks = $resource('/banks.json');
        var Titles = $resource('/banks/:bankId/titles.json');

        var setSelectedBank = function(data) {
            var bankFound = false;
            angular.forEach(data, function (bank) {
                if (bank.id === $scope.selectedBank.id) {
                    $scope.selectedBank = bank;
                    bankFound = true;
                }
            });

            if (!bankFound) {
                $scope.selectedBank = data[0];
            }
        };

        $scope.updateBanksList = function() {
            Banks.query(function onSuccess(data){
                $scope.banksList = data;

                if (data.length > 0) {
                    if (!$scope.selectedBank) {
                        $scope.selectedBank = data[0];
                    } else {
                        setSelectedBank(data);
                    }
                }

            }, function onError() {
            });
        };

        $scope.updateBanksList();

        $scope.updateBank = function(bank, callback) {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'banks/update_bank_modal.html',
                controller: 'UpdateBankModalController',
                size: 'lg',
                resolve: {
                    bank: bank
                }
            });

            modalInstance.result.then(function() {
                $scope.updateBanksList();
                if (callback){
                    callback();
                }
            }, function() {
            });
        };

        $scope.$watch(function() {
            return $scope.selectedBank;
        }, function(newSelectedBank) {
            if (newSelectedBank) {
                Titles.query({bankId: newSelectedBank.id}, function(data) {
                    newSelectedBank.titles = data;
                }, function() {
                });
            }
            $scope.selectedBank = newSelectedBank;
        });

        $scope.createBank = function() {
            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'banks/create_bank_modal.html',
                controller: 'CreateBankModalController',
                size: 'lg'
            });

            modalInstance.result.then(function() {
                $scope.updateBanksList();
            }, function() {
            });
        };

        $scope.updateTitle = function(title, callback) {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'titles/update_title_modal.html',
                controller: 'UpdateTitleModalController',
                size: 'lg',
                resolve: {
                    title: title
                }
            });

            modalInstance.result.then(function() {
                $scope.updateBanksList();
                if (callback){
                    callback();
                }
            }, function() {
            });
        };

        $scope.createTitle = function(bank) {
            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'titles/create_title_modal.html',
                controller: 'CreateTitleModalController',
                size: 'lg',
                resolve: {
                    bank: bank
                }
            });

            modalInstance.result.then(function() {
                $scope.updateBanksList();
            }, function() {
            });
        };

    }
]);
