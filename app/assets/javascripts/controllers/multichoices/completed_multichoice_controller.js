var app = angular.module('diagnoseDiseases');

app.controller("CompletedMultichoiceController", [
    "$scope", "$resource", "$window", "$uibModal", "$stateParams", "$state", "$filter",
    function($scope, $resource, $window, $uibModal, $stateParams, $state, $filter) {

        var Options = $resource('/options_multichoice.json');

        $scope.setOptions = function() {
            Options.query({ multichoice_id : $scope.subtask.multichoice.id}, function(data) {
                $scope.options = data;
            });
        };

        $scope.setOptions();

        $scope.optionIs = function(optionStatus, option) {
            return option.is_correct_answer === optionStatus;
        }

    }
]);