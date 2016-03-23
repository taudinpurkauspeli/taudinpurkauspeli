var app = angular.module('diagnoseDiseases');

app.directive('interview', [
    function() {
        return {
            restrict: 'E',
            templateUrl: "interviews/edit.html",
            controller: "InterviewsEditController"
        };
    }
]);