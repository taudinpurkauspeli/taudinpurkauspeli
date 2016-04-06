var app = angular.module('diagnoseDiseases');

app.controller("UsersShowController", [
    "$scope", "$resource", "$stateParams", "$window", "$state",
    function($scope, $resource, $stateParams, $window, $state) {
        $scope.user = {};

        var User = $resource('/users/:userId.json',
            { userId: "@id"});

        var UserDestroy = $resource('/delete_user_json/:userId.json',
            { userId: "@id"});

        $scope.setUser = function() {
            User.get({userId : $stateParams.userShowId}, function(data) {
                $scope.user = data.user;
                $scope.userExercises = data.exercises;
                $scope.userHasStartedExercises = (data.exercises.length > 0);
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

    }
]);