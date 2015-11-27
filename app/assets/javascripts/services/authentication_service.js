var app = angular.module('diagnoseDiseases');

app.service('Session', [
    "LocalStorageService",
    function (LocalStorageService) {
        this.create = function (user) {
            LocalStorageService.set("current_user_id", user.id);
            LocalStorageService.set("current_user_admin", user.admin);
        };

        this.userId = function (){
            LocalStorageService.get("current_user_id", null);
        };
        this.destroy = function () {
            LocalStorageService.set("current_user_id", null);
            LocalStorageService.set("current_user_admin", null);
        };
    }
]);

app.factory('AuthenticationService', [
    "$http","Session",
    function ($http, Session) {
        var authService = {};

        authService.login = function (credentials) {
            return $http
                .post('/sessions.json', credentials)
                .success(function (data,status,headers,config) {
                    Session.create(data);
                    return data;
                }).error(function(data,status,headers,config){
                    alert("Kirjautuminen epäonnistui");
                });
        };

        authService.logout = function () {
            return $http
                .delete('/signout.json')
                .success(function (data,status,headers,config) {
                    Session.destroy();
                }).error(function(data,status,headers,config){
                    alert("Uloskirjautuminen epäonnistui");
                });
        };

        authService.isLoggedIn = function () {
            return !Session.userId;
        };
        /*
         authService.isAuthorized = function (authorizedRoles) {
         if (!angular.isArray(authorizedRoles)) {
         authorizedRoles = [authorizedRoles];
         }
         return (authService.isAuthenticated() &&
         authorizedRoles.indexOf(Session.userRole) !== -1);
         };*/

        return authService;
    }
]);
