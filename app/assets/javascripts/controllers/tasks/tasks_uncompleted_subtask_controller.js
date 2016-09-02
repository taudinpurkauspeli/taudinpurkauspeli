var app = angular.module('diagnoseDiseases');

app.controller("TasksUncompletedSubtaskController", [
    "$scope", "$stateParams", "$resource", "$window",
    function($scope, $stateParams, $resource, $window) {

        var TaskText = $resource('/task_texts/:taskTextId/check_answers.json',
            { taskTextId: "@id"});

        $scope.setSubtask = function() {
            if($scope.subtask.conclusion){
                //get something
            }
        };

        $scope.completeTaskText = function(task_text){
            TaskText.save({taskTextId: task_text.id}, task_text,
                function(data) {
                    if(data.status == 202){
                        $.notify({
                            message: "Onneksi olkoon suoritit casen!"
                        }, {
                            placement: {
                                align: "center"
                            },
                            type: "success",
                            delay: 0,
                            offset: 100
                        });
                    }
                    $scope.setTask();
                }, function() {
                    $.notify({
                        message: "Tehtävän suoritus epäonnistui."
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "danger",
                        offset: 100
                    });
                }
            );
        };


    }
]);