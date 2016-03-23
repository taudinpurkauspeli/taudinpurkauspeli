var app = angular.module('diagnoseDiseases');

app.controller("QuestionsEditController", [
    "$scope", "$resource", "$window", "$uibModal",
    function($scope, $resource, $window, $uibModal) {

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
            Questions.get({ interview_id : $scope.interview.id}, function(data) {
                $scope.questions = data;
            });
        };

        $scope.setQuestions();

        $scope.moveQuestionToNewType = function(question, newType){

            question.required = newType;

            Question.update({questionId: question.id}, question, function() {
                $scope.setQuestions();
            }, function() {
                $window.alert("Kysymyksen päivitys epäonnistui!");
            });
        };
/*
        $scope.createOption = function(multichoice){

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'options/create_option_modal.html',
                controller: 'CreateOptionModalController',
                size: 'lg',
                resolve: {
                    multichoice: multichoice
                }
            });

            modalInstance.result.then(function() {
                $scope.setOptions();
            }, function() {
                $window.alert("Vastausvaihtoehdon luominen peruttu.");
            });

        };

        $scope.updateOption = function(option){

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'options/update_option_modal.html',
                controller: 'UpdateOptionModalController',
                size: 'lg',
                resolve: {
                    option: option
                }
            });

            modalInstance.result.then(function() {
                $scope.setOptions();
            }, function() {
                $window.alert("Vastausvaihtoehdon muokkaaminen peruttu.");
            });

        };*/

    }
]);