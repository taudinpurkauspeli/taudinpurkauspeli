var app = angular.module('diagnoseDiseases');

app.controller("CreateDocumentModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', "FileUploader",
    function($scope, $uibModalInstance, $resource, $window, FileUploader) {

        $scope.fileUploader = new FileUploader({queueLimit: 1});
        $scope.fileUploader.url = "/documents.json";

        $scope.newDocument = {
            name: "",
            description: ""
        };

        $scope.createDocument = function() {

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




        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);