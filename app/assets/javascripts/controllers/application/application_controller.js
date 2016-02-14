var app = angular.module('diagnoseDiseases');

app.controller("ApplicationController", [
    "$scope", "AuthenticationService", "LocalStorageService",
    function($scope, AuthenticationService, LocalStorageService) {

        $scope.resetCurrentExercise = function(){
            LocalStorageService.remove("current_tab");
        };

        $scope.navigationLinksList = [
            {state: "app_root",
                title: "Taudinpurkauspeli",
                visibility: "currentUser",
                click: $scope.resetCurrentExercise},
            {state: "hypothesis_groups",
                title: "Diffiryhmät",
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