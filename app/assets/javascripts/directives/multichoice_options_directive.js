var app = angular.module('diagnoseDiseases');

app.directive('multichoiceOptions', [
    function() {
        return {
            restrict: 'E',
            templateUrl: "options/edit.html",
            controller: "OptionsEditController"
        };
    }
]);