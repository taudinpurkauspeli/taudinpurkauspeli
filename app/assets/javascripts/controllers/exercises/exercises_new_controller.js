var app = angular.module('diagnoseDiseases');

app.controller("ExercisesNewController", [
    "$scope","$http","$stateParams", "$resource", "$location", "$window",
    function($scope , $http , $stateParams, $resource, $location, $window) {
        $scope.newExercise = {
            hidden: false,
            anamnesis: ""
        };

        var Exercise = $resource('/exercises.json');

        $scope.createExercise = function() {
            if ($scope.createExerciseForm.$valid) {
                Exercise.save($scope.newExercise,
                    function(data) {
                        $window.alert("Casen luominen onnistui!");
                        $location.path("/exercises/" + data.id);
                    },
                    function() {
                        $window.alert("Casen luominen epäonnistui!");
                    }
                );
            }
        };


    }
]);