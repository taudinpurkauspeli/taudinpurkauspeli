var app = angular.module('diagnoseDiseases');

app.controller("UsersController", [
    "$scope", "$resource",
    function($scope, $resource) {
        $scope.users = {};
        $scope.orderByAttribute = ['-starting_year', 'first_name', 'last_name'];

        var Users = $resource('/users_json.json');

        $scope.setUsers = function() {
            Users.query(function(data) {
                $scope.users = data;
            });
        };

        $scope.setUsers();

        $scope.setOrderByAttribute = function(newAttribute){
            $scope.orderByAttribute[0] = newAttribute;
        }
    }
]);