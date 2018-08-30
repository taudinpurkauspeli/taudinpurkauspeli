var app = angular.module('diagnoseDiseases');

app.factory('AuthenticationService', [
    '$http','Session', '$state', '$resource',
    function ($http, Session, $state, $resource) {
        var authService = {};
        var Sessions = $resource('/sessions.json');
        var Signout = $resource('/signout.json');

        authService.login = function(credentials) {
            return Sessions.save(credentials, function onSuccess(data) {
                Session.create(data);
                return data;
            }, function onError() {
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
            return Signout.delete(function onSuccess() {
                Session.destroy();
                $state.go('app_root');
            }, function onError() {
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

        authService.hasAcceptedLicenceAgreement = function() {
            return Session.userAcceptLicenceAgreement() === 'true';
        };

        authService.hasAcceptedAcademicResearch = function() {
            return Session.userAcceptAcademicResearch() === 'true';
        };

        return authService;
    }
]);
