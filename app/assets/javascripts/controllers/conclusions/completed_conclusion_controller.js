var app = angular.module('diagnoseDiseases');

app.controller("CompletedConclusionController", [
    "$scope", "$resource", "$window", "$uibModal", "$stateParams", "$state", "$filter", "LocalStorageService",
    function($scope, $resource, $window, $uibModal, $stateParams, $state, $filter, LocalStorageService) {

        var ExerciseHypotheses = $resource('/exercise_hypotheses_conclusion.json');
        var CheckedHypotheses = $resource('/checked_hypotheses.json');
        var CorrectDiagnosis = $resource('/correct_diagnosis.json');

        $scope.setCheckedHypotheses = function() {
            CheckedHypotheses.query({"exercise_id": $stateParams.exerciseShowId}, function(data) {
                $scope.checkedHypotheses = data;
            }, function() {

            });
        };

        $scope.setExerciseHypotheses = function() {
            var uncheckedHypotheses = LocalStorageService.getObject("unchecked_hypotheses", '{"ids": "[]"}');
            ExerciseHypotheses.query({'exercise_id': $stateParams.exerciseShowId, 'unchecked_hypotheses[]': uncheckedHypotheses.ids}, function(data) {
                $scope.exerciseHypotheses = data;
                if (data){
                    $scope.thereAreExerciseHypotheses = (data.length > 1);
                } else {
                    $scope.thereAreExerciseHypotheses = false;
                }
            }, function() {

            });
        };

        $scope.openCheckedHypothesis = function(exerciseHypothesis){
            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'exercise_hypotheses/show_exercise_hypothesis_modal.html',
                controller: 'ShowExerciseHypothesisModalController',
                size: 'md',
                resolve: {
                    exerciseHypothesis: exerciseHypothesis,
                    correctDiagnosis: $scope.correctDiagnosis
                }
            });

            modalInstance.result.then(function() {
            }, function() {
            });
        };

        $scope.setExerciseHypothesisCollapse = function(exerciseHypothesis) {
            exerciseHypothesis.collapsed = !exerciseHypothesis.collapsed;
        };

        $scope.setCorrectDiagnosis = function() {
            CorrectDiagnosis.get({"exercise_id": $stateParams.exerciseShowId}, function(data) {
                $scope.correctDiagnosis = data;
                $scope.setExerciseHypothesisId(data.id);
            }, function() {

            });
        };

        $scope.setAllExerciseHypotheses = function() {
            $scope.setExerciseHypotheses();
            $scope.setCheckedHypotheses();
            $scope.setCorrectDiagnosis();

        };

        $scope.setAllExerciseHypotheses();

        $scope.hypothesisIsCorrectDiagnosis = function(exerciseHypothesis) {
            return $scope.correctDiagnosis.id === exerciseHypothesis.id;
        };

        $scope.userHasCheckedHypothesis = function(exerciseHypothesis) {
            for(var i = 0; i < $scope.checkedHypotheses.length; i++) {
                var checkedHypothesis = $scope.checkedHypotheses[i];
                if(checkedHypothesis.exercise_hypothesis_id === exerciseHypothesis.id){
                    return true;
                }
            }
            return false;
        };

        $scope.setExerciseHypothesisId = function(exerciseHypothesisId){
            if($scope.lastClickedExerciseHypothesis === exerciseHypothesisId){
                $scope.lastClickedExerciseHypothesis = null;
            } else {
                $scope.lastClickedExerciseHypothesis = exerciseHypothesisId;
            }
        };

        $scope.userClickedCheckedHypothesis = function(exerciseHypothesis) {
            return exerciseHypothesis.id === $scope.lastClickedExerciseHypothesis;
        };

    }
]);
