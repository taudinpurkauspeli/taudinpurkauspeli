var app = angular.module('diagnoseDiseases');

app.controller("ApplicationController", [
    "$scope", "AuthenticationService", "LocalStorageService",
    function($scope, AuthenticationService, LocalStorageService) {

        $scope.resetCurrentExercise = function(){
            LocalStorageService.remove("current_tab");
        };

        $scope.navigationLinksList = [
            {path: "#/",
                title: "Taudinpurkauspeli",
                loggedIn: true,
                visibility: "currentUser",
                click: $scope.resetCurrentExercise},
            {path: "#/hypothesis_groups",
                title: "Diffiryhmät",
                loggedIn: true,
                visibility: "currentUserAdmin",
                click: $scope.resetCurrentExercise}
        ];

        $scope.currentUser = AuthenticationService.isLoggedIn();
        $scope.currentUserAdmin = AuthenticationService.isAdmin();

        $scope.setCurrentUser = function (userId, userAdmin) {
            $scope.currentUser = userId;
            $scope.currentUserAdmin = userAdmin;
        };

    }
]);