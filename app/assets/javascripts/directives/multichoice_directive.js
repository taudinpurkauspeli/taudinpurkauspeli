var app = angular.module('diagnoseDiseases');

app.directive('multichoice', [
    function() {
        return {
            restrict: 'E',
            templateUrl: "multichoices/edit.html",
            controller: "MultichoicesEditController"
        };
    }
]);