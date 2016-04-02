var app = angular.module('diagnoseDiseases');

app.controller("TasksShowController", [
    "$scope", "$resource", "$window", "$uibModal", "$stateParams", "LocalStorageService",
    function($scope, $resource, $window, $uibModal, $stateParams, LocalStorageService) {

        $scope.taskText = null;
        $scope.multichoice = null;
        $scope.interview = null;

        var Task = $resource('/tasks/:taskId.json',
            { taskId: "@id"},
            { update: { method: 'PUT' }});

        var TaskText = $resource('/task_texts/:taskTextId.json',
            { taskTextId: "@id"},
            { update: { method: 'PUT' }});

        $scope.setTask = function() {
            LocalStorageService.set("current_task", $stateParams.taskShowId);
            $scope.setCurrentTask();
        };

        $scope.setTask();

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
            }, function() {
                $window.alert("Toimenpiteen päivitys peruttu.");
            });

        };

        $scope.deleteTask = function() {
            var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa toimenpiteen ja kaikki sen alakohdat?");

            if (deleteConfirmation) {
                Task.delete({taskId : $scope.taskForShow.id}, function() {
                    $window.alert("Toimenpiteen poistaminen onnistui!");
                    $scope.removeCurrentTask();
                });
            } else {
                $window.alert("Toimenpidettä '" + $scope.taskForShow.name + "' ei poistettu");
            }
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
            $scope.multichoice = multichoice;
        };

        $scope.editInterview= function(interview) {
            $scope.interview = interview;
        };

        $scope.returnToTask = function() {
            $scope.multichoice = null;
            $scope.interview = null;
        };


    }
]);