var app = angular.module('hypothesisGroups',[ 'ngRoute','templates', 'ngResource', 'ngMessages' ]);

app.config([
    "$routeProvider",
    function($routeProvider) {
        $routeProvider.when("/", {
            controller: "HypothesisGroupSearchController",
            templateUrl: "hypothesis_groups_search.html"
        }).when("/:id",{
            controller: "HypothesisGroupShowController",
            templateUrl: "hypothesis_group_show.html"
        });
    }
]);


var HypothesisGroupSearchController = function($scope, $http, $location) {
    $scope.hypothesisGroupsList = [];

    $scope.search = function(searchTerm) {

        if(searchTerm.length < 2){
            return;
        };

        $http.get("/hypothesis_groups.json",
            { "params": { "hypothesisGroupName": searchTerm } }
        ).success(
            function(data,status,headers,config) {
                $scope.hypothesisGroupsList = data;
            }).error(
            function(data,status,headers,config) {
                alert("Jotakin odottamatonta kävi: " + status);
            });
    };

    $scope.viewHypothesisGroup = function(hypothesisGroup) {
        $location.path("/" + hypothesisGroup.id);
    }

};

app.controller("HypothesisGroupSearchController",
    [ '$scope', '$http', '$location', HypothesisGroupSearchController ]
);


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