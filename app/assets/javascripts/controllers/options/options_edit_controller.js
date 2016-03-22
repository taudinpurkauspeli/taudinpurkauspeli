var app = angular.module('diagnoseDiseases');

app.controller("OptionsEditController", [
    "$scope", "$resource", "$window", "$uibModal",
    function($scope, $resource, $window, $uibModal) {

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

            modalInstance.result.then(function(data) {
                $scope.setOptions();
            }, function() {
                $window.alert("Vastausvaihtoehdon luominen peruttu.");
            });

        };


        /* $scope.updateMultichoice = function() {
         if ($scope.updateMultichoiceForm.$valid) {
         Multichoice.update({multichoiceId: $scope.multichoice.id}, $scope.multichoice, function() {
         $window.alert("Monivalinnan päivitys onnistui!");
         $scope.setCurrentTask();
         }, function() {
         $window.alert("Monivalinnan päivitys epäonnistui!");
         });
         }
         };

         $scope.deleteMultichoice = function() {
         var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa monivalinta-alakohdan?");

         if (deleteConfirmation) {
         Multichoice.delete({multichoiceId : $scope.multichoice.id}, function() {
         $window.alert("Monivalinnan poistaminen onnistui!");
         $scope.setCurrentTask();
         $scope.returnToTask();
         });

         } else {
         $window.alert("Monivalintaa ei poistettu!");
         }
         };*/

    }
]);