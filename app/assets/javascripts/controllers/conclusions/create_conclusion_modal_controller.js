var app = angular.module('diagnoseDiseases');

app.controller("CreateConclusionModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', "task", "$stateParams",
    function($scope, $uibModalInstance, $resource, $window, task, $stateParams) {

        $scope.newConclusion = {
            title: "",
            content: ""
        };

        $scope.exerciseHypotheses = [];

        var Conclusion = $resource('/conclusions_json_create.json');
        var ExerciseHypotheses = $resource('/exercise_hypotheses_json_index.json');

        $scope.setExerciseHypotheses = function() {
            ExerciseHypotheses.query({"exercise_id": $stateParams.exerciseShowId}, function(data){
                $scope.exerciseHypotheses = data;
            });
        };

        $scope.setExerciseHypotheses();

        $scope.createConclusion = function() {
            if ($scope.createConclusionForm.$valid) {
                Conclusion.save({"task_id": task.id}, $scope.newConclusion,
                    function(data) {
                        $window.alert("Diagnoosi-alakohdan luominen onnistui!");
                        $uibModalInstance.close(data);
                    },
                    function() {
                        $window.alert("Diagnoosi-alakohdan luominen epäonnistui!");
                    }
                );
            }
        };

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);