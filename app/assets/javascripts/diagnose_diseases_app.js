(function() {
    var app = angular.module('diagnoseDiseases',[ 'ngRoute','templates', 'ngResource', 'ngMessages' ]);
})();

var app = angular.module('diagnoseDiseases');

app.config([
    "$routeProvider",
    function($routeProvider) {
        $routeProvider.when("/", {
            controller: "ExercisesController",
            templateUrl: "exercises/exercises_index.html"
        }).when("/hypothesis_groups", {
            controller: "HypothesisGroupSearchController",
            templateUrl: "hypothesis_groups/hypothesis_groups_search.html"
        }).when("/hypothesis_groups/:id",{
            controller: "HypothesisGroupShowController",
            templateUrl: "hypothesis_groups/hypothesis_group_show.html"
        });
    }
]);
