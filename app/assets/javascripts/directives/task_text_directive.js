var app = angular.module('diagnoseDiseases');

app.directive('taskText', [
    function() {
        return {
            restrict: 'E',
            templateUrl: "task_texts/edit.html",
            controller: "TaskTextsEditController"
        };
    }
]);