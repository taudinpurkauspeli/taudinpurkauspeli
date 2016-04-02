var app = angular.module('diagnoseDiseases');

app.controller("InterviewsShowController", [
    "$scope", "$resource", "$window", "$uibModal", "$stateParams", "$state",
    function($scope, $resource, $window, $uibModal, $stateParams, $state) {

        var Interview = $resource('/interviews/:interviewId.json',
            { interviewId: "@id"},
            { update: { method: 'PUT' }});

        $scope.setInterview = function() {
            Interview.get({interviewId : $stateParams.interviewShowId}, function(data) {
                $scope.interview = data;
            });
        };

        $scope.setInterview();

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
                if(data.interviewRemoved){
                    $state.go("exercises_show.current_task.show");
                }
            }, function() {
                $window.alert("Pohdinnan päivitys peruttu.");
            });

        };

    }
]);