var app = angular.module('diagnoseDiseases');

app.directive('subtaskList', [
    function() {
        return {
            restrict: 'E',
            templateUrl: "tasks/subtask_list.html",
            controller: "TasksSubtaskListController"
        };
    }
]);