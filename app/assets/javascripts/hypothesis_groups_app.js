var app = angular.module('hypothesisGroups',[ ]);

var HypothesisGroupSearchController = function($scope) {
    $scope.hypothesisGroupsList = [];
    $scope.search = function(searchTerm) {
        $scope.hypothesisGroupsList = [
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