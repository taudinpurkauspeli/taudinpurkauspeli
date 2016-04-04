var app = angular.module('diagnoseDiseases');

app.controller("UsersController", [
    "$scope", "$resource",
    function($scope, $resource) {
        $scope.users = {};

        var Users = $resource('/users_json.json');

        $scope.setUsers = function() {
            Users.query(function(data) {
                $scope.users = data;
            });
        };

        $scope.setUsers();
    }
]);