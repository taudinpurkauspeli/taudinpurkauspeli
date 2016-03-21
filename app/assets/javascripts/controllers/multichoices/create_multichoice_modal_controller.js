var app = angular.module('diagnoseDiseases');

app.controller("CreateMultichoiceModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', "task",
    function($scope, $uibModalInstance, $resource, $window, task) {

        $scope.newMultichoice = {
            question: "",
            is_radio_button: false
        };

        var Multichoice = $resource('/multichoices_json_create.json');

        $scope.createMultichoice = function() {
            if ($scope.createMultichoiceForm.$valid) {
                Multichoice.save({"task_id": task.id}, $scope.newMultichoice,
                    function(data) {
                        $window.alert("Monivalinnan luominen onnistui!");
                        $uibModalInstance.close(data);
                    },
                    function() {
                        $window.alert("Monivalinna luominen epäonnistui!");
                    }
                );
            }
        };

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);