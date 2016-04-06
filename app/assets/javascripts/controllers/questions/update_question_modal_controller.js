var app = angular.module('diagnoseDiseases');

app.controller("UpdateQuestionModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', "question",
    function($scope, $uibModalInstance, $resource, $window, question) {

        $scope.question = question;

        var Question = $resource('/questions/:questionId.json',
            { questionId: "@id"},
            { update: { method: 'PUT' }});

        $scope.updateQuestion = function() {
            if ($scope.updateQuestionForm.$valid) {
                if($scope.question.question_group) {
                    $scope.question.question_group_attributes = {
                        title: $scope.question.question_group.title,
                        id: $scope.question.question_group.id
                    };
                }
                Question.update({questionId: $scope.question.id}, {question: $scope.question}, function() {
                    $window.alert("Kysymyksen päivitys onnistui!");
                    $uibModalInstance.close();
                }, function() {
                    $window.alert("Kysymyksen päivitys epäonnistui!");
                });
            }
        };

        $scope.deleteQuestion = function() {
            var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa kysymyksen?");

            if (deleteConfirmation) {
                Question.delete({questionId: $scope.question.id}, function() {
                    $window.alert("Kysymyksen poistaminen onnistui!");
                    $uibModalInstance.close();
                });

            } else {
                $window.alert("Kysymystä ei poistettu");
            }
        };

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);