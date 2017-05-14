var app = angular.module('diagnoseDiseases');

app.controller("QuestionsEditController", [
    "$scope", "$resource", "$window", "$uibModal", "$stateParams",
    function($scope, $resource, $window, $uibModal, $stateParams) {

        $scope.answer_types = [{
            name_fi: "Pakolliset kysymykset",
            name_en: "required",
            allowed_types: ['allowed', 'wrong']
        }, {
            name_fi: "Sallitut kysymykset",
            name_en: "allowed",
            allowed_types: ['required', 'wrong']
        }, {
            name_fi: "Väärät kysymykset",
            name_en: "wrong",
            allowed_types: ['required', 'allowed']
        }
        ];

        var Questions = $resource('/questions_admin.json');

        var QuestionsOnly = $resource('/questions_only.json');

        var Question = $resource('/questions/:questionId.json',
            { questionId: "@id"},
            { update: { method: 'PUT' }});

        $scope.setQuestions = function() {
            Questions.get({ interview_id: $stateParams.interviewShowId}, function onSuccess(data) {
                $scope.questionsByGroup = data.questions_by_group;
                $scope.questionsWithoutGroup = data.questions_without_group;
                if (data.questions_without_group) {
                    $scope.thereAreQuestionsWithoutGroup = (data.questions_without_group.length > 0);
                } else {
                    $scope.thereAreQuestionsWithoutGroup = false;
                }
            }, function onError() {

            });
        };

        $scope.setQuestionsOnly = function() {
            QuestionsOnly.query({interview_id: $stateParams.interviewShowId}, function(data) {
                $scope.questionsOnly = data;
            }, function() {

            });
        };

        $scope.setAllQuestions = function() {
            $scope.setQuestions();
            $scope.setQuestionsOnly();
        };

        $scope.setAllQuestions();

        $scope.moveQuestionToNewType = function(question, newType) {

            question.required = newType;

            Question.update({questionId: question.id}, question, function() {
                $scope.setAllQuestions();
            }, function() {
                $.notify({
                    message: "Kysymyksen päivitys epäonnistui!"
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "danger",
                    offset: 100
                });
            });
        };

        $scope.addToInterview = function(interview, title) {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'questions/create_question_modal.html',
                controller: 'CreateQuestionModalController',
                size: 'lg',
                resolve: {
                    interview: interview,
                    title: title
                }
            });

            modalInstance.result.then(function() {
                $scope.setAllQuestions();
            }, function() {
            });

        };

        $scope.updateQuestion = function(question) {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'questions/update_question_modal.html',
                controller: 'UpdateQuestionModalController',
                size: 'lg',
                resolve: {
                    question: question
                }
            });

            modalInstance.result.then(function() {
                $scope.setAllQuestions();
            }, function() {
            });

        };

        $scope.questionIs = function(questionStatus, question) {
            return question.required === questionStatus;
        };

        $scope.belongsToInterview = function(questionTitle) {

            for (var i = 0; i < $scope.questionsOnly.length; i++) {
                var questionValue = $scope.questionsOnly[i];
                if (questionValue.title.id === questionTitle.id){
                    return true;
                }
            }
            return false;
        };
    }
]);
