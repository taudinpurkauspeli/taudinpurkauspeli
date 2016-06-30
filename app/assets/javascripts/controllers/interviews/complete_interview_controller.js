var app = angular.module('diagnoseDiseases');

app.controller("CompleteInterviewController", [
    "$scope", "$resource", "$window", "$uibModal", "$stateParams", "$state", "$filter",
    function($scope, $resource, $window, $uibModal, $stateParams, $state, $filter) {

        var Questions = $resource('/questions_interview.json');
        var CheckAnswersInterview = $resource('/interviews/:id/check_answers.json',
            {id: '@id'});
        var AskQuestion = $resource('/questions/:id/ask.json',
            {id: '@id'});

        $scope.setQuestions = function() {
            Questions.get({ interview_id : $scope.subtask.interview.id}, function(data) {
                $scope.questionsByGroup = data.questions_by_group;
                $scope.questionsWithoutGroup = data.questions_without_group;
            });
        };

        $scope.setQuestions();

        $scope.checkAnswers = function() {
            CheckAnswersInterview.save({ id: $scope.subtask.interview.id }, function() {
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