var app = angular.module('diagnoseDiseases');

app.service('Session', [
    "LocalStorageService",
    function (LocalStorageService) {
        this.create = function(user) {
            LocalStorageService.set("current_user_id", user.id);
            LocalStorageService.set("current_user_admin", user.admin);
            LocalStorageService.set("current_user_tester", user.tester);
            LocalStorageService.set("current_user_accept_licence_agreement", user.accept_licence_agreement);
            LocalStorageService.set("current_user_accept_academic_research", user.accept_academic_research);
        };

        this.userId = function() {
            return LocalStorageService.get("current_user_id", null);
        };

        this.userAdmin = function() {
            return LocalStorageService.get("current_user_admin", null);
        };

        this.userTester = function() {
            return LocalStorageService.get("current_user_tester", null);
        };

        this.userAcceptLicenceAgreement = function() {
            return LocalStorageService.get("current_user_accept_licence_agreement", null);
        };

        this.userAcceptAcademicResearch = function() {
            return LocalStorageService.get("current_user_accept_academic_research", null);
        };

        this.destroy = function() {
            LocalStorageService.remove("current_user_id");
            LocalStorageService.remove("current_user_admin");
            LocalStorageService.remove("current_user_tester");
            LocalStorageService.remove("current_user_accept_licence_agreement");
            LocalStorageService.remove("current_user_accept_academic_research");
            LocalStorageService.remove("current_task");
            LocalStorageService.remove("current_task_tab_path");
        };
    }
]);
