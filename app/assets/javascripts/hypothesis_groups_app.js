var app = angular.module('hypothesisGroups',[ 'ngRoute','templates' ]);

app.config([
    "$routeProvider",
    function($routeProvider) {
        $routeProvider.when("/", {
            controller: "HypothesisGroupSearchController",
            templateUrl: "hypothesis_groups_search.html"
        });
    }
]);


var HypothesisGroupSearchController = function($scope, $http) {
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

};

app.controller("HypothesisGroupSearchController",
    [ "$scope", "$http", HypothesisGroupSearchController ]
);