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

task_texts = [
  {
    id: 1
    content: 'Sisältöä id 1'
  },
  {
    id: 2
    content: 'Juttuja id 2',
  },
  {
    id: 3
    content: 'Muuta id 3',
  },
  {
    id: 4
    content: 'Testiä id 4',
  },
]

controllers = angular.module('controllers',[]);

controllers.controller("TaskTextsController", [ '$scope',
  ($scope)->
    $scope.task_texts = task_texts;
]);
