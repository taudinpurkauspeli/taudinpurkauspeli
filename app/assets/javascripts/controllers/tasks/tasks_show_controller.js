var app = angular.module('diagnoseDiseases');

app.controller("TasksShowController", [
    "$scope", "$resource", "$window", "$uibModal", "$stateParams", "LocalStorageService", "$state",
    function($scope, $resource, $window, $uibModal, $stateParams, LocalStorageService, $state) {

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
                $window.alert("Toimenpiteen päivitys peruttu.");
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
                $window.alert("Tekstialakohdan luominen peruttu.");
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
                $scope.setCurrentTask();
                $scope.editMultichoice(data);
            }, function() {
                $window.alert("Monivalinnan luominen peruttu.");
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
                $scope.setCurrentTask();
                $scope.editInterview(data);
            }, function() {
                $window.alert("Pohdinnan luominen peruttu.");
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
                $window.alert("Tekstialakohdan päivitys peruttu.");
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