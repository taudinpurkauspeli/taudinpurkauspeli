var app = angular.module('diagnoseDiseases');

app.controller("CreateInterviewModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', "task",
    function($scope, $uibModalInstance, $resource, $window, task) {

        $scope.newInterview = {
            title: ""
        };

        var Interview = $resource('/interviews_json_create.json');

        $scope.createInterview = function() {
            if ($scope.createInterviewForm.$valid) {
                Interview.save({"task_id": task.id}, $scope.newInterview,
                    function(data) {
                        $.notify({
                            message: "Pohdinnan luominen onnistui!"
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
                            message: "Pohdinnan luominen epäonnistui!"
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