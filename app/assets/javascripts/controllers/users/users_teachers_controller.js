var app = angular.module('diagnoseDiseases');

app.controller("UsersTeachersController", [
    "$scope", "$resource",
    function($scope, $resource) {
        $scope.users = [];
        $scope.orderByAttributes = ['starting_year', '-first_name', '-last_name'];
        $scope.reverse = true;

        var Users = $resource('/users_json.json');

        $scope.setUsers = function() {
            Users.query({admin: "t"}, function(data) {
                $scope.users = data;
            });
        };

        $scope.setUsers();
        $scope.setActiveTab("UsersTeachersTab");

        $scope.setOrderByAttributes = function(newAttribute){
            var attributeSameAsFirstOrderByAttribute = ($scope.orderByAttributes[0] === newAttribute);
            $scope.reverse = attributeSameAsFirstOrderByAttribute ? !$scope.reverse : false;
            $scope.orderByAttributes[0] = newAttribute;
        }
    }
]);