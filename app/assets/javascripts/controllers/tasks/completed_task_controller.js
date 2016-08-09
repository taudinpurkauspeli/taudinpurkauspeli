var app = angular.module('diagnoseDiseases');

app.controller("CompletedTaskController", [
    "$scope", "$resource", "$window", "$uibModal", "$stateParams", "$state", "$filter",
    function($scope, $resource, $window, $uibModal, $stateParams, $state, $filter) {

        $scope.userHasCompletedConclusion = false;

        var UserHasCompletedConclusion = $resource('/users/:id/has_completed_conclusion.json',
            {id: '@id'});

        $scope.setCompletedConclusionValue = function() {

            UserHasCompletedConclusion.get({id: $scope.currentUser, exercise_id: $stateParams.exerciseShowId},
                function() {
                    $scope.userHasCompletedConclusion = true;
                }, function() {
                    $scope.userHasCompletedConclusion = false;
                }
            );
        };

        $scope.setCompletedConclusionValue();
    }
]);