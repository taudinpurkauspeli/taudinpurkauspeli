var app = angular.module('diagnoseDiseases');

app.controller("ApplicationController", [
    "$scope", "AuthenticationService", "LocalStorageService",
    function($scope, AuthenticationService, LocalStorageService) {

        $scope.resetCurrentExercise = function(){
            LocalStorageService.remove("current_task");
        };

        $scope.navigationLinksList = [
            {state: "app_root",
                title: "Taudinpurkauspeli",
                visibility: "currentUser",
                click: $scope.resetCurrentExercise},
            {state: "users",
                title: "Opiskelijoiden seuranta",
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