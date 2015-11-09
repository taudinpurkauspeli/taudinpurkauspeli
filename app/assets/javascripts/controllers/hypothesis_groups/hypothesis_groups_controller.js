var app = angular.module('diagnoseDiseases');

var HypothesisGroupsController = function($scope, $http, $location) {
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
        $location.path("hypothesis_groups/" + hypothesisGroup.id);
    };

};

app.controller("HypothesisGroupsController",
    [ '$scope', '$http', '$location', HypothesisGroupsController ]
);