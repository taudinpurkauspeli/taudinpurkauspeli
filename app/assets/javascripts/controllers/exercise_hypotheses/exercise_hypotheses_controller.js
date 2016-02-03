var app = angular.module('diagnoseDiseases');

app.controller("ExerciseHypothesesController", [
    "$scope","$http","$stateParams", "$resource", "$location", "$window", "$state",
    function($scope , $http , $stateParams, $resource, $location, $window, $state) {

        var ExerciseHypothesis = $resource('/exercise_hypotheses/:exerciseHypothesisId.json',
            { exerciseHypothesisId: "@id"},
            { create: { method: 'POST' }});

        var ExerciseHypotheses = $resource('/exercise_hypotheses.json');
        var ExerciseHypothesesOnly = $resource('/exercise_hypotheses_only.json');

        $scope.updateExerciseHypotheses = function(){
            ExerciseHypotheses.get({"exercise_id": $stateParams.id}, function(data){
                $scope.exerciseHypotheses = data;
            });
        };

        $scope.updateExerciseHypothesesOnly = function(){
            ExerciseHypothesesOnly.query({"exercise_id": $stateParams.id}, function(data){
                $scope.exerciseHypothesesOnly = data;
            });
        };

        $scope.updateAllExerciseHypotheses = function(){
            $scope.updateExerciseHypothesesOnly();
            $scope.updateExerciseHypotheses();
        };

        $scope.updateAllExerciseHypotheses();

        $scope.removeFromExercise = function(exercise_hypothesis){

            ExerciseHypothesis.delete({exerciseHypothesisId: exercise_hypothesis.id}, function() {
                $scope.updateAllExerciseHypotheses();
            });

        };

        $scope.addToExercise = function(hypothesis){
            newExerciseHypothesis = {
                exercise_id: $stateParams.id,
                hypothesis_id: hypothesis.id
            };
            ExerciseHypotheses.save(newExerciseHypothesis,
                function() {
                    $scope.updateAllExerciseHypotheses();

                },
                function() {
                    $window.alert("Diffiä ei voitu lisätä caseen.");
                }
            );
        };

        $scope.belongsToExercise = function(hypothesis){

            for(var i = 0; i < $scope.exerciseHypothesesOnly.length; i++){
                var hypothesisValue = $scope.exerciseHypothesesOnly[i];
                if(hypothesisValue.id == hypothesis.id){
                    return true;
                }
            }
            return false;
        }

    }
]);