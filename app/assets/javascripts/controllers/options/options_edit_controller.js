var app = angular.module('diagnoseDiseases');

app.controller("OptionsEditController", [
    "$scope", "$resource", "$window", "$uibModal", "$stateParams",
    function($scope, $resource, $window, $uibModal, $stateParams) {

        $scope.answer_types = [{
            name_fi: "Pakolliset vaihtoehdot",
            name_en: "required",
            allowed_types: ['allowed', 'wrong']
        }, {
            name_fi: "Sallitut vaihtoehdot",
            name_en: "allowed",
            allowed_types: ['required', 'wrong']
        }, {
            name_fi: "Väärät vaihtoehdot",
            name_en: "wrong",
            allowed_types: ['required', 'allowed']
        }
        ];

        $scope.optionsOnly = [];

        var Options = $resource('/options.json');

        var Option = $resource('/options/:optionId.json',
            { optionId: "@id"},
            { update: { method: 'PUT' }});

        var OptionsOnly = $resource('/options_only.json');

        $scope.setOptions = function() {
            Options.get({ multichoice_id: $stateParams.multichoiceShowId}, function(data) {
                $scope.options = data;
            }, function() {

            });
        };

        $scope.setOptionsOnly = function() {
            OptionsOnly.query({multichoice_id: $stateParams.multichoiceShowId}, function(data) {
                $scope.optionsOnly = data;
            }, function() {

            });
        };


        $scope.setAllOptions = function() {
            $scope.setOptions();
            $scope.setOptionsOnly();
        };

        $scope.setAllOptions();

        $scope.moveOptionToNewType = function(option, newType) {

            option.is_correct_answer = newType;

            Option.update({optionId: option.id}, option, function() {
                $scope.setOptions();
            }, function() {
                $.notify({
                    message: "Vastausvaihtoehdon päivitys epäonnistui!"
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "danger",
                    offset: 100
                });
            });
        };

        $scope.addToMultichoice = function(multichoice, title) {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'options/create_option_modal.html',
                controller: 'CreateOptionModalController',
                size: 'lg',
                resolve: {
                    multichoice: multichoice,
                    title: title
                }
            });

            modalInstance.result.then(function() {
                $scope.setAllOptions();
            }, function() {
            });

        };

        $scope.updateOption = function(option) {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'options/update_option_modal.html',
                controller: 'UpdateOptionModalController',
                size: 'lg',
                resolve: {
                    option: option
                }
            });

            modalInstance.result.then(function() {
                $scope.setAllOptions();
            }, function() {
            });

        };

        $scope.optionIs = function(optionAnswerType, option) {
            return option.is_correct_answer === optionAnswerType;
        };

        $scope.belongsToMultichoice = function(optionTitle) {

            for (var i = 0; i < $scope.optionsOnly.length; i++) {
                var optionValue = $scope.optionsOnly[i];
                if (optionValue.title.id === optionTitle.id){
                    return true;
                }
            }
            return false;
        };

    }
]);