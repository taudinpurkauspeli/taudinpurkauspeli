var app = angular.module('diagnoseDiseases');

app.controller("UsersByCaseController", [
    "$scope", "$resource",
    function($scope, $resource) {
        $scope.usersByCase = {};
        $scope.orderByAttribute = 'first_name';
        $scope.reverse = false;

        var UsersByCase = $resource('/users_by_case_json.json');

        $scope.setUsersByCase = function() {
            UsersByCase.get(function(data) {
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