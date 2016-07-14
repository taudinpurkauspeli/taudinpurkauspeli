var app = angular.module('diagnoseDiseases');

app.controller("CompleteConclusionController", [
    "$scope", "$resource", "$window", "$uibModal", "$stateParams", "$state", "$filter",
    function($scope, $resource, $window, $uibModal, $stateParams, $state, $filter) {

        var ExerciseHypotheses = $resource('/exercise_hypotheses_conclusion.json');
        var CheckAnswersInterview = $resource('/interviews/:id/check_answers.json',
            {id: '@id'});
        var AskQuestion = $resource('/questions/:id/ask.json',
            {id: '@id'});

        $scope.setExerciseHypotheses = function() {
            ExerciseHypotheses.query({ exercise_id : $stateParams.exerciseShowId}, function(data) {
                $scope.exerciseHypotheses = data;
            });
        };

        $scope.$watch(function(){
            return $scope.subtask.conclusion.id;
        },function(newValue, oldValue){
            $scope.setExerciseHypotheses();
        });

        $scope.setExerciseHypotheses();

        $scope.checkAnswers = function() {
            CheckAnswersInterview.save({ id: $scope.subtask.interview.id }, function(data) {
                if(data.status == 202){
                    $window.alert("Onneksi olkoon suoritit casen!");
                }
                $scope.setTask();
            }, function(result) {
                $window.alert("Et ole vielä valinnut kaikkia tarpeellisia vaihtoehtoja");
            });
        };

        $scope.askQuestion = function(question) {
            AskQuestion.save({id: question.id}, function(data) {
                $scope.asked_last_id = data.asked_last;
                $scope.setQuestions();
            });
        };

        $scope.questionIs = function(questionStatus, question) {
            return question.required === questionStatus;
        };

        $scope.questionWasAskedLast = function(question) {
            return question.id == $scope.asked_last_id;
        }

    }
]);