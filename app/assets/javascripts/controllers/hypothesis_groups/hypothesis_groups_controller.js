var app = angular.module('diagnoseDiseases');

app.controller("HypothesisGroupsController", [
    '$scope', '$resource', '$window', '$uibModal',
    function($scope, $resource, $window, $uibModal) {
        $scope.hypothesisGroupsAndHypothesesList = [];

        var HypothesisGroupsAndHypotheses = $resource('/hypothesis_groups_and_hypotheses.json');

        $scope.updateHypothesisGroupList = function(){
            HypothesisGroupsAndHypotheses.query(function(data){
                $scope.hypothesisGroupsAndHypothesesList = data;
            });
        };

        $scope.updateHypothesisGroupList();

        $scope.updateHypothesisGroup = function (hypothesisGroup, callback) {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'hypothesis_groups/update_hypothesis_group_modal.html',
                controller: 'UpdateHypothesisGroupModalController',
                resolve: {
                    hypothesisGroup: hypothesisGroup
                }
            });

            modalInstance.result.then(function () {
                $scope.updateHypothesisGroupList();
                if(callback){
                    callback();
                }
            }, function () {
                $window.alert("Diffiryhmän päivitys peruttu.");
            });
        };

        $scope.createHypothesisGroup = function(){
            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'hypothesis_groups/create_hypothesis_group_modal.html',
                controller: 'CreateHypothesisGroupModalController'
            });

            modalInstance.result.then(function () {
                $scope.updateHypothesisGroupList();
            }, function () {
                $window.alert("Diffiryhmän luominen peruttu.");
            });
        };

        $scope.updateHypothesis = function (hypothesis, callback) {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'hypotheses/update_hypothesis_modal.html',
                controller: 'UpdateHypothesisModalController',
                resolve: {
                    hypothesis: hypothesis
                }
            });

            modalInstance.result.then(function () {
                $scope.updateHypothesisGroupList();
                if(callback){
                    callback();
                }
            }, function () {
                $window.alert("Diffin päivitys peruttu.");
            });
        };

        $scope.createHypothesis = function(hypothesisGroup){
            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'hypotheses/create_hypothesis_modal.html',
                controller: 'CreateHypothesisModalController',
                resolve: {
                    hypothesisGroup: hypothesisGroup
                }
            });

            modalInstance.result.then(function () {
                $scope.updateHypothesisGroupList();
            }, function () {
                $window.alert("Diffin luominen peruttu.");
            });
        };

    }
]);
