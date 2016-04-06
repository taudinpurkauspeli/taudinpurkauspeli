var app = angular.module('diagnoseDiseases');

app.directive('interviewQuestions', [
    function() {
        return {
            restrict: 'E',
            templateUrl: "questions/edit.html",
            controller: "QuestionsEditController"
        };
    }
]);