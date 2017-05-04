var app = angular.module('diagnoseDiseases');

app.controller("UpdateConclusionModalController", [
    "$scope", "$resource", "$window", "$uibModalInstance", "conclusion", "$stateParams",
    function($scope, $resource, $window, $uibModalInstance, conclusion, $stateParams) {

        $scope.conclusion = conclusion;
        $scope.exerciseHypotheses = [];

        var Conclusion = $resource('/conclusions_json/:conclusionId.json',
            { conclusionId: "@id"},
            { update: { method: 'PUT' }});
        var ExerciseHypotheses = $resource('/exercise_hypotheses_json_index.json');

        $scope.setExerciseHypotheses = function() {
            ExerciseHypotheses.query({"exercise_id": $stateParams.exerciseShowId}, function(data){
                $scope.exerciseHypotheses = data;
            }, function() {

            });
        };

        $scope.setExerciseHypotheses();

        $scope.updateConclusion = function() {
            if ($scope.updateConclusionForm.$valid) {
                Conclusion.update({conclusionId: $scope.conclusion.id}, $scope.conclusion, function() {
                    $.notify({
                        message: "Diagnoosi-alakohdan päivitys onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                    $uibModalInstance.close({conclusionRemoved: false});
                }, function() {
                    $.notify({
                        message: "Diagnoosi-alakohdan päivitys epäonnistui!"
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

        $scope.deleteConclusion = function() {
            var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa diagnoosi-alakohdan?");

            if (deleteConfirmation) {
                Conclusion.delete({conclusionId: $scope.conclusion.id}, function() {
                    $.notify({
                        message: "Diagnoosi-alakohdan poistaminen onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                    $uibModalInstance.close({conclusionRemoved: true});
                }, function() {

                });

            } else {
                $.notify({
                    message: "Diagnoosi-alakohtaa ei poistettu."
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
