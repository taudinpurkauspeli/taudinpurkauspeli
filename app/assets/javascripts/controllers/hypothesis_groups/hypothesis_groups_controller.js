var app = angular.module('diagnoseDiseases');

app.controller("HypothesisGroupsController", [
    '$scope', '$http', '$location', '$resource', '$window', '$uibModal',
    function($scope, $http, $location, $resource, $window, $uibModal) {
        $scope.hypothesisGroupsAndHypothesesList = [];

        var HypothesisGroupsAndHypotheses = $resource('/hypothesis_groups_and_hypotheses.json');
        var HypothesisGroup = $resource('/hypothesis_groups/:hypothesisGroupId.json',
            {"hypothesisGroupId": "@id"},
            { "create": { "method": "POST" }});

        $scope.updateHypothesisGroupList = function(){
            HypothesisGroupsAndHypotheses.query(function(data){
                $scope.hypothesisGroupsAndHypothesesList = data;
            });
        };

        $scope.updateHypothesisGroupList();

        $scope.viewHypothesisGroup = function(hypothesisGroup) {
            $location.path("hypothesis_groups/" + hypothesisGroup.id);
        };

        $scope.deleteHypothesisGroup = function(hypothesisGroup) {
            var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa diffiryhmän ja kaikki siihen liittyvät diffit?");

            if (deleteConfirmation) {
                HypothesisGroup.delete({hypothesisGroupId : hypothesisGroup.id}, function() {
                    $window.alert("Diffiryhmän poistaminen onnistui!");
                    $scope.updateHypothesisGroupList();
                });

            } else {
                $window.alert("Diffiryhmää '" + hypothesisGroup.name + "' ei poistettu");
            }
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
                alert("Diffiryhmän luominen peruttu");
            });
        };

        $scope.updateHypothesis = function (hypothesis) {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'hypotheses/update_hypothesis_modal.html',
                controller: 'UpdateHypothesisModalController',
                size: 'lg',
                resolve: {
                    hypothesis: hypothesis
                }
            });

            modalInstance.result.then(function () {
                alert("Diffi päivitettiin onnistuneesti");
            }, function () {
                alert("Diffin päivitys peruttu");
            });
        };

    }
]);
