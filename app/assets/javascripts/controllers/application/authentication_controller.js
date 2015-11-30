var app = angular.module('diagnoseDiseases');

app.controller("AuthenticationController", [
    "$scope","$http","$routeParams", "$resource", "$location", "$rootScope", "AuthenticationService",
    function($scope , $http , $routeParams, $resource, $location, $rootScope, AuthenticationService) {

        $scope.credentials = {
            username: '',
            password: ''
        };

        $scope.login = function(credentials) {
            AuthenticationService.login(credentials).success(function (user) {
                $scope.setCurrentUser(AuthenticationService.isLoggedIn(), AuthenticationService.isAdmin());
                $scope.credentials = {
                    username: '',
                    password: ''
                };
            }).error(function () {

            });
        };

        $scope.logout = function (){
            AuthenticationService.logout().success(function () {
                $scope.setCurrentUser(AuthenticationService.isLoggedIn(), AuthenticationService.isAdmin());

                alert("Uloskirjautuminen onnistui");
            }).error(function () {
                alert("Uloskirjautuminen epäonnistui");
            });
        }

    }
]);