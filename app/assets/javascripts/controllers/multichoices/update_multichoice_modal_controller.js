var app = angular.module('diagnoseDiseases');

app.controller("UpdateMultichoiceModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', "multichoice",
    function($scope, $uibModalInstance, $resource, $window, multichoice) {

        $scope.multichoice = multichoice;

        var Multichoice = $resource('/multichoices/:multichoiceId.json',
            { multichoiceId: "@id"},
            { update: { method: 'PUT' }});

        $scope.updateMultichoice = function() {
            if ($scope.updateMultichoiceForm.$valid) {
                Multichoice.update({multichoiceId: $scope.multichoice.id}, $scope.multichoice, function() {
                    $.notify({
                        message: "Monivalinnan päivitys onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                    $uibModalInstance.close({multichoiceRemoved: false});
                }, function() {
                    $.notify({
                        message: "Monivalinnan päivitys epäonnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "danger",
                        offset: 100
                    });
                });
            }
        };

        $scope.deleteMultichoice = function() {
            var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa monivalinta-alakohdan?");

            if (deleteConfirmation) {
                Multichoice.delete({multichoiceId : $scope.multichoice.id}, function() {
                    $.notify({
                        message: "Monivalinnan poistaminen onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                    $uibModalInstance.close({multichoiceRemoved: true});
                });
            } else {
                $.notify({
                    message: "Monivalintaa ei poistettu."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            }
        };

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);