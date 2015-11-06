var app = angular.module('hypothesisGroups',[ 'ngRoute','templates', 'ngResource' ]);

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
    "$scope","$http","$routeParams",
    function($scope , $http , $routeParams) {
        var hypothesisGroupId = $routeParams.id;
        $scope.hypothesisGroup = {};
        $http.get(
            "/hypothesis_groups/" + hypothesisGroupId + ".json"
        ).success(function(data,status,headers,config) {
                $scope.hypothesisGroup = data;
            }).error(function(data,status,headers,config) {
                alert("Etsimääsi diffiryhmää ei löytynyt: " + status);
            });
    }
]);