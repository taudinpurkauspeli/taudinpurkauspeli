var app = angular.module('diagnoseDiseases');

app.controller("CreateHypothesisGroupModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window',
    function($scope, $uibModalInstance, $resource, $window) {

        $scope.newHypothesisGroup = {};

        var HypothesisGroup = $resource('/hypothesis_groups.json');

        $scope.createHypothesisGroup = function() {
            if ($scope.createHypothesisGroupForm.$valid) {
                HypothesisGroup.save($scope.newHypothesisGroup,
                    function() {
                        $window.alert("Diffiryhmän luominen onnistui!");
                        $uibModalInstance.close();
                    },
                    function() {
                        $window.alert("Diffiryhmän luominen epäonnistui!");
                    }
                );
            }
        };

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);