var app = angular.module('diagnoseDiseases');

app.controller("UpdateQuestionModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', "question",
    function($scope, $uibModalInstance, $resource, $window, question) {

        $scope.question = question;

        $scope.questionGroups = [];

        $scope.answer_types = [
            {name_fi: "Pakollinen kysymys", name_en: "required"},
            {name_fi: "Sallittu kysymys", name_en: "allowed"},
            {name_fi: "Väärä kysymys", name_en: "wrong"}
        ];

        var Question = $resource('/questions/:questionId.json',
            { questionId: "@id"},
            { update: { method: 'PUT' }});

        var QuestionGroups = $resource('/question_groups.json');

        $scope.setQuestionGroups = function() {
            QuestionGroups.query(function(data) {
                $scope.questionGroups = data;
            });
        };

        $scope.setQuestionGroups();

        $scope.updateQuestion = function() {
            if ($scope.updateQuestionForm.$valid) {
                if ($scope.question.question_group) {
                    $scope.question.question_group_attributes = {
                        title: $scope.question.question_group.title,
                        id: $scope.question.question_group.id
                    };
                }
                Question.update({questionId: $scope.question.id}, {question: $scope.question}, function() {
                    $.notify({
                        message: "Kysymyksen päivitys onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                    $uibModalInstance.close();
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
            }
        };

        $scope.deleteQuestion = function() {
            var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa kysymyksen pohdinnasta?");

            if (deleteConfirmation) {
                Question.delete({questionId: $scope.question.id}, function() {
                    $.notify({
                        message: "Kysymyksen poistaminen pohdinnasta onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                    $uibModalInstance.close();
                });

            } else {
                $.notify({
                    message: "Kysymystä ei poistettu pohdinnasta."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            }
        };

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);