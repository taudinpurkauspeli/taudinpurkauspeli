(function() {
    var app = angular.module('diagnoseDiseases',[ 'ngRoute','templates', 'ngResource', 'ngMessages' ]);
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
            templateUrl: "hypothesis_groups/index.html"
        }).when("/hypothesis_groups/:id",{
            controller: "HypothesisGroupsShowController",
            templateUrl: "hypothesis_groups/show.html"
        });
    }
]);
