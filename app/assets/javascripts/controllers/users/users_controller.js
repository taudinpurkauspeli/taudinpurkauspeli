var app = angular.module('diagnoseDiseases');

app.controller("UsersController", [
    "$scope", "$resource",
    function($scope, $resource) {
        $scope.users = {};
        $scope.orderByAttribute = ['starting_year', '-first_name', '-last_name'];
        $scope.reverse = true;

        var Users = $resource('/users_json.json');

        $scope.setUsers = function() {
            Users.query(function(data) {
                $scope.users = data;
            });
        };

        $scope.setUsers();

        $scope.setOrderByAttribute = function(newAttribute){
            var attributeSameAsFirstOrderByAttribute = ($scope.orderByAttribute[0] === newAttribute);
            $scope.reverse = attributeSameAsFirstOrderByAttribute ? !$scope.reverse : false;
            $scope.orderByAttribute[0] = newAttribute;
        }
    }
]);