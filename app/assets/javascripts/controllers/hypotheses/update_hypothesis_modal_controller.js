var app = angular.module('diagnoseDiseases');

app.controller("UpdateHypothesisModalController", [
    '$scope', '$uibModalInstance', 'hypothesis',
    function($scope, $uibModalInstance, hypothesis) {

        $scope.hypothesis = hypothesis;

        $scope.confirmUpdate = function () {
            $uibModalInstance.close();
        };

        $scope.cancel = function () {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);