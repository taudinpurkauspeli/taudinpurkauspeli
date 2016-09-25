var app = angular.module('diagnoseDiseases');

app.controller("MultichoicesShowController", [
    "$scope", "$resource", "$window", "$uibModal", "$stateParams", "$state",
    function($scope, $resource, $window, $uibModal, $stateParams, $state) {

        var Multichoice = $resource('/multichoices/:multichoiceId.json',
            { multichoiceId: "@id"},
            { update: { method: 'PUT' }});

        $scope.setMultichoice = function() {
            Multichoice.get({multichoiceId : $stateParams.multichoiceShowId}, function(data) {
                $scope.multichoice = data;
            });
        };

        $scope.setMultichoice();
        $scope.setTaskShowPath("exercises_show.current_task.multichoice", {multichoiceShowId:  $stateParams.multichoiceShowId});

        $scope.updateMultichoice = function(multichoice) {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'multichoices/update_multichoice_modal.html',
                controller: 'UpdateMultichoiceModalController',
                size: 'lg',
                resolve: {
                    multichoice: multichoice
                }
            });

            modalInstance.result.then(function(data) {
                if(data.multichoiceRemoved){
                    $scope.setTask();
                    $state.go("exercises_show.current_task.show");
                }
            }, function() {
            });

        };

    }
]);