var app = angular.module('diagnoseDiseases');

app.controller("CompleteConclusionController", [
    "$scope", "$resource", "$window", "$uibModal", "$stateParams", "$state", "$filter", "LocalStorageService",
    function($scope, $resource, $window, $uibModal, $stateParams, $state, $filter, LocalStorageService) {

        var ExerciseHypotheses = $resource('/exercise_hypotheses_conclusion.json');
        var CheckAnswersConclusion = $resource('/conclusions/:id/check_answers.json',
            {id: '@id'});
        var CheckedHypotheses = $resource('/checked_hypotheses.json');
        var UncheckedHypotheses = $resource('/unchecked_hypotheses.json');
        var CorrectDiagnosis = $resource('/correct_diagnosis.json');

        $scope.setCheckedHypotheses = function() {
            CheckedHypotheses.query({"exercise_id": $stateParams.exerciseShowId}, function(data) {
                $scope.checkedHypotheses = data;
            });
        };

        $scope.setUncheckedHypotheses = function() {

            UncheckedHypotheses.query({"exercise_id": $stateParams.exerciseShowId}, function(data) {
                $scope.uncheckedHypotheses = LocalStorageService.getObject("unchecked_hypotheses", null);

                if(!$scope.uncheckedHypotheses){
                    LocalStorageService.setObject("unchecked_hypotheses", {ids: data});
                    $scope.uncheckedHypotheses = LocalStorageService.getObject("unchecked_hypotheses", []);
                }

                $scope.setExerciseHypotheses($scope.uncheckedHypotheses.ids);

            });
        };

        $scope.setExerciseHypotheses = function(uncheckedHypotheses) {
            ExerciseHypotheses.query({'exercise_id': $stateParams.exerciseShowId, 'unchecked_hypotheses[]': uncheckedHypotheses}, function(data) {
                $scope.exerciseHypotheses = data;
            });
        };

        $scope.setCorrectDiagnosis = function() {
            CorrectDiagnosis.get({"exercise_id": $stateParams.exerciseShowId}, function(data) {
                $scope.correctDiagnosis = data;
            });
        };

        $scope.$watch(function(){
            return $scope.subtask.conclusion.id;
        },function(newValue, oldValue){
            $scope.setAllExerciseHypotheses();
        });

        $scope.setAllExerciseHypotheses = function() {
            $scope.setCheckedHypotheses();
            $scope.setUncheckedHypotheses();
            $scope.setCorrectDiagnosis();
        };

        $scope.setAllExerciseHypotheses();

        $scope.checkAnswers = function(exerciseHypothesis) {
            if($scope.userHasCheckedHypothesis(exerciseHypothesis)){
                $scope.setExerciseHypothesisId(exerciseHypothesis.id);
            } else {
                CheckAnswersConclusion.save({ id: $scope.subtask.conclusion.id, exhyp_id: exerciseHypothesis.id, current_exercise_id: $stateParams.exerciseShowId, current_task_id: $stateParams.taskShowId }, function(data) {
                    if(data.status == 202){
                        $window.alert("Onneksi olkoon suoritit casen!");
                    }
                    $scope.setTask();
                }, function(result) {
                    $scope.setCheckedHypotheses();
                    $scope.setExerciseHypothesisId(exerciseHypothesis.id);
                });
            }
        };

        $scope.hypothesisIsCorrectDiagnosis = function(exerciseHypothesis) {
            return $scope.correctDiagnosis.id == exerciseHypothesis.id;
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

        $scope.userClickedCheckedHypothesis = function(exerciseHypothesis) {
            return exerciseHypothesis.id == $scope.lastClickedExerciseHypothesis;
        };

    }
]);