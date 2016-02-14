var app = angular.module('diagnoseDiseases');

app.controller("UsersNewController", [
    "$scope", "$state", "$resource", "$window", "AuthenticationService",
    function($scope, $state, $resource, $window, AuthenticationService) {

        $scope.newUser = {};
        $scope.currentYear = new Date().getFullYear();

        var Users = $resource('/users.json');

        $scope.createUser = function() {
            if ($scope.createUserForm.$valid) {
                Users.save($scope.newUser,
                    function() {
                        var credentials = {
                            username: $scope.newUser.username,
                            password: $scope.newUser.password
                        };
                        AuthenticationService.login(credentials).success(function() {
                            $scope.setCurrentUser(AuthenticationService.isLoggedIn(), AuthenticationService.isAdmin());
                            $scope.newUser = {};
                            $state.go('app_root');
                            $window.alert("Tervetuloa käyttämään Taudinpurkauspeliä!");
                        }).error(function() {
                        });
                    },
                    function() {
                        $window.alert("Käyttäjätunnuksen luominen ei onnistunut!");
                    }
                );
            }
        };
    }
]);