var app = angular.module('diagnoseDiseases');

app.controller("AuthenticationController", [
    "$scope","$http","$stateParams", "$resource", "$location", "$rootScope", "AuthenticationService",
    function($scope , $http , $stateParams, $resource, $location, $rootScope, AuthenticationService) {

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
                $scope.credentials = {
                    username: '',
                    password: ''
                };
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