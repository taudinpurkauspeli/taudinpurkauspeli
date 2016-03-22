var app = angular.module('diagnoseDiseases');

app.controller("MultichoicesEditController", [
    "$scope", "$resource", "$window",
    function($scope, $resource, $window) {

        var Multichoice = $resource('/multichoices/:multichoiceId.json',
            { multichoiceId: "@id"},
            { update: { method: 'PUT' }});


        $scope.setMultichoice = function() {
            Multichoice.get({ multichoiceId : $scope.multichoice.id}, function(data) {
                $scope.multichoice = data;
            });
        };

        $scope.setMultichoice();


        $scope.updateMultichoice = function() {
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
        };

    }
]);