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
                    $window.alert("Toimenpiteen päivitys onnistui!");
                    $uibModalInstance.close();
                }, function() {
                    $window.alert("Toimenpiteen päivitys epäonnistui!");
                });
            }
        };

        $scope.deleteTask = function() {
            var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa toimenpiteen ja kaikki sen alakohdat?");

            if (deleteConfirmation) {
                Task.delete({taskId : $scope.task.id}, function() {
                    $window.alert("Toimenpiteen poistaminen onnistui!");
                    $uibModalInstance.close({taskRemoved: true});
                });
            } else {
                $window.alert("Toimenpidettä '" + $scope.task.name + "' ei poistettu");
            }
        };

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);