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
                size: 'lg',
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
            });
        };

        $scope.createHypothesisGroup = function() {
            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'hypothesis_groups/create_hypothesis_group_modal.html',
                controller: 'CreateHypothesisGroupModalController',
                size: 'lg'
            });

            modalInstance.result.then(function() {
                $scope.updateHypothesisGroupList();
            }, function() {
            });
        };

        $scope.updateHypothesis = function(hypothesis, callback) {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'hypotheses/update_hypothesis_modal.html',
                controller: 'UpdateHypothesisModalController',
                size: 'lg',
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
            });
        };

        $scope.createHypothesis = function(hypothesisGroup) {
            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'hypotheses/create_hypothesis_modal.html',
                controller: 'CreateHypothesisModalController',
                size: 'lg',
                resolve: {
                    hypothesisGroup: hypothesisGroup
                }
            });

            modalInstance.result.then(function() {
                $scope.updateHypothesisGroupList();
            }, function() {
            });
        };

    }
]);
