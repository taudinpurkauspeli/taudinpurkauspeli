var app = angular.module('diagnoseDiseases');

app.controller("UsersNewController", [
    "$scope", "$location", "$resource", "$window", "AuthenticationService",
    function($scope, $location, $resource, $window, AuthenticationService) {

        $scope.newUser = {};
        $scope.currentYear = new Date().getFullYear();

        var Users = $resource('/users.json');

        $scope.createUser = function () {
            if ($scope.createUserForm.$valid) {
                Users.save($scope.newUser,
                    function () {
                        credentials = {
                            username: $scope.newUser.username,
                            password: $scope.newUser.password
                        };
                        AuthenticationService.login(credentials).success(function (user) {
                            $scope.setCurrentUser(AuthenticationService.isLoggedIn(), AuthenticationService.isAdmin());
                            $scope.newUser = {};
                            $location.path("/");
                            $window.alert("Tervetuloa käyttämään Taudinpurkauspeliä!");
                        }).error(function () {
                        });
                    },
                    function () {
                        $window.alert("Käyttäjätunnuksen luominen ei onnistunut!");
                    }
                );
            }
        };
    }
]);