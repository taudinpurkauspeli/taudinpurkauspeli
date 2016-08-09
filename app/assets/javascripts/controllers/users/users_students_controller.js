var app = angular.module('diagnoseDiseases');

app.controller("UsersStudentsController", [
    "$scope", "$resource",
    function($scope, $resource) {
        $scope.users = [];
        $scope.orderByAttributes = ['starting_year', '-first_name', '-last_name'];
        $scope.reverse = true;

        var Users = $resource('/users_json.json');

        $scope.setUsers = function() {
            Users.query({admin: "f"}, function(data) {
                $scope.users = data;
            });
        };

        $scope.setUsers();
        $scope.setActiveTab("UsersStudentsTab");

        $scope.setOrderByAttributes = function(newAttribute){
            var attributeSameAsFirstOrderByAttribute = ($scope.orderByAttributes[0] === newAttribute);
            $scope.reverse = attributeSameAsFirstOrderByAttribute ? !$scope.reverse : false;
            $scope.orderByAttributes[0] = newAttribute;
        }
    }
]);