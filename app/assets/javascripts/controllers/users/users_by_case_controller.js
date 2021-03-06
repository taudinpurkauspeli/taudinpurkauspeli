var app = angular.module('diagnoseDiseases');

app.controller("UsersByCaseController", [
    "$scope", "$resource",
    function($scope, $resource) {
        $scope.usersByCase = [{}];
        $scope.orderByAttribute = 'first_name';
        $scope.reverse = false;

        var UsersByCase = $resource('/users_by_case_json.json');

        $scope.getType = function(percentOfCompletedTasks) {
            if(percentOfCompletedTasks >= 100) {
                return 'success';
            } else if (percentOfCompletedTasks < 25) {
                return 'danger';
            } else {
                return 'warning';
            }
        };

        $scope.thereAreUsersInExercise = function(usersOfExericse) {
          return usersOfExericse && usersOfExericse.length > 0;
        };

        $scope.setUsersByCase = function() {
            UsersByCase.query(function(data) {
                $scope.usersByCase = data;
            });
        };

        $scope.setUsersByCase();
        $scope.setActiveTab("UsersByCaseTab");

        $scope.queryMatchesCaseName = function(caseName){
            return ($scope.queryCase && caseName.toLowerCase().includes($scope.queryCase.toLowerCase()));
        };

        $scope.setOrderByAttribute = function(newAttribute){
            var attributeSameAsFirstOrderByAttribute = ($scope.orderByAttribute === newAttribute);
            $scope.reverse = attributeSameAsFirstOrderByAttribute ? !$scope.reverse : false;
            $scope.orderByAttribute = newAttribute;
        };
    }
]);