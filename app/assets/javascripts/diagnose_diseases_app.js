(function() {
    var app = angular.module('diagnoseDiseases',[ 'templates',
        'ngResource', 'ngMessages', 'validation.match', 'dndLists', 'ui.router', 'textAngular', 'ngAnimate', 'ui.bootstrap']);
})();

var app = angular.module('diagnoseDiseases');

app.config([
    "$stateProvider", "$urlRouterProvider",
    function($stateProvider, $urlRouterProvider) {

        $urlRouterProvider.otherwise("/");

        $stateProvider.state("app_root", {
            url: "/",
            controller: "ExercisesController",
            templateUrl: "exercises/index.html"
        }).state("users", {
            url: "/users",
            controller: "UsersController",
            templateUrl: "users/index.html",
            resolve: {
                auth: ["$q", "AuthenticationService", function($q, AuthenticationService) {
                    var userAdmin = AuthenticationService.isAdmin();

                    if (!userAdmin) {
                        return $q.reject({ authenticated: false });
                    }
                }]
            }
        }).state("signup",{
            url: "/signup",
            controller: "UsersNewController",
            templateUrl: "users/new.html"
        }).state("exercises_show",{
            url: "/exercises/:id",
            abstract: true,
            controller: "ExercisesShowController",
            templateUrl: "exercises/show.html",
            resolve: {
                auth: ["$q", "AuthenticationService", function($q, AuthenticationService) {
                    var userAdmin = AuthenticationService.isAdmin();

                    if (!userAdmin) {
                        return $q.reject({ authenticated: false });
                    }
                }]
            }
        }).state("exercises_show.anamnesis", {
            url: "/anamnesis",
            templateUrl: "exercises/anamnesis_teacher.html",
            controller: "ExercisesAnamnesisController"

        }).state("exercises_show.tasks", {
            url: "/tasks",
            templateUrl: "exercises/tasks_list_teacher.html",
            controller: "TasksController"
        }).state("exercises_show.hypotheses", {
            url: "/hypotheses",
            templateUrl: "exercises/exercise_hypotheses_list_teacher.html",
            controller: "ExerciseHypothesesController"
        }).state("exercises_new", {
            url: "/exercises_new",
            controller: "ExercisesNewController",
            templateUrl: "exercises/new.html",
            resolve: {
                auth: ["$q", "AuthenticationService", function($q, AuthenticationService) {
                    var userAdmin = AuthenticationService.isAdmin();

                    if (!userAdmin) {
                        return $q.reject({ authenticated: false });
                    }
                }]
            }
        });
    }
]);

app.run([
    "$rootScope", "$location",
    function($rootScope, $location){
        $rootScope.$on("$stateChangeError", function(event, toState, toParams, fromState, fromParams, error) {
            if (error.authenticated === false) {
                alert("Sinulla ei ole tarvittavia oikeuksia päästäksesi sivulle");
                $location.path("/");
            }
        });

    }
]);
