var app = angular.module('diagnoseDiseases');

app.controller("UpdateInterviewModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', "interview",
    function($scope, $uibModalInstance, $resource, $window, interview) {

        $scope.interview = interview;

        var Interview = $resource('/interviews/:interviewId.json',
            { interviewId: "@id"},
            { update: { method: 'PUT' }});

        $scope.updateInterview = function() {
            if ($scope.updateInterviewForm.$valid) {
                Interview.update({interviewId: $scope.interview.id}, $scope.interview, function() {
                    $.notify({
                        message: "Pohdinnan päivitys onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                    $uibModalInstance.close({interviewRemoved: false});
                }, function() {
                    $.notify({
                        message: "Pohdinnan päivitys epäonnistui!"
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

        $scope.deleteInterview = function() {
            var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa pohdinta-alakohdan?");

            if (deleteConfirmation) {
                Interview.delete({interviewId : $scope.interview.id}, function() {
                    $.notify({
                        message: "Pohdinnan poistaminen onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                    $uibModalInstance.close({interviewRemoved: true});
                });

            } else {
                $.notify({
                    message: "Pohdintaa ei poistettu."
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