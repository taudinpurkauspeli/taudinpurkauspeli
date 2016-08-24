var app = angular.module('diagnoseDiseases');

app.controller("TasksShowDirectiveController", [
    "$scope", "$stateParams", "$resource",
    function($scope, $stateParams, $resource) {

        var CompletableSubtasks = $resource('/users/:id/completable_subtasks.json',
            {id: '@id'});

        $scope.setCompletableSubtasks = function() {

            CompletableSubtasks.query({id: $scope.currentUser, task_id: $scope.task.id},
                function(data) {
                        $scope.completedSubtasks = data;
                }, function() {
                    $scope.completedSubtasks = [];
                }
            );
        };

        $scope.setCompletableSubtasks();

    }
]);