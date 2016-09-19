var app = angular.module('diagnoseDiseases');

app.controller("CreateQuestionModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', "interview",
    function($scope, $uibModalInstance, $resource, $window, interview) {

        $scope.newQuestion = {
            interview_id: interview.id,
            title: "",
            content: "",
            required: "allowed",
            question_group_attributes: {
                title: ""
            }
        };

        $scope.answer_types = [
            {name_fi: "Pakollinen kysymys", name_en: "required"},
            {name_fi: "Sallittu kysymys", name_en: "allowed"},
            {name_fi: "Väärä kysymys", name_en: "wrong"}
        ];

        var Question = $resource('/questions_json_create.json');

        var QuestionGroups = $resource('/question_groups.json');

        $scope.setQuestionGroups = function() {
            QuestionGroups.query(function(data) {
                $scope.question_groups = data;
            });
        };

        $scope.setQuestionGroups();

        $scope.createQuestion = function() {
            if ($scope.createQuestionForm.$valid) {
                Question.save({question: $scope.newQuestion},
                    function() {
                        $.notify({
                            message: "Kysymyksen luominen onnistui!"
                        }, {
                            placement: {
                                align: "center"
                            },
                            type: "success",
                            offset: 100
                        });
                        $uibModalInstance.close();
                    },
                    function() {
                        $.notify({
                            message: "Kysymyksen luominen epäonnistui!"
                        }, {
                            placement: {
                                align: "center"
                            },
                            type: "danger",
                            offset: 100
                        });
                    }
                );
            }
        };

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);