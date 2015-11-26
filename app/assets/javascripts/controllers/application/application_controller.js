var app = angular.module('diagnoseDiseases');

app.controller("ApplicationController", [
    "$scope","$http","$routeParams", "$resource", "$location",
    function($scope , $http , $routeParams, $resource, $location) {
        $scope.navigationLinksList = [
            {path: "#/",
            title: "Taudinpurkauspeli"},
            {path: "#/hypothesis_groups",
            title: "Diffiryhmät"}
        ];

    }
]);