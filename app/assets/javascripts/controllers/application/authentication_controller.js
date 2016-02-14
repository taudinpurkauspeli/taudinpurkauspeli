var app = angular.module('diagnoseDiseases');

app.controller("AuthenticationController", [
    "$scope", "AuthenticationService", "$window",
    function($scope, AuthenticationService, $window) {

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
            }).error(function() {
                $scope.resetCredentials();
            });
        };

        $scope.logout = function() {
            AuthenticationService.logout().success(function() {
                $scope.setCurrentUser(AuthenticationService.isLoggedIn(), AuthenticationService.isAdmin());
                $window.alert("Uloskirjautuminen onnistui");
            }).error(function() {
                $window.alert("Uloskirjautuminen epäonnistui");
            });
        }

    }
]);