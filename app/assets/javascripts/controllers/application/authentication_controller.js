var app = angular.module('diagnoseDiseases');

app.controller('AuthenticationController', [
    '$scope', 'AuthenticationService', '$window', 'LocalStorageService', '$state',
    function($scope, AuthenticationService, $window, LocalStorageService, $state) {

        $scope.credentials = {};

        $scope.resetCredentials = function() {
            $scope.credentials = {
                username: '',
                password: ''
            };
        };

        $scope.resetCredentials();

        $scope.login = function(credentials) {
            AuthenticationService.login(credentials).$promise.then(function onSuccess() {
                $scope.setCurrentUser(AuthenticationService.isLoggedIn(), AuthenticationService.isAdmin(), AuthenticationService.isTester());
                $scope.resetCredentials();
                $state.go('app_root');
            }).catch(function onError() {
                $scope.resetCredentials();
            });
        };

        $scope.logout = function() {
            AuthenticationService.logout().$promise.then(function onSuccess() {
                $scope.setCurrentUser(AuthenticationService.isLoggedIn(), AuthenticationService.isAdmin(), AuthenticationService.isTester());
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

    }
]);
