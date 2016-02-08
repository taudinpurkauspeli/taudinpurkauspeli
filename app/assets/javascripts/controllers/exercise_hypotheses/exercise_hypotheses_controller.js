var app = angular.module('diagnoseDiseases');

app.controller("ExerciseHypothesesController", [
    "$scope","$http","$stateParams", "$resource", "$location", "$window", "$state", "$uibModal",
    function($scope , $http , $stateParams, $resource, $location, $window, $state, $uibModal) {

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


        $scope.addToExercise = function(hypothesis){
            var newExerciseHypothesis = {
                exercise_id: $stateParams.id,
                hypothesis_id: hypothesis.id,
                explanation: ""
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
        };


        $scope.updateExerciseHypothesis = function (exerciseHypothesis) {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'exercise_hypotheses/update_exercise_hypothesis_modal.html',
                controller: 'UpdateExerciseHypothesisModalController',
                size: 'lg',
                resolve: {
                    exerciseHypothesis: exerciseHypothesis
                }
            });

            modalInstance.result.then(function () {
                $scope.updateAllExerciseHypotheses();
            }, function () {
                alert("Casen diffin päivitys peruttu.");
            });
        };

    }
]);