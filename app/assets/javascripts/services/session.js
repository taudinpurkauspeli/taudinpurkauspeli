var app = angular.module('diagnoseDiseases');

app.service('Session', [
    "LocalStorageService",
    function (LocalStorageService) {
        this.create = function(user) {
            LocalStorageService.set("current_user_id", user.id);
            LocalStorageService.set("current_user_admin", user.admin);
            LocalStorageService.set("current_user_tester", user.tester);
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

        this.destroy = function() {
            LocalStorageService.remove("current_user_id");
            LocalStorageService.remove("current_user_admin");
            LocalStorageService.remove("current_user_tester");
            LocalStorageService.remove("current_task");
            LocalStorageService.remove("current_task_tab_path");
        };
    }
]);
