var app = angular.module('diagnoseDiseases');

app.controller("UsersShowController", [
    "$scope", "$resource", "$stateParams", "$window", "$state",
    function($scope, $resource, $stateParams, $window, $state) {
        $scope.user = {};

        var User = $resource('/users/:userId.json',
            { userId: "@id"},
            { update: { method: 'PUT' }});

        var UserDestroy = $resource('/delete_user_json/:userId.json',
            { userId: "@id"});

        $scope.setAdminStatus = function(user){
            if(user.admin){
                $scope.adminStatus = "opiskelija";
            } else {
                $scope.adminStatus = "opettaja";
            }
        };

        $scope.setUser = function() {
            User.get({userId : $stateParams.userShowId}, function(data) {
                $scope.user = data.user;
                $scope.userExercises = data.exercises;
                $scope.userHasStartedExercises = (data.exercises.length > 0);
                $scope.setAdminStatus(data.user);
            }, function(data){
                if(data.status == 401){
                    $window.alert("Pääsy toisen käyttäjän tietoihin estetty!");
                    $state.go('app_root');
                }
            });
        };

        $scope.setUser();

        $scope.removeUser = function(user) {

            var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa opiskelijan?");

            if (deleteConfirmation) {
                UserDestroy.delete({userId : user.id}, function() {
                    $window.alert("Opiskelijan poistaminen onnistui!");
                    $state.go('users.by_case');
                });
            } else {
                $window.alert("Opiskelijaa '" + user.first_name + "' ei poistettu");
            }
        };

        $scope.changeAdminStatus = function(user){
            var adminStatusChangeConfirmation = $window.confirm("Oletko aivan varma, että haluat muuttaa käyttäjän tilin oikeuksia?");

            if (adminStatusChangeConfirmation) {

                var newAdminStatus = !user.admin;
                user.admin = newAdminStatus;

                User.update({userId : user.id}, user, function() {
                    $window.alert("Käyttäjän oikeuksien muuttaminen onnistui!");
                    $scope.setUser();
                }, function() {
                    $window.alert("Käyttäjän oikeuksia ei voitu muuttaa!");
                });
            } else {
                $window.alert("Käyttäjän '" + user.first_name + "' oikeuksia ei muutettu.");
            }
        };

    }
]);