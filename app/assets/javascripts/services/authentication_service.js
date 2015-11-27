var app = angular.module('diagnoseDiseases');

app.service('Session', [
/*    function () {
        this.create = function (userId, userRole) {
            this.userId = userId;
            this.userRole = userRole;
            alert(this.userId + " " + this.userRole)
        };
        this.destroy = function () {
            this.userId = null;
            this.userRole = null;
        };
    }*/
]);

app.factory('AuthenticationService', [
    "$http","Session",
    function ($http, Session) {
        var authService = {};

        authService.login = function (credentials) {
            return $http
                .post('/sessions.json', credentials)
                .success(function (data,status,headers,config) {
                   // Session.create(response.data.user.id,
                   //     response.data.user.admin);
                   // return response.data.user;
                    return data;
                }).error(function(data,status,headers,config){
                    alert("Kirjautuminen epäonnistui");
                });
        };

        /*        authService.isAuthenticated = function () {
         return !!Session.userId;
         };

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
