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
                        $.notify({
                            message: "Diagnoosi-alakohdan luominen onnistui!"
                        }, {
                            placement: {
                                align: "center"
                            },
                            type: "success",
                            offset: 100
                        });
                        $uibModalInstance.close(data);
                    },
                    function() {
                        $.notify({
                            message: "Diagnoosi-alakohdan luominen epäonnistui!"
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