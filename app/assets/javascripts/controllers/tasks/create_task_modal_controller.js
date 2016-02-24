var app = angular.module('diagnoseDiseases');

app.controller("CreateTaskModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', 'exercise',
    function($scope, $uibModalInstance, $resource, $window, exercise) {

        $scope.newTask = {
            exercise_id: exercise.id
        };

        var Task = $resource('/json_tasks_create.json');

        $scope.createTask = function() {
            if ($scope.createTaskForm.$valid) {
                Task.save($scope.newTask,
                    function(data) {
                        $window.alert("Toimenpiteen luominen onnistui!");
                        $uibModalInstance.close(data);
                    },
                    function() {
                        $window.alert("Toimenpiteen luominen epäonnistui!");
                    }
                );
            }
        };

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);