var app = angular.module('diagnoseDiseases');

app.controller("UsersShowController", [
    "$scope", "$resource", "$stateParams", "$window", "$state", "$uibModal",
    function($scope, $resource, $stateParams, $window, $state, $uibModal) {
        $scope.user = {};
        $scope.userExercises = [];
        $scope.userHasStartedExercises = false;
        $scope.savedExercises = [];
        $scope.userHasSavedExercises = false;

        var User = $resource('/users/:userId.json',
            { userId: "@id"},
            { update: { method: 'PUT' }});

        var UserSavedExercises = $resource('/users/:userId/saved_exercises.json',
            { userId: "@id"});

        var UserDestroy = $resource('/delete_user_json/:userId.json',
            { userId: "@id"});

        $scope.setAdminStatus = function(user){
            if(user.admin){
                $scope.adminStatus = "opiskelija";
            } else {
                $scope.adminStatus = "opettaja";
            }
        };

        $scope.setTesterStatus = function(user){
            if(user.tester){
                $scope.testerStatus = "tavallinen opiskelija";
            } else {
                $scope.testerStatus = "testaaja";
            }
        };

        $scope.setSavedExercises = function() {
            UserSavedExercises.query({userId : $stateParams.userShowId}, function(data) {
                console.log(data);
                $scope.savedExercises = data;
                $scope.userHasSavedExercises = (data && data.length > 0);
            }, function(data){
            });

        };

        $scope.setUser = function() {
            User.get({userId : $stateParams.userShowId}, function(data) {
                $scope.user = data.user;
                $scope.userExercises = data.exercises;
                $scope.userHasStartedExercises = (data.exercises && data.exercises.length > 0);
                $scope.setAdminStatus(data.user);
                $scope.setTesterStatus(data.user);
            }, function(data){
                if(data.status === 401){
                    $.notify({
                        message: "Pääsy toisen käyttäjän tietoihin estetty!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "danger",
                        offset: 100
                    });
                    $state.go('app_root');
                }
            });
        };

        $scope.setUserInformation = function() {
            $scope.setUser();
            $scope.setSavedExercises();
        };

        $scope.setUserInformation();

        $scope.getType = function(percentOfCompletedTasks) {
            if(percentOfCompletedTasks >= 100) {
                return 'success';
            } else if (percentOfCompletedTasks < 25) {
                return 'danger';
            } else {
                return 'warning';
            }
        };

        $scope.removeUser = function(user) {

            var deleteConfirmation = $window.confirm("Oletko aivan varma, että haluat poistaa käyttäjän?");

            if (deleteConfirmation) {
                UserDestroy.delete({userId : user.id}, function() {
                    $.notify({
                        message: "Käyttäjän poistaminen onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                    $state.go('users.by_case');
                });
            } else {
                $.notify({
                    message: "Käyttäjää '" + user.first_name + "' ei poistettu."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            }
        };

        $scope.editUser = function(user) {
            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'users/update_user_modal.html',
                controller: 'UpdateUserModalController',
                size: 'lg',
                resolve: {
                    user: user
                }
            });

            modalInstance.result.then(function(data) {
            }, function() {
            });

        };

        $scope.changePassword = function(user) {
            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'users/change_password_modal.html',
                controller: 'ChangePasswordModalController',
                size: 'lg',
                resolve: {
                    user: user
                }
            });

            modalInstance.result.then(function(data) {
            }, function() {
            });

        };

        $scope.changeAdminStatus = function(user){
            var adminStatusChangeConfirmation = $window.confirm("Oletko aivan varma, että haluat muuttaa käyttäjän tilin oikeuksia?");

            if (adminStatusChangeConfirmation) {

                var newAdminStatus = !user.admin;
                user.admin = newAdminStatus;

                User.update({userId : user.id}, user, function() {
                    $.notify({
                        message: "Käyttäjän oikeuksien muuttaminen onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                    $scope.setUserInformation();
                }, function() {
                    $.notify({
                        message: "Käyttäjän oikeuksia ei voitu muuttaa!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "danger",
                        offset: 100
                    });
                });
            } else {
                $.notify({
                    message: "Käyttäjän '" + user.first_name + "' oikeuksia ei muutettu."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            }
        };

        $scope.changeTesterStatus = function(user){
            var testerStatusChangeConfirmation = $window.confirm("Oletko aivan varma, että haluat muuttaa käyttäjän testaajastatusta?");

            if (testerStatusChangeConfirmation) {

                var newTesterStatus = !user.tester;
                user.tester = newTesterStatus;

                User.update({userId : user.id}, user, function() {
                    $.notify({
                        message: "Käyttäjän testaajastatuksen muuttaminen onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                    $scope.setUserInformation();
                }, function() {
                    $.notify({
                        message: "Käyttäjän testaajastatusta ei voitu muuttaa!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "danger",
                        offset: 100
                    });
                });
            } else {
                $.notify({
                    message: "Käyttäjän '" + user.first_name + "' testaajastatusta ei muutettu."
                }, {
                    placement: {
                        align: "center"
                    },
                    type: "warning",
                    offset: 100
                });
            }
        };

    }
]);