var app = angular.module('diagnoseDiseases');

app.controller("DocumentsController", [
    "$scope", "$uibModal", "$resource", "$state", "$window", "FileUploader",
    function($scope, $uibModal, $resource, $state, $window, FileUploader) {
        $scope.documentsList = [];

        $scope.fileUploader = new FileUploader({queueLimit: 1});
        $scope.fileUploader.url = "/documents.json";

        var Documents = $resource('/documents.json');

        var Document = $resource('/documents.json');

        var ExerciseDuplicate = $resource('/exercises/:exerciseId/dup.json',
            { exerciseId: "@id"});

        $scope.setDocuments = function() {
            Documents.query(function(data) {
                console.log(data);
                $scope.documentsList = data;
            });
        };

        $scope.setDocuments();

        $scope.newDocument = {
            name: "",
            description: ""
        };

        $scope.createDocument = function() {

            console.log($scope.fileUploader);

            $scope.fileUploader.onBeforeUploadItem = function (item) {
                item.formData = [$scope.newDocument];
            };

            $scope.fileUploader.uploadAll();


/*            if ($scope.createDocumentForm.$valid) {
                Document.save($scope.newDocument,
                    function(data) {
                        $.notify({
                            message: "Tiedoston luominen onnistui!"
                        }, {
                            placement: {
                                align: "center"
                            },
                            type: "success",
                            offset: 100
                        });
                    },
                    function() {
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
                );
            }*/
        };

        $scope.viewExercise = function(exercise) {
            $state.go('exercises_show.anamnesis', {exerciseShowId: exercise.id});
        };

        $scope.newExercisePage = function() {
            $state.go('exercises_new');
        };

        $scope.toggleHiddenExercise = function(exercise) {
            exercise.hidden = !exercise.hidden;
            Exercise.update({exerciseId : exercise.id}, exercise, function() {
                $.notify({
                    message: "Casen näkyvyyttä muokattu!"
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "success",
                    offset: 100
                });
                $scope.setExercises();
            }, function() {
                $.notify({
                    message: "Casen näkyvyyden muokkaus epäonnistui!"
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "danger",
                    offset: 100
                });
            });
        };

        $scope.copyExercise = function(exercise) {

            var duplicateConfirmation = $window.confirm("Oletko aivan varma, että haluat kopioida koko casen?");

            if (duplicateConfirmation) {
                ExerciseDuplicate.save({exerciseId : exercise.id}, exercise, function() {
                    $.notify({
                        message: "Casen kopiointi onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                    $scope.setExercises();
                }, function() {
                    $.notify({
                        message: "Casen kopiointi epäonnistui."
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "danger",
                        offset: 100
                    });
                });
            } else {
                $.notify({
                    message: "Casea ei kopioitu!"
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            }
        };


        $scope.showTermsOfUse = function() {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'users/terms_of_use_modal.html',
                controller: 'TermsOfUseModalController',
                size: 'lg'
            });

            modalInstance.result.then(function() {
            }, function() {
            });
        };

    }
]);