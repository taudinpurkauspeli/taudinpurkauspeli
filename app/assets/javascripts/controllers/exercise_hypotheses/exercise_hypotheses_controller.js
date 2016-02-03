var app = angular.module('diagnoseDiseases');

app.controller("ExerciseHypothesesController", [
    "$scope","$http","$stateParams", "$resource", "$location", "$window", "$state",
    function($scope , $http , $stateParams, $resource, $location, $window, $state) {

        var ExerciseHypothesis = $resource('/exercise_hypotheses/:exerciseHypothesisId.json',
            { exerciseHypothesisId: "@id"},
            { create: { method: 'POST' }});

        var ExerciseHypotheses = $resource('/exercise_hypotheses.json');
        var HypothesisBank = $resource('/hypothesis_bank.json');

        $scope.updateExerciseHypotheses = function(){
            ExerciseHypotheses.get({"exercise_id": $stateParams.id}, function(data){
                $scope.exerciseHypotheses = data;
            });
        };

        $scope.updateHypothesisBank = function(){
            HypothesisBank.get({"exercise_id": $stateParams.id}, function(data){
                $scope.hypothesisBank = data;
            });
        };

        $scope.updateExerciseHypotheses();
        $scope.updateHypothesisBank();

        $scope.removeFromExercise = function(exercise_hypothesis){

            ExerciseHypothesis.delete({exerciseHypothesisId: exercise_hypothesis.id}, function() {
                $scope.updateExerciseHypotheses();
                $scope.updateHypothesisBank();
            });

        };

        $scope.addToExercise = function(hypothesis){
            newExerciseHypothesis = {
                exercise_id: $stateParams.id,
                hypothesis_id: hypothesis.id
            };
            ExerciseHypotheses.save(newExerciseHypothesis,
                function() {
                    $scope.updateExerciseHypotheses();
                    $scope.updateHypothesisBank();
                },
                function() {
                    $window.alert("Diffiä ei voitu lisätä caseen.");
                }
            );
        };

    }
]);