var app = angular.module('diagnoseDiseases');

app.controller("LoginController", [
    "$scope","$http","$routeParams", "$resource", "$location", "$rootScope", "AUTH_EVENTS", "AuthenticationService",
    function($scope , $http , $routeParams, $resource, $location, $rootScope, AUTH_EVENTS, AuthenticationService) {

        $scope.credentials = {
            username: '',
            password: ''
        };

        $scope.login = function(credentials) {
            AuthenticationService.login(credentials).success(function (user) {
                //$rootScope.$broadcast(AUTH_EVENTS.loginSuccess);
                //$scope.setCurrentUser(user);
                $scope.credentials = {
                    username: '',
                    password: ''
                };
                alert(user.id + " " + user.admin);
            }).error(function () {
                //$rootScope.$broadcast(AUTH_EVENTS.loginFailed);
            });
        }

    }
]);