var app = angular.module('diagnoseDiseases');

app.constant("AUTH_EVENTS", {
    loginSuccess: 'auth-login-success',
    loginFailed: 'auth-login-failed',
    logoutSuccess: 'auth-logout-success',
    notAuthenticated: 'auth-not-authenticated',
    notAuthorized: 'auth-not-authorized'
});


app.constant('USER_ROLES', {
    is_admin: 'is_admin',
    is_normal: 'is_normal'
});