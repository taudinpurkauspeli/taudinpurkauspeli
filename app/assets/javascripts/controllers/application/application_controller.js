var app = angular.module('diagnoseDiseases');

app.controller('ApplicationController', [
    '$scope', 'AuthenticationService', 'LocalStorageService',
    function($scope, AuthenticationService, LocalStorageService) {

        $scope.navbarCollapsed = true;

        $scope.resetCurrentExercise = function(){
            LocalStorageService.remove('current_task');
            LocalStorageService.remove('current_task_tab_path');
            LocalStorageService.remove('unchecked_hypotheses');
        };

        $scope.navigationLinksList = [
            {state: 'users.by_case',
                title: 'Käyttäjien seuranta',
                visibility: 'currentUserAdmin',
                click: $scope.resetCurrentExercise},
            {state: 'documents',
                title: 'Tiedostopankki',
                visibility: 'currentUserAdmin',
                click: $scope.resetCurrentExercise},
            {state: 'users_show({userShowId: currentUser})',
                title: 'Omat käyttäjätiedot',
                visibility: 'currentUser',
                click: $scope.resetCurrentExercise}
        ];

        $scope.currentUser = AuthenticationService.isLoggedIn();
        $scope.currentUserAdmin = AuthenticationService.isAdmin();
        $scope.currentUserAcceptLicenceAgreement = AuthenticationService.hasAcceptedLicenceAgreement();
        $scope.currentUserAcceptAcademicResearch = AuthenticationService.hasAcceptedAcademicResearch();
        $scope.currentUserAcceptAcademicUse = AuthenticationService.hasAcceptedAcademicUse();

        $scope.setCurrentUser = function (userId, userAdmin, userTester, userAcceptLicenceAgreement, userAcceptAcademicResearch, userAcceptAcademicUse) {
            $scope.currentUser = userId;
            $scope.currentUserAdmin = userAdmin;
            $scope.currentUserTester = userTester;
            $scope.currentUserAcceptLicenceAgreement = userAcceptLicenceAgreement;
            $scope.currentUserAcceptAcademicResearch = userAcceptAcademicResearch;
            $scope.currentUserAcceptAcademicUse = userAcceptAcademicUse;
        };

        $scope.setActiveTab = function(tabId){
            if (tabId !== undefined){
                $('.exerciseTabLink').removeClass('active');
                $('#' + tabId).addClass('active');
            }
        };

    }
]);