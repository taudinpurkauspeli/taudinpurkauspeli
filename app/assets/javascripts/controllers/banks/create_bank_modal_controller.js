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
                        $.notify({
                            message: "Diffiryhmän luominen onnistui!"
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
                            message: "Diffiryhmän luominen epäonnistui!"
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