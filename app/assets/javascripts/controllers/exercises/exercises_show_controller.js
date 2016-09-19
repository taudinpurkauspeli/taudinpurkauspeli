var app = angular.module('diagnoseDiseases');

app.controller("ExercisesShowController", [
    "$scope", "$stateParams", "$resource", "LocalStorageService", "$state",
    function($scope, $stateParams, $resource, LocalStorageService, $state) {
        $scope.exercise = {};
        $scope.taskForShow = {};

        $scope.links = [
            {tabName: "AnamnesisTab",
                tabState: "exercises_show.anamnesis",
                title: "Anamneesi"},
            {tabName: "TaskTab",
                tabState: "exercises_show.tasks",
                title: "Toimenpidelista"},
            {tabName: "HypothesisTab",
                tabState: "exercises_show.hypotheses",
                title: "Diffilista"}
        ];

        var exerciseId = $stateParams.exerciseShowId;
        var ExerciseOne = $resource('/exercises_one/:exerciseId.json',
            { exerciseId: "@id"});
        var TaskOne = $resource('/tasks_one/:taskId.json',
            { taskId: "@id"});

        var CompletableSubtasks = $resource('/users/:id/completable_subtasks.json',
            {id: '@id'});

        var UserHasCompletedTask = $resource('/users/:id/has_completed_task.json',
            {id: '@id'});

        var UserHasCompletedExercise = $resource('/users/:id/has_completed_exercise.json',
            {id: '@id'});

        var CompletedTasks = $resource('/users/:id/completed_tasks.json',
            {id: '@id'});

        $scope.setExercise = function() {
            ExerciseOne.get({exerciseId : exerciseId}, function(data) {
                $scope.exercise = data.exercise;
                $scope.hasConclusion = data.has_conclusion;
            });
        };

        $scope.setTaskShowValuesForStudent = function() {
            $scope.setSubtasksAndCompletedTaskValue();
        };

        $scope.setSubtasksAndCompletedTaskValue = function() {

            UserHasCompletedTask.get({id: $scope.currentUser, task_id: $scope.taskForShow.id},
                function() {
                    $scope.userHasCompletedTask = true;
                    $scope.setCompletableSubtasks();
                }, function() {
                    $scope.userHasCompletedTask = false;
                    $scope.setCompletableSubtasks();
                }
            );
        };

        $scope.setCompletedExerciseValue = function() {

            UserHasCompletedExercise.get({id: $scope.currentUser, exercise_id: $stateParams.exerciseShowId},
                function() {
                    $scope.userHasCompletedExercise = true;
                }, function() {
                    $scope.userHasCompletedExercise = false;
                }
            );
        };

        $scope.setCompletedTasksForUser = function() {

            CompletedTasks.query({id: $scope.currentUser, exercise_id: $stateParams.exerciseShowId},
                function(data) {
                    $scope.completedTasksForUser = data;
                }
            );
        };

        $scope.userHasCompletedTasks = function(tasksList) {
            return tasksList && (tasksList.length > 0);
        };

        $scope.setCompletableSubtasks = function() {

            CompletableSubtasks.query({id: $scope.currentUser, task_id: $scope.taskForShow.id},
                function(data) {
                    if(!$scope.userHasCompletedTask){
                        $scope.uncompletedSubtask = data.pop();
                        $scope.completedSubtasks = data;
                    } else {
                        $scope.completedSubtasks = data;
                    }
                }, function() {
                    $scope.completedSubtasks = [];
                }
            );
        };

        $scope.setTaskForShow = function(current_task){
            if(current_task){
                TaskOne.get({taskId : current_task}, function(data) {
                    $scope.taskForShow = data;

                    if($scope.currentUser && !$scope.currentUserAdmin) {
                        $scope.setTaskShowValuesForStudent();
                    }
                });
            } else {
                $scope.taskForShow = {};
            }
        };

        $scope.setCurrentTask = function() {
            $scope.current_task = LocalStorageService.get("current_task", null);
            $scope.setTaskForShow($scope.current_task);
            $scope.setCompletedExerciseValue();
            $scope.setCompletedTasksForUser();
        };

        $scope.setTaskTabPath = function() {
            $scope.current_task_show_path = LocalStorageService.getObject("current_task_tab_path", '{"state": "", "parameters": "{}"}');
        };

        $scope.setExercise();
        $scope.setCurrentTask();
        $scope.setTaskTabPath();

        $scope.goToState = function(newState) {
            $state.go(newState.state, newState.parameters);
        };

        $scope.goToCurrentTask = function(newTask) {
            $state.go("exercises_show.current_task.show", {taskShowId: newTask});
        };

        $scope.removeCurrentTask = function() {
            LocalStorageService.remove("current_task");
            LocalStorageService.remove("current_task_tab_path");
            LocalStorageService.remove("unchecked_hypotheses");
            $scope.setCurrentTask();
        };

    }
]);