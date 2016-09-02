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
                        $.notify({
                            message: "Toimenpiteen luominen onnistui!"
                        }, {
                            placement: {
                                align: "center"
                            },
                            type: "success",
                            offset: 100
                        });
                        $uibModalInstance.close(data);
                    },
                    function() {
                        $.notify({
                            message: "Toimenpiteen luominen epäonnistui!"
                        }, {
                            placement: {
                                align: "center"
                            },
                            type: "danger",
                            offset: 100
                        });
                    }
                );
            }
        };

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);