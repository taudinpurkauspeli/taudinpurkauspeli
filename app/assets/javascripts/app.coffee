taudinpurkauspeli = angular.module('taudinpurkauspeli',[  'templates',
                                                          'ngRoute',
                                                          'controllers'
]);

taudinpurkauspeli.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
    .when('/task_texts',
      templateUrl: "task_texts/index.html"
      controller: 'TaskTextsController'
    )
]);

controllers = angular.module('controllers',[]);

controllers.controller("TaskTextsController", [ '$scope',
  ($scope)->
])