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

        var Questions = $resource('/questions.json');

        var Question = $resource('/questions/:questionId.json',
            { questionId: "@id"},
            { update: { method: 'PUT' }});

        $scope.setQuestions = function() {
            Questions.get({ interview_id : $stateParams.interviewShowId}, function(data) {
                $scope.questions = data;
            });
        };

        $scope.setQuestions();

        $scope.moveQuestionToNewType = function(question, newType) {

            question.required = newType;

            Question.update({questionId: question.id}, question, function() {
                $scope.setQuestions();
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

        $scope.createQuestion = function(interview) {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'questions/create_question_modal.html',
                controller: 'CreateQuestionModalController',
                size: 'lg',
                resolve: {
                    interview: interview
                }
            });

            modalInstance.result.then(function() {
                $scope.setQuestions();
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
                $scope.setQuestions();
            }, function() {
            });

        };

    }
]);