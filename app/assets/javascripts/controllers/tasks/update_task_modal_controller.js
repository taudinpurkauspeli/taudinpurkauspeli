var app = angular.module('diagnoseDiseases');

app.controller("UpdateTaskModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', 'task',
    function($scope, $uibModalInstance, $resource, $window, task) {

        $scope.task = task;

        var Task = $resource('/tasks/:taskId.json',
            { taskId: "@id"},
            { update: { method: 'PUT' }});

        $scope.updateTask = function() {
            if ($scope.updateTaskForm.$valid) {
                Task.update({taskId: $scope.task.id}, $scope.task, function() {
                    $.notify({
                        message: "Toimenpiteen päivitys onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        delay: 0,
                        offset: 100
                    });
                    $uibModalInstance.close({taskRemoved: false});
                }, function() {
                    $.notify({
                        message: "Toimenpiteen päivitys epäonnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "danger",
                        delay: 0,
                        offset: 100
                    });
                });
            }
        };

        $scope.deleteTask = function() {
            var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa toimenpiteen ja kaikki sen alakohdat?");

            if (deleteConfirmation) {
                Task.delete({taskId : $scope.task.id}, function() {
                    $.notify({
                        message: "Toimenpiteen poistaminen onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        delay: 0,
                        offset: 100
                    });
                    $uibModalInstance.close({taskRemoved: true});
                });
            } else {
                $.notify({
                    message: "Toimenpidettä '" + $scope.task.name + "' ei poistettu"
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    delay: 0,
                    offset: 100
                });
            }
        };

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);