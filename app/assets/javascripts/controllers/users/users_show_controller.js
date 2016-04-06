var app = angular.module('diagnoseDiseases');

app.controller("UsersShowController", [
    "$scope", "$resource", "$stateParams",
    function($scope, $resource, $stateParams) {
        $scope.user = {};

        var User = $resource('/users/:userId.json',
            { userId: "@id"});

        $scope.setUser = function() {
            User.get({userId : $stateParams.userShowId}, function(data) {
                $scope.user = data.user;
                $scope.userExercises = data.exercises;
                $scope.userHasStartedExercises = (data.exercises.length > 0);
            });
        };

        $scope.setUser();

    }
]);