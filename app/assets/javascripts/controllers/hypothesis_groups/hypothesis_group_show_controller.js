var app = angular.module('diagnoseDiseases');

app.controller("HypothesisGroupShowController", [
    "$scope","$http","$routeParams", "$resource",
    function($scope , $http , $routeParams, $resource) {
        var hypothesisGroupId = $routeParams.id;
        var HypothesisGroup = $resource('/hypothesis_groups/:hypothesisGroupId.json',
            {"hypothesisGroupId": "@id"},
            { "save": { "method": "PUT" }});

        $scope.hypothesisGroup = HypothesisGroup.get({"hypothesisGroupId" : hypothesisGroupId});

        $scope.updateHypothesisGroup = function() {
            if ($scope.updateHypothesisGroupForm.$valid) {
                $scope.hypothesisGroup.$save(
                    function() {
                        $scope.updateHypothesisGroupForm.$setPristine();
                        $scope.updateHypothesisGroupForm.$setUntouched();
                        alert("Diffiryhmän päivitys onnistui!");
                    },
                    function() {
                        alert("Diffiryhmän päivitys epäonnistui!");
                    }
                );
            }
        };

        //$scope.hypothesisGroup = {};
        //$http.get(
        //    "/hypothesis_groups/" + hypothesisGroupId + ".json"
        //).success(function(data,status,headers,config) {
        //        $scope.hypothesisGroup = data;
        //    }).error(function(data,status,headers,config) {
        //        alert("Etsimääsi diffiryhmää ei löytynyt: " + status);
        //    });
    }
]);