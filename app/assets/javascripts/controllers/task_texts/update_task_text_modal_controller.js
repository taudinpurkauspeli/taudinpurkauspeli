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
                    $.notify({
                        message: "Tekstialakohdan päivitys onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                    $uibModalInstance.close();
                }, function() {
                    $.notify({
                        message: "Tekstialakohdan päivitys epäonnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "danger",
                        offset: 100
                    });
                });
            }
        };

        $scope.deleteTaskText = function() {
            var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa tekstialakohdan?");

            if (deleteConfirmation) {
                TaskText.delete({taskTextId : $scope.taskText.id}, function() {
                    $.notify({
                        message: "Tekstialakohdan poistaminen onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                    $uibModalInstance.close();
                });

            } else {
                $.notify({
                    message: "Tekstialakohtaa ei poistettu."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "success",
                    offset: 100
                });
            }
        };

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);