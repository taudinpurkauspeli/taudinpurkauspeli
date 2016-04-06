var app = angular.module('diagnoseDiseases');

app.controller("UsersController", [
    "$scope", "$state",
    function($scope, $state) {

        $scope.viewUser = function(user){
            $state.go('users_show', {userShowId: user.id});
        };

    }
]);