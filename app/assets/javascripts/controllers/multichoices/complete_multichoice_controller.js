var app = angular.module('diagnoseDiseases');

app.controller("CompleteMultichoiceController", [
    "$scope", "$resource", "$window", "$uibModal", "$stateParams", "$state", "$filter",
    function($scope, $resource, $window, $uibModal, $stateParams, $state, $filter) {

        var Options = $resource('/options_multichoice.json');
        var CheckAnswersMultichoice = $resource('/multichoices/:id/check_answers.json',
            {id: '@id'});

        $scope.setOptions = function() {
            Options.query({ multichoice_id : $scope.subtask.multichoice.id}, function(data) {
                $scope.options = data;
            });
        };

        $scope.checkedOptions = [];

        $scope.setOptions();

        $scope.checkAnswers = function() {
            var checkedAnswers = $filter('filter')($scope.options, {checked: true});
            var checkedOptions = [];
            angular.forEach(checkedAnswers, function(answer) {
                checkedOptions.push(answer.id);
            });

            CheckAnswersMultichoice.save({ id: $scope.subtask.multichoice.id, checked_options: checkedOptions }, function(data) {
                console.log(data.status);
                $scope.setTask();
            }, function(result) {
                $scope.checkedOptions = result.data || [];
            });
        };

        $scope.checkedOptionsContains = function(option) {
            return $scope.checkedOptions.length !== 0 && $scope.checkedOptions.indexOf(option.id) !== -1;
        };

        $scope.optionIs = function(optionStatus, option) {
            return option.is_correct_answer === optionStatus;
        }

    }
]);