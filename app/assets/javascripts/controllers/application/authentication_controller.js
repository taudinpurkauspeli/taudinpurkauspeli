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
                $.notify({
                    message: "Uloskirjautuminen onnistui!"
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "success",
                    offset: 100
                });
            }).error(function() {
                $.notify({
                    message: "Uloskirjautuminen epäonnistui!"
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "danger",
                    offset: 100
                });
            });
        }

    }
]);