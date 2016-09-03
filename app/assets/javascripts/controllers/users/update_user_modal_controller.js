var app = angular.module('diagnoseDiseases');

app.controller("UpdateUserModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', 'user',
    function($scope, $uibModalInstance, $resource, $window, user) {

        $scope.user = user;
        $scope.currentYear = new Date().getFullYear();

        var User = $resource('/users/:userId.json',
            { userId: "@id"},
            { update: { method: 'PUT' }});

        $scope.updateUser = function() {
            if ($scope.updateUserForm.$valid) {
                User.update({userId: $scope.user.id}, $scope.user, function() {
                    $.notify({
                        message: "Käyttäjätietojen päivitys onnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "success",
                        offset: 100
                    });
                    $uibModalInstance.close();
                }, function() {
                    $.notify({
                        message: "Käyttäjätietojen päivitys epäonnistui!"
                    }, {
                        placement: {
                            align: "center"
                        },
                        type: "danger",
                        offset: 100
                    });
                });
            }
        };


        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);