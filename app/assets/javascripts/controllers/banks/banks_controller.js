var app = angular.module('diagnoseDiseases');

app.controller("BanksController", [
    '$scope', '$resource', '$window', '$uibModal',
    function($scope, $resource, $window, $uibModal) {
        $scope.banksAndTitlesList = [];

        var BanksAndTitles = $resource('/banks_and_titles.json');

        $scope.updateBanksList = function() {
            BanksAndTitles.query(function(data){
                $scope.banksAndTitlesList = data;
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
