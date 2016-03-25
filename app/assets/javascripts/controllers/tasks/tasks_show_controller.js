var app = angular.module('diagnoseDiseases');

app.controller("TasksShowController", [
    "$scope", "$resource", "$window", "$uibModal",
    function($scope, $resource, $window, $uibModal) {

        $scope.taskText = null;
        $scope.multichoice = null;
        $scope.interview = null;

        var Task = $resource('/tasks/:taskId.json',
            { taskId: "@id"},
            { update: { method: 'PUT' }});

        var TaskText = $resource('/task_texts/:taskTextId.json',
            { taskTextId: "@id"},
            { update: { method: 'PUT' }});

        $scope.updateTask = function(updateTaskForm){
            if (updateTaskForm.$valid) {
                Task.update({taskId: $scope.taskForShow.id}, $scope.taskForShow, function() {
                    $window.alert("Toimenpiteen päivitys onnistui!");
                    updateTaskForm.$setPristine();
                    updateTaskForm.$setUntouched();
                }, function() {
                    $window.alert("Toimenpiteen päivitys epäonnistui!");
                });
            }
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
                $scope.setCurrentTask();
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

        $scope.editTaskText = function(task_text) {
            $scope.taskText = task_text;
        };

        $scope.editMultichoice= function(multichoice) {
            $scope.multichoice = multichoice;
        };

        $scope.editInterview= function(interview) {
            $scope.interview = interview;
        };

        $scope.returnToTask = function() {
            $scope.taskText = null;
            $scope.multichoice = null;
            $scope.interview = null;
        };


    }
]);