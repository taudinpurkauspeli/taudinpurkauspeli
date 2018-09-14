var app = angular.module('diagnoseDiseases');

app.controller('AuthenticationController', [
    '$scope', 'AuthenticationService', '$window', 'LocalStorageService', '$state', '$uibModal',
    function($scope, AuthenticationService, $window, LocalStorageService, $state, $uibModal) {

        $scope.credentials = {};

        $scope.resetCredentials = function() {
            $scope.credentials = {
                username: '',
                password: ''
            };
        };

        $scope.logout = function() {
            AuthenticationService.logout().$promise.then(function onSuccess() {
                $scope.setCurrentUser(AuthenticationService.isLoggedIn(), AuthenticationService.isAdmin(), AuthenticationService.isTester(),
                    AuthenticationService.hasAcceptedLicenceAgreement(), AuthenticationService.hasAcceptedAcademicResearch(),
                    AuthenticationService.hasAcceptedAcademicUse());
                LocalStorageService.remove('current_task');
                LocalStorageService.remove('current_task_tab_path');
                LocalStorageService.remove('unchecked_hypotheses');
                $.notify({
                    message: 'Uloskirjautuminen onnistui!'
                }, {
                    placement: {
                        align: 'center'
                    },
                    type: 'success',
                    offset: 100
                });
            }).catch(function onError() {
                $.notify({
                    message: 'Uloskirjautuminen epäonnistui!'
                }, {
                    placement: {
                        align: 'center'
                    },
                    type: 'danger',
                    offset: 100
                });
            });
        };

        $scope.checkAgreements = function() {
            if ($scope.currentUser && !$scope.currentUserAcceptLicenceAgreement){
                var user = {
                    id: AuthenticationService.isLoggedIn(),
                    accept_licence_agreement: AuthenticationService.hasAcceptedLicenceAgreement(),
                    accept_academic_research: AuthenticationService.hasAcceptedAcademicResearch(),
                    accept_academic_use: AuthenticationService.hasAcceptedAcademicUse()
                };

                var modalInstance = $uibModal.open({
                    animation: true,
                    templateUrl: 'users/update_agreement_modal.html',
                    controller: 'UpdateAgreementModalController',
                    size: 'lg',
                    resolve: {
                        user: user
                    }
                });

                modalInstance.result.then(function() {
                    $state.go('app_root');
                }, function() {
                    $scope.logout();
                });
            } else {
                $state.go($state.current);
            }
        };

        $scope.login = function(credentials) {
            AuthenticationService.login(credentials).$promise.then(function onSuccess() {
                $scope.setCurrentUser(AuthenticationService.isLoggedIn(), AuthenticationService.isAdmin(), AuthenticationService.isTester(),
                    AuthenticationService.hasAcceptedLicenceAgreement(), AuthenticationService.hasAcceptedAcademicResearch(),
                    AuthenticationService.hasAcceptedAcademicUse());
                $scope.resetCredentials();
                $scope.checkAgreements();
            }).catch(function onError() {
                $scope.resetCredentials();
            });
        };

        $scope.resetCredentials();
        $scope.checkAgreements();

    }
]);
