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
                    $window.alert("Pohdinnan päivitys onnistui!");
                    $uibModalInstance.close({interviewRemoved: false});
                }, function() {
                    $window.alert("Pohdinnan päivitys epäonnistui!");
                });
            }
        };

        $scope.deleteInterview = function() {
            var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa pohdinta-alakohdan?");

            if (deleteConfirmation) {
                Interview.delete({interviewId : $scope.interview.id}, function() {
                    $window.alert("Pohdinnan poistaminen onnistui!");
                    $uibModalInstance.close({interviewRemoved: true});
                });

            } else {
                $window.alert("Pohdintaa ei poistettu!");
            }
        };

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);