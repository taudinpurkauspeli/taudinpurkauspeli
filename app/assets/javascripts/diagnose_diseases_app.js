(function() {
    var app = angular.module('diagnoseDiseases',[ 'ngRoute','templates', 'ngResource', 'ngMessages', 'validation.match' ]);
})();

var app = angular.module('diagnoseDiseases');

app.config([
    "$routeProvider",
    function($routeProvider) {
        $routeProvider.when("/", {
            controller: "ExercisesController",
            templateUrl: "exercises/index.html"
        }).when("/hypothesis_groups", {
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
        }).when("/hypothesis_groups/:id",{
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
        }).when("/signup",{
            controller: "UsersNewController",
            templateUrl: "users/new.html"
        }).when("/exercises/:id",{
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
        });
    }
]);

app.run([
    "$rootScope", "$location",
    function($rootScope, $location){
        $rootScope.$on("$routeChangeError", function(event, current, previous, eventObj) {
            if (eventObj.authenticated === false) {
                alert("Sinulla ei ole tarvittavia oikeuksia päästäksesi sivulle");
                $location.path("/");
            }
        });

    }
]);
