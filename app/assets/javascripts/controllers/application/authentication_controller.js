var app = angular.module('diagnoseDiseases');

app.controller("AuthenticationController", [
    "$scope","$http","$routeParams", "$resource", "$location", "$rootScope", "AUTH_EVENTS", "AuthenticationService",
    function($scope , $http , $routeParams, $resource, $location, $rootScope, AUTH_EVENTS, AuthenticationService) {

        $scope.credentials = {
            username: '',
            password: ''
        };

        $scope.login = function(credentials) {
            AuthenticationService.login(credentials).success(function (user) {
                //$rootScope.$broadcast(AUTH_EVENTS.loginSuccess);
                $scope.setCurrentUser(AuthenticationService.isLoggedIn());
                $scope.credentials = {
                    username: '',
                    password: ''
                };
            }).error(function () {
                //$rootScope.$broadcast(AUTH_EVENTS.loginFailed);
            });
        };

        $scope.logout = function (){
            AuthenticationService.logout().success(function () {
                //$rootScope.$broadcast(AUTH_EVENTS.logoutSuccess);
                $scope.setCurrentUser(AuthenticationService.isLoggedIn());

                alert("Uloskirjautuminen onnistui");
            }).error(function () {
                alert("Uloskirjautuminen epäonnistui");
            });
        }

    }
]);