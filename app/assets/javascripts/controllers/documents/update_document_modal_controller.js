var app = angular.module('diagnoseDiseases');

app.controller("UpdateDocumentModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', "FileUploader", "selectedDocument",
    function($scope, $uibModalInstance, $resource, $window, FileUploader, selectedDocument) {

        var DocumentResource = $resource('/documents/:documentId.json',
            { documentId: "@id"},
            { update: { method: 'PUT' }});


        $scope.selectedDocument = selectedDocument;

        $scope.isImage = function(url) {
            return url && url.match(/\.(jpeg|jpg|gif|png)$/) != null;
        };

        $scope.dataExists = function(url) {
            return url;
        };

        $scope.copyDocumentUrl = function() {
            var copyText = document.getElementById("documentDataUrl");

            copyText.select();

            document.execCommand("copy");

            $.notify({
                message: "Linkki kopioitu!"
            }, {
                placement: {
                    align: "center"
                },
                type: "success",
                offset: 100
            });
        };


        $scope.updateDocument = function() {
            if ($scope.updateDocumentForm.$valid) {
                DocumentResource.update({documentId: selectedDocument.id}, $scope.selectedDocument, function() {
                    $.notify({
                        message: "Tiedoston päivitys onnistui!"
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
                        message: "Tiedoston päivitys epäonnistui!"
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



        $scope.deleteDocument = function() {
            var deleteConfirmation = $window.confirm("VAROITUS: TÄMÄ OPERAATIO POISTAA TÄMÄN TIEDOSTON NÄKYVISTÄ MYÖS CASEISTA! Oletko aivan varma, että haluat poistaa tiedoston?");

            if (deleteConfirmation) {
                DocumentResource.delete({documentId : selectedDocument.id}, function() {
                    $.notify({
                        message: "Tiedoston poistaminen onnistui!"
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
                    message: "Tiedostoa '" + selectedDocument.name + "' ei poistettu."
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