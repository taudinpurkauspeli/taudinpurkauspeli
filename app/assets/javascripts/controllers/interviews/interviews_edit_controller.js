var app = angular.module('diagnoseDiseases');

app.controller("InterviewsEditController", [
    "$scope", "$resource", "$window",
    function($scope, $resource, $window) {

        var Interview = $resource('/interviews/:interviewId.json',
            { interviewId: "@id"},
            { update: { method: 'PUT' }});


        $scope.updateInterview = function() {
            if ($scope.updateInterviewForm.$valid) {
                Interview.update({interviewId: $scope.interview.id}, $scope.interview, function() {
                    $window.alert("Pohdinnan päivitys onnistui!");
                    $scope.setCurrentTask();
                    $scope.updateInterviewForm.$setPristine();
                    $scope.updateInterviewForm.$setUntouched();
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
                    $scope.setCurrentTask();
                    $scope.returnToTask();
                });

            } else {
                $window.alert("Pohdintaa ei poistettu!");
            }
        };

    }
]);