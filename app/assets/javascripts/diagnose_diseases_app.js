(function() {
    var app = angular.module('diagnoseDiseases',[ 'ngRoute','templates',
        'ngResource', 'ngMessages', 'validation.match', 'dndLists', 'ui.router', 'textAngular']);
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
        }).state("hypothesis_groups", {
            url: "/hypothesis_groups",
            controller: "HypothesisGroupsController",
            templateUrl: "hypothesis_groups/index.html",
            resolve: {
                auth: ["$q", "AuthenticationService", function($q, AuthenticationService) {
                    var userAdmin = AuthenticationService.isAdmin();

                    if (!userAdmin) {
                        return $q.reject({ authenticated: false });
                    }
                }]
            }
        }).state("hypothesis_groups_show",{
            url: "/hypothesis_groups/:id",
            controller: "HypothesisGroupsShowController",
            templateUrl: "hypothesis_groups/show.html",
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
            views: {
                "@": {
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
                },
                "exercise_hypothesis_list@exercises_show": {
                    templateUrl: "exercises/exercise_hypotheses_list_teacher.html",
                    controller: "ExerciseHypothesesController"
                },
                "task_list@exercises_show": {
                    templateUrl: "exercises/tasks_list_teacher.html",
                    controller: "TasksController"
                },
                "anamnesis@exercises_show": {
                    templateUrl: "exercises/anamnesis_teacher.html",
                    controller: "ExercisesShowController"
                }
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
