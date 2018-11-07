var app = angular.module('diagnoseDiseases');

app.controller("UpdateDocumentModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', "FileUploader", "selectedDocument",
    function($scope, $uibModalInstance, $resource, $window, FileUploader, selectedDocument) {

        $scope.fileUploader = new FileUploader({queueLimit: 1});
        $scope.fileUploader.url = "/documents.json";

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
                message: "Linkin kopiointi onnistui!"
            }, {
                placement: {
                    align: "center"
                },
                type: "success",
                offset: 100
            });
        };

        $scope.updateDocument = function() {

            console.log($scope.fileUploader);

            if ($scope.createDocumentForm.$valid) {

                if ($scope.fileUploader.queue.length === 1) {

                    $scope.fileUploader.onBeforeUploadItem = function (item) {
                        item.formData = [$scope.newDocument];
                    };

                    $scope.fileUploader.uploadItem(0);

                    $scope.fileUploader.onCompleteItem = function (item, response, status, headers) {
                        console.log(item, response, status, headers);

                        if(status === 200) {
                            $uibModalInstance.close('success');
                        } else {
                            $uibModalInstance.close('error');
                        }

                    }

                }

            }
        };


        $scope.deleteDocument = function() {
            var deleteConfirmation = $window.confirm("VAROITUS: TÄMÄ OPERAATIO POISTAA TÄMÄN TIEDOSTON NÄKYVISTÄ MYÖS CASEISTA! Oletko aivan varma, että haluat poistaa tiedoston?");

            if (deleteConfirmation) {
                Hypothesis.delete({hypothesisId : hypothesis.id}, function() {
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