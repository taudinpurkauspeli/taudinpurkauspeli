var app = angular.module('diagnoseDiseases');

var HypothesisGroupsController = function($scope, $http, $location, $resource, $window) {
    $scope.hypothesisGroupsList = [];

    //$scope.search = function(searchTerm) {
    //
    //    if(searchTerm.length < 2){
    //        return;
    //    };
    //
    //    $http.get("/hypothesis_groups.json",
    //        { "params": { "hypothesisGroupName": searchTerm } }
    //    ).success(
    //        function(data,status,headers,config) {
    //            $scope.hypothesisGroupsList = data;
    //        }).error(
    //        function(data,status,headers,config) {
    //            alert("Jotakin odottamatonta kävi: " + status);
    //        });
    //};

    var HypothesisGroups = $resource('/hypothesis_groups.json');

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

};

app.controller("HypothesisGroupsController",
    [ '$scope', '$http', '$location', '$resource', '$window', HypothesisGroupsController ]
);