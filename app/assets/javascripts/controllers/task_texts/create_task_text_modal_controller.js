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
                        $window.alert("Tekstialakohdan luominen onnistui!");
                        $uibModalInstance.close(data);
                    },
                    function() {
                        $window.alert("Tekstialakohdan luominen epäonnistui!");
                    }
                );
            }
        };

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);