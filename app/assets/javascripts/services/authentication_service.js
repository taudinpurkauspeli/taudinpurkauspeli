var app = angular.module('diagnoseDiseases');

app.service('Session', [
    "LocalStorageService",
    function (LocalStorageService) {
        this.create = function (user) {
            LocalStorageService.set("current_user_id", user.id);
            LocalStorageService.set("current_user_admin", user.admin);
        };

        this.userId = function (){
            return LocalStorageService.get("current_user_id", null);
        };
        this.userAdmin = function (){
            return LocalStorageService.get("current_user_admin", null);
        };
        this.destroy = function () {
            LocalStorageService.remove("current_user_id");
            LocalStorageService.remove("current_user_admin");
        };
    }
]);

app.factory('AuthenticationService', [
    "$http","Session", "$location",
    function ($http, Session, $location) {
        var authService = {};

        authService.login = function (credentials) {
            return $http
                .post('/sessions.json', credentials)
                .success(function (data,status,headers,config) {
                    Session.create(data);
                    //alert(Session.userId());
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
                    //alert(Session.userId());
                    $location.path("/");
                }).error(function(data,status,headers,config){
                    alert("Uloskirjautuminen epäonnistui");
                });
        };

        authService.isLoggedIn = function () {
            return Session.userId();
        };

        authService.isAdmin = function () {
            return Session.userAdmin() === "true";
        };

        return authService;
    }
]);
