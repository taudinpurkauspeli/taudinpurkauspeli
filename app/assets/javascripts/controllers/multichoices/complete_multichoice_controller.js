var app = angular.module('diagnoseDiseases');

app.controller("CompleteMultichoiceController", [
    "$scope", "$resource", "$window", "$uibModal", "$stateParams", "$state",
    function($scope, $resource, $window, $uibModal, $stateParams, $state) {

        var Options = $resource('/options_multichoice.json');

        $scope.setOptions = function() {
            Options.query({ multichoice_id : $scope.subtask.multichoice.id}, function(data) {
                $scope.options = data;
            });
        };

        $scope.setOptions();

    }
]);