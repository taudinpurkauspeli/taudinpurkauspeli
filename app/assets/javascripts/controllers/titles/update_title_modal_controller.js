var app = angular.module('diagnoseDiseases');

app.controller("UpdateTitleModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', 'title',
    function($scope, $uibModalInstance, $resource, $window, title) {

        $scope.title = title;

        var Title = $resource('/titles/:titleId.json',
            { titleId: "@id"},
            { update: { method: 'PUT' }});

        $scope.deleteTitle = function() {
            var deleteConfirmation = $window.confirm("VAROITUS: TÄMÄ OPERAATIO POISTAA TÄMÄN KYSYMYKSEN MYÖS POHDINNOISTA! " +
                "Oletko aivan varma, että haluat poistaa kysymyksen ja sen kaikki pohdintoihin liittyvät kysymykset?");

            if (deleteConfirmation) {
                Title.delete({titleId: title.id}, function() {
                    $.notify({
                        message: "Kysymyksen poistaminen onnistui!"
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
                    message: "Kysymystä '" + title.text + "' ei poistettu."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            }
        };

        $scope.updateTitle = function() {
            if ($scope.updateTitleForm.$valid) {
                Title.update({titleId: title.id}, $scope.title, function() {
                    $.notify({
                        message: "Kysymyksen päivitys onnistui!"
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
                        message: "Kysymyksen päivitys epäonnistui!"
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

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);