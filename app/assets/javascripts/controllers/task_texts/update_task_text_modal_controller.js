var app = angular.module('diagnoseDiseases');

app.controller("UpdateTaskTextModalController", [
    "$scope", "$resource", "$window", "$uibModalInstance", "taskText",
    function($scope, $resource, $window, $uibModalInstance, taskText) {

        $scope.taskText = taskText;

        var TaskText = $resource('/task_texts/:taskTextId.json',
            { taskTextId: "@id"},
            { update: { method: 'PUT' }});

        $scope.updateTaskText = function() {
            if ($scope.updateTaskTextForm.$valid) {
                TaskText.update({taskTextId: $scope.taskText.id}, $scope.taskText, function() {
                    $window.alert("Tekstialakohdan päivitys onnistui!");
                    $uibModalInstance.close();
                }, function() {
                    $window.alert("Tekstialakohdan päivitys epäonnistui!");
                });
            }
        };

        $scope.deleteTaskText = function() {
            var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa tekstialakohdan?");

            if (deleteConfirmation) {
                TaskText.delete({taskTextId : $scope.taskText.id}, function() {
                    $window.alert("Tekstialakohdan poistaminen onnistui!");
                    $uibModalInstance.close();
                });

            } else {
                $window.alert("Tekstialakohtaa ei poistettu!");
            }
        };

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);