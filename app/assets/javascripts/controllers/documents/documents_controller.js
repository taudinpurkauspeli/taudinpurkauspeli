var app = angular.module('diagnoseDiseases');

app.controller("DocumentsController", [
    "$scope", "$uibModal", "$resource", "$state", "$window", "FileUploader",
    function($scope, $uibModal, $resource, $state, $window, FileUploader) {
        $scope.documentsList = [];
        $scope.orderByAttributes = ['starting_year', '-first_name', '-last_name'];
        $scope.reverse = true;

        var Documents = $resource('/documents.json');
        $scope.setDocuments = function() {
            Documents.query(function(data) {
                $scope.documentsList = data;

            });

        };
        $scope.setDocuments();

        $scope.setOrderByAttributes = function(newAttribute){
            var attributeSameAsFirstOrderByAttribute = ($scope.orderByAttributes[0] === newAttribute);
            $scope.reverse = attributeSameAsFirstOrderByAttribute ? !$scope.reverse : false;
            $scope.orderByAttributes[0] = newAttribute;
        };

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

        $scope.updateDocument = function(selectedDocument) {
            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'documents/update_document_modal.html',
                controller: 'UpdateDocumentModalController',
                size: 'lg',
                resolve: {
                    selectedDocument: selectedDocument
                }
            });

            modalInstance.result.then(function(status) {
                $scope.setDocuments();
            }, function() {
            });
        };

    }
]);