var app = angular.module('diagnoseDiseases');

app.factory('AuthenticationService', [
    '$http','Session', '$state',
    function ($http, Session, $state) {
        var authService = {};

        authService.login = function(credentials) {
            return $http
                .post('/sessions.json', credentials)
                .then(function onSuccess(data,status,headers,config) {
                    Session.create(data);
                    return data;
                }).catch(function onError(data,status,headers,config) {
                    $.notify({
                        message: 'Kirjautuminen epäonnistui!'
                    }, {
                        placement: {
                            align: 'center'
                        },
                        type: 'danger',
                        offset: 100
                    });
                });
        };

        authService.logout = function() {
            return $http
                .delete('/signout.json')
                .then(function onSuccess(data,status,headers,config) {
                    Session.destroy();
                    $state.go('app_root');
                }).catch(function onError(data,status,headers,config) {
                    $.notify({
                        message: 'Uloskirjautuminen epäonnistui!'
                    }, {
                        placement: {
                            align: 'center'
                        },
                        type: 'danger',
                        offset: 100
                    });
                });
        };

        authService.isLoggedIn = function() {
            return Session.userId();
        };

        authService.isAdmin = function() {
            return Session.userAdmin() === 'true';
        };

        authService.isTester = function() {
            return Session.userTester() === 'true';
        };

        return authService;
    }
]);
