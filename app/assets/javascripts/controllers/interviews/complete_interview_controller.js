var app = angular.module('diagnoseDiseases');

app.controller("CompleteInterviewController", [
    "$scope", "$resource", "$window", "$uibModal", "$stateParams", "$state", "$filter",
    function($scope, $resource, $window, $uibModal, $stateParams, $state, $filter) {

        var Questions = $resource('/questions_interview.json');
        var CheckAnswersInterview = $resource('/interviews/:id/check_answers.json',
            {id: '@id'});
        var AskQuestion = $resource('/questions/:id/ask.json',
            {id: '@id'});

        $scope.changeQuestionCollapse = function(question) {
            question.collapsed = !question.collapsed;
        };

        $scope.checkQuestionsWithGroup = function() {
            angular.forEach($scope.questionsByGroup, function(questions, key) {
                for(var i = 0; i < questions.length; i++) {
                    if(questions[i].id == $scope.asked_last_id) {
                        $scope.changeQuestionCollapse(questions[i]);
                    }
                }
            });
        };

        $scope.checkQuestionsWithoutGroup = function() {
            for(var i = 0; i < $scope.questionsWithoutGroup.length; i++) {
                if($scope.questionsWithoutGroup[i].id == $scope.asked_last_id) {
                    $scope.changeQuestionCollapse($scope.questionsWithoutGroup[i]);
                }
            }
        };

        $scope.setLastAskedQuestion = function() {
            if ($scope.asked_last_id) {
                $scope.checkQuestionsWithGroup();
                $scope.checkQuestionsWithoutGroup();
            }
        };

        $scope.setQuestions = function() {
            Questions.get({ interview_id : $scope.subtask.interview.id}, function(data) {
                $scope.questionsByGroup = data.questions_by_group;
                $scope.questionsWithoutGroup = data.questions_without_group;
                $scope.setLastAskedQuestion();
            });
        };

        $scope.$watch(function(){
            return $scope.subtask.interview.id;
        },function(newValue, oldValue){
            $scope.setQuestions();
        });

        $scope.setQuestions();

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