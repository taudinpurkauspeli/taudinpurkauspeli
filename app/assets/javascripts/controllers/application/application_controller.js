var app = angular.module('diagnoseDiseases');

app.controller("ApplicationController", [
    "$scope", "AuthenticationService", "LocalStorageService",
    function($scope, AuthenticationService, LocalStorageService) {

        $scope.resetCurrentExercise = function(){
            LocalStorageService.remove("current_task");
            LocalStorageService.remove("current_task_tab_path");
        };

        $scope.navigationLinksList = [
            {state: "app_root",
                title: "Taudinpurkauspeli",
                visibility: "currentUser",
                click: $scope.resetCurrentExercise},
            {state: "users.all",
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