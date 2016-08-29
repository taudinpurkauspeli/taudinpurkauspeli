var app = angular.module('diagnoseDiseases');

app.controller("AuthenticationController", [
    "$scope", "AuthenticationService", "$window", "LocalStorageService", "$state",
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
            AuthenticationService.login(credentials).success(function() {
                $scope.setCurrentUser(AuthenticationService.isLoggedIn(), AuthenticationService.isAdmin());
                $scope.resetCredentials();
                $state.go('app_root');
            }).error(function() {
                $scope.resetCredentials();
            });
        };

        $scope.logout = function() {
            AuthenticationService.logout().success(function() {
                $scope.setCurrentUser(AuthenticationService.isLoggedIn(), AuthenticationService.isAdmin());
                LocalStorageService.remove("current_task");
                LocalStorageService.remove("current_task_tab_path");
                LocalStorageService.remove("unchecked_hypotheses");
                $window.alert("Uloskirjautuminen onnistui");
            }).error(function() {
                $window.alert("Uloskirjautuminen epäonnistui");
            });
        }

    }
]);