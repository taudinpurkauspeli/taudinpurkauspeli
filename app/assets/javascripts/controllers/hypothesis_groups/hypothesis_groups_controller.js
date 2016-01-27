var app = angular.module('diagnoseDiseases');

app.controller("HypothesisGroupsController", [
    '$scope', '$http', '$location', '$resource', '$window',
    function($scope, $http, $location, $resource, $window) {
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

    }
]);