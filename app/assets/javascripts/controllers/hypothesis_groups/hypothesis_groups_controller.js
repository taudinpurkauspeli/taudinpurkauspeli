var app = angular.module('diagnoseDiseases');

var HypothesisGroupsController = function($scope, $http, $location, $resource, $window) {
    $scope.hypothesisGroupsList = [];
    $scope.newHypothesisGroup = {};

    var HypothesisGroups = $resource('/hypothesis_groups.json');
    var HypothesisGroup = $resource('/hypothesis_groups/:hypothesisGroupId.json',
        {"hypothesisGroupId": "@id"},
        { "create": { "method": "POST" }});

    $scope.hypothesisGroupsList = HypothesisGroups.query();

    $scope.viewHypothesisGroup = function(hypothesisGroup) {
        $location.path("hypothesis_groups/" + hypothesisGroup.id);
    };

    $scope.deleteHypothesisGroup = function(hypothesisGroup) {
        var deleteConfirmation = $window.confirm('Oletko aivan varma, että haluat poistaa diffiryhmän ja kaikki siihen liittyvät diffit?');
        if (deleteConfirmation) {
            $window.alert("Diffiryhmä '" + hypothesisGroup.name + "' poistettu");
        }

    };

    $scope.createHypothesisGroup = function() {
        if ($scope.createHypothesisGroupForm.$valid) {
            HypothesisGroup.create($scope.newHypothesisGroup,
                function() {
                    $scope.createHypothesisGroupForm.$setPristine();
                    $scope.createHypothesisGroupForm.$setUntouched();
                    $scope.hypothesisGroupsList = HypothesisGroups.query();
                    $scope.newHypothesisGroup = {};
                    alert("Diffiryhmän luominen onnistui!");
                },
                function() {
                    alert("Diffiryhmän luominen epäonnistui!");
                }
            );
        }
    };

};

app.controller("HypothesisGroupsController",
    [ '$scope', '$http', '$location', '$resource', '$window', HypothesisGroupsController ]
);