var app = angular.module('diagnoseDiseases');

app.controller("HypothesisGroupsController", [
    '$scope', '$http', '$location', '$resource', '$window', '$uibModal',
    function($scope, $http, $location, $resource, $window, $uibModal) {
        $scope.hypothesisGroupsAndHypothesesList = [];
        $scope.newHypothesisGroup = {};

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

        $scope.createHypothesisGroup = function() {
            if ($scope.createHypothesisGroupForm.$valid) {
                HypothesisGroup.create($scope.newHypothesisGroup,
                    function() {
                        $scope.createHypothesisGroupForm.$setPristine();
                        $scope.createHypothesisGroupForm.$setUntouched();
                        $scope.updateHypothesisGroupList();
                        $scope.newHypothesisGroup = {};
                        $window.alert("Diffiryhmän luominen onnistui!");
                    },
                    function() {
                        $window.alert("Diffiryhmän luominen epäonnistui!");
                    }
                );
            }
        };

        $scope.updateHypothesis = function () {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'updateHypothesisModal.html',
                controller: 'UpdateHypothesisModalController',
                size: 'lg'
            });

            modalInstance.result.then(function () {
                alert("Diffi päivitettiin onnistuneesti");
            }, function () {
                alert("Diffin päivitys peruttu");
            });
        };


    }
]);

app.controller("UpdateHypothesisModalController", [
    '$scope', '$uibModalInstance',
    function($scope, $uibModalInstance) {
        $scope.confirmUpdate = function () {
            $uibModalInstance.close();
        };

        $scope.cancel = function () {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);