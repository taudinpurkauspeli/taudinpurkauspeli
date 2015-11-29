var app = angular.module('diagnoseDiseases');

app.controller("ExerciseHypothesesController", [
    "$scope","$http","$routeParams", "$resource", "$location",
    function($scope , $http , $routeParams, $resource, $location) {
        $scope.exercisesList = [];

        var ExerciseHypotheses = $resource('/exercise_hypotheses.json');
        $scope.exerciseHypotheses = ExerciseHypotheses.get({"exercise_id": $routeParams.id});

        var HypothesisGroups = $resource('/hypothesis_groups.json');
        $scope.hypothesisGroups = HypothesisGroups.query();

        var Hypotheses = $resource('/hypotheses_all.json');
        $scope.hypotheses = Hypotheses.query();


    }
]);