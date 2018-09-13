var app = angular.module('diagnoseDiseases');

app.controller("TermsOfUseModalController", [
    '$scope', '$uibModalInstance',
    function($scope, $uibModalInstance) {

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);