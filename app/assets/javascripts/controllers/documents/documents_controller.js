var app = angular.module('diagnoseDiseases');

app.controller("DocumentsController", [
    "$scope", "$uibModal", "$resource", "$state", "$window", "FileUploader",
    function($scope, $uibModal, $resource, $state, $window, FileUploader) {
        $scope.documentsList = [];

        var Documents = $resource('/documents.json');

        $scope.setDocuments = function() {
            Documents.query(function(data) {
                console.log(data);
                $scope.documentsList = data;
            });
        };

        $scope.setDocuments();


        $scope.isImage = function(url) {
            return url && url.match(/\.(jpeg|jpg|gif|png)$/) != null;
        };

        $scope.dataExists = function(url) {
            return url;
        };

        $scope.createDocument = function() {
            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'documents/create_document_modal.html',
                controller: 'CreateDocumentModalController',
                size: 'lg'
            });

            modalInstance.result.then(function(status) {
                $scope.setDocuments();

                if(status === 'success') {
                    $.notify({
                        message: "Tiedoston luominen onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                } else {
                    $.notify({
                        message: "Tiedoston luominen epäonnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "danger",
                        offset: 100
                    });
                }

            }, function() {
            });
        };

    }
]);