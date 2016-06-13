var app = angular.module('diagnoseDiseases');

app.controller("CompleteMultichoiceController", [
    "$scope", "$resource", "$window", "$uibModal", "$stateParams", "$state", "$filter",
    function($scope, $resource, $window, $uibModal, $stateParams, $state, $filter) {

        var Options = $resource('/options_multichoice.json');

        $scope.setOptions = function() {
            Options.query({ multichoice_id : $scope.subtask.multichoice.id}, function(data) {
                $scope.options = data;
            });
        };

        $scope.setOptions();

        $scope.checkAnswers = function() {
            var checkedAnswers = $filter('filter')($scope.options, {checked: true});
            console.log(checkedAnswers);
        }

    }
]);