var app = angular.module('hypothesisGroups',[ ]);

var HypothesisGroupSearchController = function($scope, $http) {
    $scope.hypothesisGroupsList = [];

    $scope.search = function(searchTerm) {
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