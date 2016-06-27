var app = angular.module('diagnoseDiseases');

app.controller("CompleteInterviewController", [
    "$scope", "$resource", "$window", "$uibModal", "$stateParams", "$state", "$filter",
    function($scope, $resource, $window, $uibModal, $stateParams, $state, $filter) {

        var Questions = $resource('/questions_interview.json');
        var CheckAnswersInterview = $resource('/interviews/:id/check_answers.json',
            {id: '@id'});

        $scope.setQuestions = function() {
            Questions.get({ interview_id : $scope.subtask.interview.id}, function(data) {
                $scope.questionsByGroup = data.questions_by_group;
                $scope.questionsWithoutGroup = data.questions_without_group;
            });
        };

        $scope.askedQuestions = [];

        $scope.setQuestions();

        $scope.checkAnswers = function() {
            var askedQuestions = [];
            if($scope.subtask.interview.is_radio_button) {
                askedQuestions.push($scope.selectedRadiobuttonOption.id);
            } else {
                var checkedAnswers = $filter('filter')($scope.questions, {checked: true});
                angular.forEach(checkedAnswers, function(answer) {
                    askedQuestions.push(answer.id);
                });
            }

            CheckAnswersInterview.save({ id: $scope.subtask.interview.id, asked_questions: askedQuestions }, function(data) {
                $scope.setTask();
            }, function(result) {
                $scope.askedQuestions = result.data || [];
            });
        };

        $scope.askedQuestionsContains = function(question) {
            return $scope.askedQuestions.length !== 0 && $scope.askedQuestions.indexOf(question.id) !== -1;
        };

        $scope.questionIs = function(questionStatus, question) {
            return question.required === questionStatus;
        }

    }
]);