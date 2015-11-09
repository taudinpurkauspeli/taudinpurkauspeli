(function() {
    var app = angular.module('hypothesisGroups',[ 'ngRoute','templates', 'ngResource', 'ngMessages' ]);
})();

var app = angular.module('hypothesisGroups');

app.config([
    "$routeProvider",
    function($routeProvider) {
        $routeProvider.when("/", {
            controller: "HypothesisGroupSearchController",
            templateUrl: "hypothesis_groups/hypothesis_groups_search.html"
        }).when("/:id",{
            controller: "HypothesisGroupShowController",
            templateUrl: "hypothesis_groups/hypothesis_group_show.html"
        });
    }
]);
