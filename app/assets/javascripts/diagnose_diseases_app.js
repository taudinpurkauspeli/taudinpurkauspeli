(function() {
    var app = angular.module('diagnoseDiseases', ['templates', 'ngResource', 'ngMessages', 'validation.match', 'dndLists',
        'ui.router', 'textAngular', 'ngAnimate', 'ui.bootstrap', 'angularFileUpload']
    );
})();

var app = angular.module('diagnoseDiseases');


// Fix for TextAngular still using angular.lowercase function while it is deprecated in AngularJS 1.7
app.config(function() {
    angular.lowercase = angular.$$lowercase;
});

app.config([
    '$stateProvider', '$urlRouterProvider',
    function ($stateProvider, $urlRouterProvider) {

        $urlRouterProvider.otherwise('/');

        $stateProvider.state('app_root',
            {
                url: '/',
                controller: 'ExercisesController',
                templateUrl: 'exercises/index.html'
            }
        )
            .state('documents', {
                url: '/documents',
                controller: 'DocumentsController',
                templateUrl: 'documents/index.html',
                resolve: {
                    auth: ['$q', 'AuthenticationService', function($q, AuthenticationService) {
                        var userAdmin = AuthenticationService.isAdmin();

                        if (!userAdmin) {
                            return $q.reject({ authenticated: false });
                        }
                    }]
                }
            })
            .state('users', {
                url: '/users',
                abstract: true,
                controller: 'UsersController',
                templateUrl: 'users/index.html',
                resolve: {
                    auth: ['$q', 'AuthenticationService', function($q, AuthenticationService) {
                        var userAdmin = AuthenticationService.isAdmin();

                        if (!userAdmin) {
                            return $q.reject({ authenticated: false });
                        }
                    }]
                }
            }).state('users.students', {
            url: '/students',
            controller: 'UsersStudentsController',
            templateUrl: 'users/students.html'
        }).state('users.by_case', {
            url: '/by_case',
            controller: 'UsersByCaseController',
            templateUrl: 'users/by_case.html'
        }).state('users.teachers', {
            url: '/teachers',
            controller: 'UsersTeachersController',
            templateUrl: 'users/teachers.html'
        }).state('users.testers', {
            url: '/testers',
            controller: 'UsersTestersController',
            templateUrl: 'users/testers.html'
        })

            .state('users_show', {
                url: '/users/:userShowId',
                controller: 'UsersShowController',
                templateUrl: 'users/show.html',
                resolve: {
                    auth: ['$q', 'AuthenticationService', function($q, AuthenticationService) {
                        var userIsLoggedIn = AuthenticationService.isLoggedIn();

                        if (!userIsLoggedIn) {
                            return $q.reject({ authenticated: false });
                        }
                    }]
                }
            })

            .state('signup',{
                url: '/signup',
                controller: 'UsersNewController',
                templateUrl: 'users/new.html'
            })

            .state('exercises_show',{
                url: '/exercises/:exerciseShowId',
                abstract: true,
                controller: 'ExercisesShowController',
                templateUrl: 'exercises/show.html',
                resolve: {
                    auth: ['$q', 'AuthenticationService', function($q, AuthenticationService) {
                        var userIsLoggedIn = AuthenticationService.isLoggedIn();

                        if (!userIsLoggedIn) {
                            return $q.reject({ authenticated: false });
                        }
                    }]
                }
            }).state('exercises_show.anamnesis', {
            url: '/anamnesis',
            templateUrl: 'exercises/anamnesis.html',
            controller: 'ExercisesAnamnesisController'
        }).state('exercises_show.tasks', {
            url: '/tasks',
            templateUrl: 'exercises/tasks_list.html',
            controller: 'TasksController'
        }).state('exercises_show.hypotheses', {
            url: '/hypotheses',
            templateUrl: 'exercises/exercise_hypotheses_list.html',
            controller: 'ExerciseHypothesesController'
        }).state('exercises_show.current_task', {
            url: '/task/:taskShowId',
            abstract:true,
            controller: 'TasksCurrentTaskController',
            template: '<ui-view/>'
        })

            .state('exercises_show.current_task.show', {
                url: '/show',
                templateUrl: 'tasks/show.html',
                controller: 'TasksShowController'
            }).state('exercises_show.current_task.interview', {
            url: '/interview/:interviewShowId',
            templateUrl: 'interviews/show.html',
            controller: 'InterviewsShowController',
            resolve: {
                auth: ['$q', 'AuthenticationService', function($q, AuthenticationService) {
                    var userAdmin = AuthenticationService.isAdmin();

                    if (!userAdmin) {
                        return $q.reject({ authenticated: false });
                    }
                }]
            }
        }).state('exercises_show.current_task.multichoice', {
            url: '/multichoice/:multichoiceShowId',
            templateUrl: 'multichoices/show.html',
            controller: 'MultichoicesShowController',
            resolve: {
                auth: ['$q', 'AuthenticationService', function($q, AuthenticationService) {
                    var userAdmin = AuthenticationService.isAdmin();

                    if (!userAdmin) {
                        return $q.reject({ authenticated: false });
                    }
                }]
            }
        })

            .state('exercises_new', {
                url: '/exercises_new',
                controller: 'ExercisesNewController',
                templateUrl: 'exercises/new.html',
                resolve: {
                    auth: ['$q', 'AuthenticationService', function($q, AuthenticationService) {
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
    '$rootScope', '$state',
    function($rootScope, $state){
        $rootScope.$on('$stateChangeError', function(event, toState, toParams, fromState, fromParams, error) {
            if (error.authenticated === false) {
                $.notify({
                    title: 'Pääsy estetty!',
                    message: 'Sinulla ei ole tarvittavia oikeuksia päästäksesi sivulle.'
                }, {
                    placement: {
                        align: 'center'
                    },
                    type: 'danger',
                    offset: 100
                });

                $state.go('app_root');
            }
        });

    }
]);

app.config([
    '$provide',
    function($provide){
        $provide.decorator('taOptions', ['taCustomRenderers','$delegate', function(taCustomRenderers, taOptions){
            taCustomRenderers.push({
                selector: 'a',
                renderLogic: function(element){
                    element.attr('target', '_blank');
                }
            });
            return taOptions;
        }]);
    }
]);

app.config([
    '$provide',
    function($provide){
        $provide.decorator('taTools', ['$delegate', function(taTools){
            taTools.insertImage.iconclass = 'far fa-image';
            taTools.insertVideo.iconclass = 'fab fa-youtube';
            taTools.undo.iconclass = 'fas fa-undo';
            taTools.redo.iconclass = 'fas fa-redo';
            taTools.iconclass = 'far fa-image';
            return taTools;
        }]);
    }
]);
