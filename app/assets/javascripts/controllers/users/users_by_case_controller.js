var app = angular.module('diagnoseDiseases');

app.controller("UsersByCaseController", [
    "$scope", "$resource",
    function($scope, $resource) {
        $scope.setActiveTab("UsersByCaseTab");

        var UsersByCase = $resource('/users_by_case_json.json');

        $scope.setUsersByCase = function() {
            UsersByCase.get(function(data) {
                $scope.usersByCase = data;
            });
        };

        $scope.setUsersByCase();
    }
]);