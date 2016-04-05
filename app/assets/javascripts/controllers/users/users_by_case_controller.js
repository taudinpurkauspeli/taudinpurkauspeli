var app = angular.module('diagnoseDiseases');

app.controller("UsersByCaseController", [
    "$scope", "$resource",
    function($scope, $resource) {
        $scope.setActiveTab("UsersByCaseTab");
    }
]);