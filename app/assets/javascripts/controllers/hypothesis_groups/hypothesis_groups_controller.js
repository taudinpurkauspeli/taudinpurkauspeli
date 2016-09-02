var app = angular.module('diagnoseDiseases');

app.controller("HypothesisGroupsController", [
    '$scope', '$resource', '$window', '$uibModal',
    function($scope, $resource, $window, $uibModal) {
        $scope.hypothesisGroupsAndHypothesesList = [];

        var HypothesisGroupsAndHypotheses = $resource('/hypothesis_groups_and_hypotheses.json');

        $scope.updateHypothesisGroupList = function() {
            HypothesisGroupsAndHypotheses.query(function(data){
                $scope.hypothesisGroupsAndHypothesesList = data;
            });
        };

        $scope.updateHypothesisGroupList();

        $scope.updateHypothesisGroup = function(hypothesisGroup, callback) {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'hypothesis_groups/update_hypothesis_group_modal.html',
                controller: 'UpdateHypothesisGroupModalController',
                resolve: {
                    hypothesisGroup: hypothesisGroup
                }
            });

            modalInstance.result.then(function() {
                $scope.updateHypothesisGroupList();
                if(callback){
                    callback();
                }
            }, function() {
                $.notify({
                    message: "Diffiryhmän päivitys peruttu."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            });
        };

        $scope.createHypothesisGroup = function() {
            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'hypothesis_groups/create_hypothesis_group_modal.html',
                controller: 'CreateHypothesisGroupModalController'
            });

            modalInstance.result.then(function() {
                $scope.updateHypothesisGroupList();
            }, function() {
                $.notify({
                    message: "Diffiryhmän luominen peruttu."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            });
        };

        $scope.updateHypothesis = function(hypothesis, callback) {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'hypotheses/update_hypothesis_modal.html',
                controller: 'UpdateHypothesisModalController',
                resolve: {
                    hypothesis: hypothesis
                }
            });

            modalInstance.result.then(function() {
                $scope.updateHypothesisGroupList();
                if(callback){
                    callback();
                }
            }, function() {
                $.notify({
                    message: "Diffin päivitys peruttu."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            });
        };

        $scope.createHypothesis = function(hypothesisGroup) {
            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'hypotheses/create_hypothesis_modal.html',
                controller: 'CreateHypothesisModalController',
                resolve: {
                    hypothesisGroup: hypothesisGroup
                }
            });

            modalInstance.result.then(function() {
                $scope.updateHypothesisGroupList();
            }, function() {
                $.notify({
                    message: "Diffin luominen peruttu."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            });
        };

    }
]);
