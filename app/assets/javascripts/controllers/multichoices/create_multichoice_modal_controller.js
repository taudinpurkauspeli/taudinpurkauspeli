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
                        $.notify({
                            message: "Monivalinnan luominen onnistui!"
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
                            message: "Monivalinnan luominen epäonnistui!"
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