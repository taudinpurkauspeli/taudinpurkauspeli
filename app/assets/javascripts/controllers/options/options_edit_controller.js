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

        var Options = $resource('/options.json');

        var Option = $resource('/options/:optionId.json',
            { optionId: "@id"},
            { update: { method: 'PUT' }});

        $scope.setOptions = function() {
            Options.get({ multichoice_id : $stateParams.multichoiceShowId}, function(data) {
                $scope.options = data;
            });
        };

        $scope.setOptions();

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

        $scope.createOption = function(multichoice) {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'options/create_option_modal.html',
                controller: 'CreateOptionModalController',
                size: 'lg',
                resolve: {
                    multichoice: multichoice
                }
            });

            modalInstance.result.then(function() {
                $scope.setOptions();
            }, function() {
                $.notify({
                    message: "Vastausvaihtoehdon luominen peruttu."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
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
                $scope.setOptions();
            }, function() {
                $.notify({
                    message: "Vastausvaihtoehdon muokkaaminen peruttu."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            });

        };

    }
]);