var app = angular.module('taudinpurkauspeli',[ ]);

var HypothesisGroupSearchController = function($scope) {
    $scope.hypothesisGroups = [];
    $scope.search = function(searchTerm) {
        $scope.hypothesisGroups = [
            {
                "name":"Bakteeritaudit"

            },
            {
                "name":"Virustaudit"
            },
            {
                "name":"Nuhataudit"
            }
        ]
    }
};

app.controller("HypothesisGroupSearchController",
    [ "$scope", HypothesisGroupSearchController ]
);