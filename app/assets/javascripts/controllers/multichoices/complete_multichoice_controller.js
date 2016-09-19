var app = angular.module('diagnoseDiseases');

app.controller("CompleteMultichoiceController", [
    "$scope", "$resource", "$window", "$uibModal", "$stateParams", "$state", "$filter",
    function($scope, $resource, $window, $uibModal, $stateParams, $state, $filter) {

        $scope.selectedRadiobuttonOption = {};

        var Options = $resource('/options_multichoice.json');
        var CheckAnswersMultichoice = $resource('/multichoices/:id/check_answers.json',
            {id: '@id'});

        $scope.setOptions = function() {
            Options.query({ multichoice_id : $scope.subtask.multichoice.id}, function(data) {
                $scope.options = data;
            });
        };

        $scope.checkedOptions = [];

        $scope.$watch(function(){
            return $scope.subtask.multichoice.id;
        },function(newValue, oldValue){
            $scope.setOptions();
        });

        $scope.setOptions();

        $scope.checkAnswers = function() {
            var checkedOptions = [];
            if($scope.subtask.multichoice.is_radio_button) {
                checkedOptions.push($scope.selectedRadiobuttonOption.id);
            } else {
                var checkedAnswers = $filter('filter')($scope.options, {checked: true});
                angular.forEach(checkedAnswers, function(answer) {
                    checkedOptions.push(answer.id);
                });
            }

            CheckAnswersMultichoice.save({ id: $scope.subtask.multichoice.id, checked_options: checkedOptions }, function(data) {
                $scope.setTask();
            }, function(result) {
                $.notify({
                    message: "Valinnoissa oli vielä virheitä."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "danger",
                    offset: 100
                });
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