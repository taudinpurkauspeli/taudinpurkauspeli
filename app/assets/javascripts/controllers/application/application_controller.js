var app = angular.module('diagnoseDiseases');

app.controller("ApplicationController", [
    "$scope", "AuthenticationService", "LocalStorageService",
    function($scope, AuthenticationService, LocalStorageService) {

        $scope.resetCurrentExercise = function(){
            LocalStorageService.remove("current_task");
            LocalStorageService.remove("current_task_tab_path");
            LocalStorageService.remove("unchecked_hypotheses");
        };

        $scope.navigationLinksList = [
            {state: "app_root",
                title: "Taudinpurkauspeli",
                visibility: "currentUser",
                click: $scope.resetCurrentExercise},
            {state: "users.by_case",
                title: "Käyttäjien seuranta",
                visibility: "currentUserAdmin",
                click: $scope.resetCurrentExercise},
            {state: "users_show({userShowId: currentUser})",
                title: "Omat käyttäjätiedot",
                visibility: "currentUser",
                click: $scope.resetCurrentExercise}
        ];

        $scope.currentUser = AuthenticationService.isLoggedIn();
        $scope.currentUserAdmin = AuthenticationService.isAdmin();

        $scope.setCurrentUser = function (userId, userAdmin) {
            $scope.currentUser = userId;
            $scope.currentUserAdmin = userAdmin;
        };

        $scope.setActiveTab = function(tabId){
            if (tabId != undefined){
                $(".exerciseTabLink").removeClass("active");
                $("#" + tabId).addClass("active");
            }
        };

    }
]);