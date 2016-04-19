var app = angular.module('diagnoseDiseases');

app.controller("ExerciseHypothesesController", [
    "$scope", "$stateParams", "$resource", "$window", "$uibModal",
    function($scope, $stateParams, $resource, $window, $uibModal) {

        var ExerciseHypotheses = $resource('/exercise_hypotheses.json');
        var ExerciseHypothesesOnly = $resource('/exercise_hypotheses_only.json');
        var CheckedHypotheses = $resource('/checked_hypotheses.json');

        $scope.setExerciseHypotheses = function() {
            ExerciseHypotheses.get({"exercise_id": $stateParams.exerciseShowId}, function(data) {
                $scope.exerciseHypotheses = data;
            });
        };

        $scope.setExerciseHypothesesOnly = function() {
            ExerciseHypothesesOnly.query({"exercise_id": $stateParams.exerciseShowId}, function(data) {
                $scope.exerciseHypothesesOnly = data;
            });
        };

        $scope.setCheckedHypotheses = function() {
            CheckedHypotheses.query({"exercise_id": $stateParams.exerciseShowId}, function(data) {
                $scope.checkedHypotheses = data;
            });
        };

        $scope.setAllExerciseHypotheses = function() {
            $scope.setExerciseHypotheses();

            if($scope.currentUserAdmin){
                $scope.setExerciseHypothesesOnly();
            }

            if($scope.currentUser && !$scope.currentUserAdmin){
                $scope.setCheckedHypotheses();
            }
        };

        $scope.setAllExerciseHypotheses();
        $scope.setActiveTab("HypothesisTab");

        $scope.addToExercise = function(hypothesis) {
            var newExerciseHypothesis = {
                exercise_id: $stateParams.exerciseShowId,
                hypothesis_id: hypothesis.id,
                explanation: ""
            };

            ExerciseHypotheses.save(newExerciseHypothesis,
                function() {
                    $scope.setAllExerciseHypotheses();
                },
                function() {
                    $window.alert("Diffiä ei voitu lisätä caseen.");
                }
            );
        };

        $scope.belongsToExercise = function(hypothesis) {

            for(var i = 0; i < $scope.exerciseHypothesesOnly.length; i++) {
                var hypothesisValue = $scope.exerciseHypothesesOnly[i];
                if(hypothesisValue.id == hypothesis.id){
                    return true;
                }
            }
            return false;
        };


        $scope.updateExerciseHypothesis = function(exerciseHypothesis) {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'exercise_hypotheses/update_exercise_hypothesis_modal.html',
                controller: 'UpdateExerciseHypothesisModalController',
                size: 'lg',
                resolve: {
                    exerciseHypothesis: exerciseHypothesis
                }
            });

            modalInstance.result.then(function() {
                $scope.setAllExerciseHypotheses();
            }, function() {
                $window.alert("Casen diffin päivitys peruttu.");
            });
        };

        $scope.hypothesisIsCorrectDiagnosis = function(exerciseHypothesis) {
            // @correct_diagnosis && @correct_diagnosis.hypothesis.id == exercise_hypothesis.hypothesis.id
            return false;
        };

        $scope.userHasCheckedHypothesis = function(exerciseHypothesis) {
            for(var i = 0; i < $scope.checkedHypotheses.length; i++) {
                var checkedHypothesis = $scope.checkedHypotheses[i];
                if(checkedHypothesis.exercise_hypothesis_id == exerciseHypothesis.id){
                    return true;
                }
            }
            return false;
        };

        $scope.setExerciseHypothesisId = function(exerciseHypothesisId){
            if($scope.lastClickedExerciseHypothesis == exerciseHypothesisId){
                $scope.lastClickedExerciseHypothesis = null;
            } else {
                $scope.lastClickedExerciseHypothesis = exerciseHypothesisId;
            }
        };

        $scope.checkExerciseHypothesis = function(exerciseHypothesis) {
            if($scope.userHasCheckedHypothesis(exerciseHypothesis)){
                $scope.setExerciseHypothesisId(exerciseHypothesis.id);
            } else {
console.log("Palvelimelle jutut");
/*                                    <%= form_for(@new_checked_hypothesis) do |f| %>
                                    <%= f.hidden_field :exercise_hypothesis_id, :value => exercise_hypothesis.id %>
                                    <%= f.hidden_field :user_id, :value => @current_user.id %>
                                    <%= f.submit exercise_hypothesis.hypothesis.name, :class => 'btn btn-default multiline' %>*/
            }

        };

        $scope.userClickedCheckedHypothesis = function(exerciseHypothesis) {
            return exerciseHypothesis.id == $scope.lastClickedExerciseHypothesis;
        };

    }
]);