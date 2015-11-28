var app = angular.module('diagnoseDiseases');

app.controller("ApplicationController", [
    "$scope","$http","$routeParams", "$resource", "$location", "USER_ROLES", "AuthenticationService",
    function($scope , $http , $routeParams, $resource, $location, AuthenticationService) {
        $scope.navigationLinksList = [
            {path: "#/",
            title: "Taudinpurkauspeli"},
            {path: "#/hypothesis_groups",
            title: "Diffiryhmät"}
        ];

        $scope.currentUser = AuthenticationService.isLoggedIn();
        $scope.currentUserAdmin = AuthenticationService.isAdmin();

        $scope.setCurrentUser = function (userId, userAdmin) {
            $scope.currentUser = userId;
            $scope.currentUserAdmin = userAdmin;
        };

    }
]);