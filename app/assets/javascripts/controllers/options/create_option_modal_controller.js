var app = angular.module('diagnoseDiseases');

app.controller("CreateOptionModalController", [
    '$scope', '$uibModalInstance', '$resource', '$window', "multichoice",
    function($scope, $uibModalInstance, $resource, $window, multichoice) {

        $scope.newOption = {
            multichoice_id: multichoice.id,
            content: "",
            explanation: "",
            is_correct_answer: "allowed"
        };

        $scope.answer_types = [
            {name_fi: "Pakollinen vaihtoehto", name_en: "required"},
            {name_fi: "Sallittu vaihtoehto", name_en: "allowed"},
            {name_fi: "Väärä vaihtoehto", name_en: "wrong"}
        ];

        var Option = $resource('/options_json_create.json');

        $scope.createOption = function() {
            if ($scope.createOptionForm.$valid) {
                Option.save($scope.newOption,
                    function() {
                        $window.alert("Vastausvaihtoehdon luominen onnistui!");
                        $uibModalInstance.close();
                    },
                    function() {
                        $window.alert("Vastausvaihtoehdon luominen epäonnistui!");
                    }
                );
            }
        };

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

    }
]);