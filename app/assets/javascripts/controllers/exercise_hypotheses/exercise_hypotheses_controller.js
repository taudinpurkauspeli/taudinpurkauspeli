var app = angular.module('diagnoseDiseases');

app.controller("ExerciseHypothesesController", [
    "$scope","$http","$stateParams", "$resource", "$location", "$window",
    function($scope , $http , $stateParams, $resource, $location, $window) {
        $scope.exercisesList = [];

        var ExerciseHypothesis = $resource('/exercise_hypotheses/:exerciseHypothesisId.json',
            {"exerciseHypothesisId": "@id"},
            { "create": { "method": "POST" }});

        var ExerciseHypotheses = $resource('/exercise_hypotheses.json');
        $scope.exerciseHypotheses = ExerciseHypotheses.get({"exercise_id": $stateParams.id});

        var HypothesisBank = $resource('/hypothesis_bank.json');
        $scope.hypothesisBank= HypothesisBank.get({"exercise_id": $stateParams.id});

        $scope.removedFromExercise = function(exercise_hypothesis){

            ExerciseHypothesis.delete({exerciseHypothesisId: exercise_hypothesis.id}, function() {
                $scope.exerciseHypotheses = ExerciseHypotheses.get({"exercise_id": $stateParams.id});
                $scope.hypothesisBank= HypothesisBank.get({"exercise_id": $stateParams.id});
                // $window.alert("Diffin poistaminen casesta onnistui!");
            });

        };

        $scope.addedToExercise = function(hypothesis){
            newExerciseHypothesis = {
                exercise_id: $stateParams.id,
                hypothesis_id: hypothesis.id
            };
            ExerciseHypotheses.save(newExerciseHypothesis,
                function() {
                    $scope.exerciseHypotheses = ExerciseHypotheses.get({"exercise_id": $stateParams.id});
                    $scope.hypothesisBank= HypothesisBank.get({"exercise_id": $stateParams.id});
                    //   $window.alert(hypothesis.id + " Lisätty ryhmään " + $stateParams.id);
                },
                function() {
                    $window.alert("Diffiä ei voitu lisätä caseen.");
                }
            );
        };

    }
]);