var app = angular.module('diagnoseDiseases');

app.controller("ExerciseHypothesesController", [
    "$scope","$http","$stateParams", "$resource", "$location", "$window", "$state",
    function($scope , $http , $stateParams, $resource, $location, $window, $state) {

        var ExerciseHypothesis = $resource('/exercise_hypotheses/:exerciseHypothesisId.json',
            {"exerciseHypothesisId": "@id"},
            { "create": { "method": "POST" }});

        var ExerciseHypotheses = $resource('/exercise_hypotheses.json');
        $scope.exerciseHypotheses = ExerciseHypotheses.get({"exercise_id": $stateParams.id});

        var HypothesisBank = $resource('/hypothesis_bank.json');
        $scope.hypothesisBank= HypothesisBank.get({"exercise_id": $stateParams.id});

        $scope.removedFromExercise = function(exercise_hypothesis){

            ExerciseHypothesis.delete({exerciseHypothesisId: exercise_hypothesis.id}, function() {
                ExerciseHypotheses.get({"exercise_id": $stateParams.id}, function(data){
                    $scope.exerciseHypotheses = data;
                });

                HypothesisBank.get({"exercise_id": $stateParams.id}, function(data){
                    $scope.hypothesisBank = data;
                });
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
                    ExerciseHypotheses.get({"exercise_id": $stateParams.id}, function(data){
                        $scope.exerciseHypotheses = data;
                    });

                    HypothesisBank.get({"exercise_id": $stateParams.id}, function(data){
                        $scope.hypothesisBank = data;
                    });
                    //   $window.alert(hypothesis.id + " Lisätty ryhmään " + $stateParams.id);
                },
                function() {
                    $window.alert("Diffiä ei voitu lisätä caseen.");
                }
            );
        };

    }
]);