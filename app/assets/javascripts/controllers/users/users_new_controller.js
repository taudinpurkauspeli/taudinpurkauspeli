var app = angular.module('diagnoseDiseases');

app.controller('UsersNewController', [
    '$scope', '$state', '$resource', '$window', 'AuthenticationService',
    function($scope, $state, $resource, $window, AuthenticationService) {

        $scope.newUser = {};
        $scope.currentYear = new Date().getFullYear();

        var Users = $resource('/users.json');

        $scope.createUser = function() {
            if ($scope.createUserForm.$valid) {
                Users.save($scope.newUser,
                    function() {
                        var credentials = {
                            username: $scope.newUser.username,
                            password: $scope.newUser.password
                        };
                        AuthenticationService.login(credentials).$promise.then(function onSuccess() {
                            $scope.setCurrentUser(AuthenticationService.isLoggedIn(), AuthenticationService.isAdmin(), AuthenticationService.isTester());
                            $scope.newUser = {};
                            $state.go('app_root');
                            $.notify({
                                message: 'Tervetuloa käyttämään Taudinpurkauspeliä!'
                            }, {
                                placement: {
                                    align: 'center'
                                },
                                type: 'success',
                                delay: 0,
                                offset: 100
                            });
                        }).catch(function onError() {
                        });
                    },
                    function() {
                        $.notify({
                            message: 'Käyttäjätunnuksen luominen ei onnistunut!'
                        }, {
                            placement: {
                                align: 'center'
                            },
                            type: 'danger',
                            offset: 100
                        });
                    }
                );
            }
        };
    }
]);