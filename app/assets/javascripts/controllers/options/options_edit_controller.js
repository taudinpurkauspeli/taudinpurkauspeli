var app = angular.module('diagnoseDiseases');

app.controller("OptionsEditController", [
    "$scope", "$resource", "$window", "$uibModal",
    function($scope, $resource, $window, $uibModal) {

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
            Options.get({ multichoice_id : $scope.multichoice.id}, function(data) {
                $scope.options = data;
            });
        };

        $scope.setOptions();

        $scope.moveOptionToNewType = function(option, newType){

            option.is_correct_answer = newType;

            Option.update({optionId: option.id}, option, function() {
                $scope.setOptions();
            }, function() {
                $window.alert("Vastausvaihtoehdon päivitys epäonnistui!");
            });
        };

        $scope.createOption = function(multichoice){

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
                $window.alert("Vastausvaihtoehdon luominen peruttu.");
            });

        };

        $scope.updateOption = function(option){

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
                $window.alert("Vastausvaihtoehdon muokkaaminen peruttu.");
            });

        };

    }
]);