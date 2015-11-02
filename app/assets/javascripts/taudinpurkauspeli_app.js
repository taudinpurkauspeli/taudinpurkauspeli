var app = angular.module('taudinpurkauspeli',[ ]);

var HypothesisGroupSearchController = function($scope) {
    $scope.search = function(searchTerm) {
        $scope.searchedHypothesisGroup = searchTerm;
    }
};

app.controller("HypothesisGroupSearchController",
    [ "$scope", HypothesisGroupSearchController ]
);