var app = angular.module('hypothesisGroups',[ "ngRoute" ]);

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