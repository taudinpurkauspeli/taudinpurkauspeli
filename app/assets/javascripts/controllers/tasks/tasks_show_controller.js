var app = angular.module('diagnoseDiseases');

app.controller("TasksShowController", [
    "$scope", "$window", "$uibModal", "$state",
    function($scope, $window, $uibModal, $state) {

        $scope.setTaskShowPath("exercises_show.current_task.show", {});

        $scope.updateTask = function(task){
            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'tasks/update_task_modal.html',
                controller: 'UpdateTaskModalController',
                size: 'lg',
                resolve: {
                    task: task
                }
            });

            modalInstance.result.then(function(data) {
                if(data.taskRemoved){
                    $scope.removeCurrentTask();
                    $state.go("exercises_show.tasks");
                }
            }, function() {
                $.notify({
                    message: "Toimenpiteen päivitys peruttu."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            });

        };

        $scope.createTaskText = function(task) {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'task_texts/create_task_text_modal.html',
                controller: 'CreateTaskTextModalController',
                size: 'lg',
                resolve: {
                    task: task
                }
            });

            modalInstance.result.then(function(data) {
                $scope.setTask();
                $scope.editTaskText(data);
            }, function() {
                $.notify({
                    message: "Tekstialakohdan luominen peruttu."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            });
        };

        $scope.createMultichoice= function(task) {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'multichoices/create_multichoice_modal.html',
                controller: 'CreateMultichoiceModalController',
                size: 'lg',
                resolve: {
                    task: task
                }
            });

            modalInstance.result.then(function(data) {
                $scope.setTask();
                $scope.editMultichoice(data);
            }, function() {
                $.notify({
                    message: "Monivalinnan luominen peruttu."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            });
        };

        $scope.createInterview= function(task) {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'interviews/create_interview_modal.html',
                controller: 'CreateInterviewModalController',
                size: 'lg',
                resolve: {
                    task: task
                }
            });

            modalInstance.result.then(function(data) {
                $scope.setTask();
                $scope.editInterview(data);
            }, function() {
                $.notify({
                    message: "Pohdinnan luominen peruttu."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            });
        };

        $scope.createConclusion = function(task) {

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'conclusions/create_conclusion_modal.html',
                controller: 'CreateConclusionModalController',
                size: 'lg',
                resolve: {
                    task: task
                }
            });

            modalInstance.result.then(function(data) {
                $scope.setTask();
                $scope.setExercise();
                $scope.editConclusion(data);
            }, function() {
                $.notify({
                    message: "Diagnoosin luominen peruttu."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            });
        };

        $scope.editTaskText = function(taskText) {
            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'task_texts/update_task_text_modal.html',
                controller: 'UpdateTaskTextModalController',
                size: 'lg',
                resolve: {
                    taskText: taskText
                }
            });

            modalInstance.result.then(function(data) {
                $scope.setTask();
            }, function() {
                $.notify({
                    message: "Tekstialakohdan päivitys peruttu."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            });
        };

        $scope.editConclusion = function(conclusion) {
            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'conclusions/update_conclusion_modal.html',
                controller: 'UpdateConclusionModalController',
                size: 'lg',
                resolve: {
                    conclusion: conclusion
                }
            });

            modalInstance.result.then(function(data) {
                $scope.setTask();
                if(data.conclusionRemoved){
                    $scope.setExercise();
                }
            }, function() {
                $.notify({
                    message: "Diagnoosin päivitys peruttu."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            });
        };

        $scope.editMultichoice= function(multichoice) {
            $state.go("exercises_show.current_task.multichoice", {multichoiceShowId: multichoice.id});
        };

        $scope.editInterview= function(interview) {
            $state.go("exercises_show.current_task.interview", {interviewShowId: interview.id});
        };


    }
]);