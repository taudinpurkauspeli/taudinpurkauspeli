var app = angular.module('diagnoseDiseases');

app.controller("ExercisesAnamnesisController", [
    "$scope","$http","$stateParams", "$resource", "$state", "LocalStorageService",
    function($scope , $http , $stateParams, $resource, $state, LocalStorageService) {

        $scope.updateAnamnesis = function(){
            if ($scope.updateExerciseAnamnesisForm.$valid) {
                $scope.exercise.$save(
                    function() {
                        $scope.updateExerciseAnamnesisForm.$setPristine();
                        $scope.updateExerciseAnamnesisForm.$setUntouched();
                        alert("Anamneesin päivitys onnistui!");
                    },
                    function() {
                        alert("Anamneesin päivitys epäonnistui!");
                    }
                );
            }
        };

    }
]);