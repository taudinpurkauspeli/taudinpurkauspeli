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
                        $window.alert("Pohdinnan luominen onnistui!");
                        $uibModalInstance.close(data);
                    },
                    function() {
                        $window.alert("Pohdinnan luominen epäonnistui!");
                    }
                );
            }
        };

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);