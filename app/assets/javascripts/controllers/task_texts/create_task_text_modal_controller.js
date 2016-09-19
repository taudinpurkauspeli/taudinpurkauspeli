var app = angular.module('diagnoseDiseases');

app.controller("CreateTaskTextModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', 'task',
    function($scope, $uibModalInstance, $resource, $window, task) {

        $scope.newTaskText = {
            content: ""
        };

        var TaskText = $resource('/task_texts_json_create.json');

        $scope.createTaskText = function() {
            if ($scope.createTaskTextForm.$valid) {
                TaskText.save({"task_id": task.id}, $scope.newTaskText,
                    function(data) {
                        $.notify({
                            message: "Tekstialakohdan luominen onnistui!"
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
                            message: "Tekstialakohdan luominen epäonnistui!"
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