var app = angular.module('diagnoseDiseases');

app.controller("ExerciseHypothesesController", [
    "$scope","$http","$routeParams", "$resource", "$location",
    function($scope , $http , $routeParams, $resource, $location) {
        $scope.exercisesList = [];

        var ExerciseHypotheses = $resource('/exercise_hypotheses.json');
        $scope.exerciseHypotheses = ExerciseHypotheses.get({"exercise_id": $routeParams.id});

        var HypothesisBank = $resource('/hypothesis_bank.json');
        $scope.hypothesisBank= HypothesisBank.get({"exercise_id": $routeParams.id});

        $scope.removedFromExercise = function(){
            alert("Poistettu ryhmästä");
        }
        $scope.addedToExercise = function(){
            alert("Lisätty ryhmään");
        }

    }
]);