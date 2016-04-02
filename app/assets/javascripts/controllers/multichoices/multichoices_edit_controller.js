var app = angular.module('diagnoseDiseases');

app.controller("MultichoicesEditController", [
    "$scope", "$resource", "$window", "$uibModal",
    function($scope, $resource, $window, $uibModal) {

        $scope.updateMultichoice = function(multichoice) {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'multichoices/update_multichoice_modal.html',
                controller: 'UpdateMultichoiceModalController',
                size: 'lg',
                resolve: {
                    multichoice: multichoice
                }
            });

            modalInstance.result.then(function(data) {
                $scope.setTask();
                if(data.multichoiceRemoved){
                    $scope.returnToTask();
                }
            }, function() {
                $window.alert("Monivalinnan päivitys peruttu.");
            });

        };

    }
]);