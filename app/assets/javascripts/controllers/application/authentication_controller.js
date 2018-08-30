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
                    AuthenticationService.hasAcceptedLicenceAgreement(), AuthenticationService.hasAcceptedAcademicResearch());
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
            console.log("Checking agreements");
            if ($scope.currentUser && !$scope.currentUserAcceptLicenceAgreement){
                var modalInstance = $uibModal.open({
                    animation: true,
                    templateUrl: 'users/update_agreement_modal.html',
                    controller: 'UpdateAgreementModalController',
                    size: 'lg'
                });

                modalInstance.result.then(function() {
                    $state.go('app_root');
                }, function() {
                    $scope.logout();
                });
            } else {
                $state.go('app_root');
            }
        };

        $scope.login = function(credentials) {
            AuthenticationService.login(credentials).$promise.then(function onSuccess() {
                $scope.setCurrentUser(AuthenticationService.isLoggedIn(), AuthenticationService.isAdmin(), AuthenticationService.isTester(),
                    AuthenticationService.hasAcceptedLicenceAgreement(), AuthenticationService.hasAcceptedAcademicResearch());
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
