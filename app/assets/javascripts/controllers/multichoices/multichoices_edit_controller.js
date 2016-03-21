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

        /*

        $scope.updateTaskText = function() {
            if ($scope.updateTaskTextForm.$valid) {
                TaskText.update({taskTextId: $scope.taskText.id}, $scope.taskText, function() {
                    $window.alert("Tekstialakohdan päivitys onnistui!");
                    $scope.setCurrentTask();
                }, function() {
                    $window.alert("Tekstialakohdan päivitys epäonnistui!");
                });
            }
        };

        $scope.deleteTaskText = function() {
            var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa tekstialakohdan?");

            if (deleteConfirmation) {
                TaskText.delete({taskTextId : $scope.taskText.id}, function() {
                    $window.alert("Tekstialakohdan poistaminen onnistui!");
                    $scope.setCurrentTask();
                    $scope.returnToTask();
                });

            } else {
                $window.alert("Tekstialakohtaa ei poistettu!");
            }
        };*/

    }
]);