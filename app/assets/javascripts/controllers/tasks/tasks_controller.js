var app = angular.module('diagnoseDiseases');

app.controller("TasksController", [
    "$scope","$http","$stateParams", "$resource", "$location", "$window", "$state",
    function($scope , $http , $stateParams, $resource, $location, $window, $state) {
        $scope.tasksList = [];

        var Task = $resource('/tasks_one/:taskId.json',
            {"taskId": "@id"},
            { "create": { "method": "POST" }},
            { "update": { "method": "PUT" }});

        var Tasks = $resource('/tasks_all.json');
        $scope.tasksList = Tasks.get({"exercise_id": $stateParams.id});

    }
]);