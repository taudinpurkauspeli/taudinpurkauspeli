var app = angular.module('diagnoseDiseases');

app.controller("ApplicationController", [
    "$scope","$http","$stateParams", "$resource", "$location", "AuthenticationService",
    function($scope , $http , $stateParams, $resource, $location, AuthenticationService) {
        $scope.navigationLinksList = [
            {path: "#/",
                title: "Taudinpurkauspeli",
                loggedIn: true,
                visibility: "currentUser"},
            {path: "#/hypothesis_groups",
                title: "Diffiryhmät",
                loggedIn: true,
                visibility: "currentUserAdmin"}
        ];

        $scope.currentUser = AuthenticationService.isLoggedIn();
        $scope.currentUserAdmin = AuthenticationService.isAdmin();

        $scope.setCurrentUser = function (userId, userAdmin) {
            $scope.currentUser = userId;
            $scope.currentUserAdmin = userAdmin;
        };

    }
]);