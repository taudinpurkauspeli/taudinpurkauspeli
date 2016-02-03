var app = angular.module('diagnoseDiseases');

app.controller("HypothesisGroupsController", [
    '$scope', '$http', '$location', '$resource', '$window', '$uibModal',
    function($scope, $http, $location, $resource, $window, $uibModal) {
        $scope.hypothesisGroupsAndHypothesesList = [];

        var HypothesisGroupsAndHypotheses = $resource('/hypothesis_groups_and_hypotheses.json');

        $scope.updateHypothesisGroupList = function(){
            HypothesisGroupsAndHypotheses.query(function(data){
                $scope.hypothesisGroupsAndHypothesesList = data;
            });
        };

        $scope.updateHypothesisGroupList();

        $scope.updateHypothesisGroup = function (hypothesisGroup) {

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
            }, function () {
                alert("Diffiryhmän päivitys peruttu.");
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
                alert("Diffiryhmän luominen peruttu.");
            });
        };

        $scope.updateHypothesis = function (hypothesis) {

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
            }, function () {
                alert("Diffin päivitys peruttu.");
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
                alert("Diffin luominen peruttu.");
            });
        };

    }
]);
