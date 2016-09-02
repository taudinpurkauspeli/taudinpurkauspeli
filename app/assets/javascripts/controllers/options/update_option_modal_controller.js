var app = angular.module('diagnoseDiseases');

app.controller("UpdateOptionModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', "option",
    function($scope, $uibModalInstance, $resource, $window, option) {

        $scope.option = option;

        var Option = $resource('/options/:optionId.json',
            { optionId: "@id"},
            { update: { method: 'PUT' }});

        $scope.updateOption = function() {
            if ($scope.updateOptionForm.$valid) {
                Option.update({optionId: $scope.option.id}, $scope.option, function() {
                    $.notify({
                        message: "Vastausvaihtoehdon päivitys onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                    $uibModalInstance.close();
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
            }
        };

        $scope.deleteOption = function() {
            var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa vastausvaihtoehdon?");

            if (deleteConfirmation) {
                Option.delete({optionId: $scope.option.id}, function() {
                    $.notify({
                        message: "Vastausvaihtoehdon poistaminen onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                    $uibModalInstance.close();
                });

            } else {
                $.notify({
                    message: "Vastausvaihtoehtoa ei poistettu."
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