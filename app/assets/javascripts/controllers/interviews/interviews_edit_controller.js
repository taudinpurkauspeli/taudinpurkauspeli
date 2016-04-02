var app = angular.module('diagnoseDiseases');

app.controller("InterviewsEditController", [
    "$scope", "$resource", "$window", "$uibModal",
    function($scope, $resource, $window, $uibModal) {

        $scope.updateInterview = function(interview) {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'interviews/update_interview_modal.html',
                controller: 'UpdateInterviewModalController',
                size: 'lg',
                resolve: {
                    interview: interview
                }
            });

            modalInstance.result.then(function(data) {
                $scope.setTask();
                if(data.interviewRemoved){
                    $scope.returnToTask();
                }
            }, function() {
                $window.alert("Pohdinnan päivitys peruttu.");
            });

        };

    }
]);