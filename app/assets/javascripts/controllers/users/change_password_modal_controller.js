var app = angular.module('diagnoseDiseases');

app.controller("ChangePasswordModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', 'user',
    function($scope, $uibModalInstance, $resource, $window, user) {

        $scope.user = user;

        var User = $resource('/users/:userId.json',
            { userId: "@id"},
            { update: { method: 'PUT' }});

        $scope.changePassword = function() {
            if ($scope.changePasswordForm.$valid) {
                User.update({userId: $scope.user.id}, $scope.user, function() {
                    $.notify({
                        message: "Salasanan vaihto onnistui!"
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
                        message: "Salasanan vaihto epäonnistui!"
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