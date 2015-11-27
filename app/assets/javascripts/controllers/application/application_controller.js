var app = angular.module('diagnoseDiseases');

app.controller("ApplicationController", [
    "$scope","$http","$routeParams", "$resource", "$location", "USER_ROLES", "AuthenticationService",
    function($scope , $http , $routeParams, $resource, $location, USER_ROLES, AuthenticationService) {
        $scope.navigationLinksList = [
            {path: "#/",
            title: "Taudinpurkauspeli"},
            {path: "#/hypothesis_groups",
            title: "Diffiryhmät"}
        ];

        $scope.currentUser = null;
        //$scope.userRoles = USER_ROLES;

        $scope.setCurrentUser = function (user) {
            $scope.currentUser = user;
        };

    }
]);