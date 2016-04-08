// app.factory("AuthService", function($http, $q, $rootScope, AuthToken, AuthEvents) {
//   return {
//     login: function(username, password) {
//       var d = $q.defer();
//       $http.post('/api/auth', {
//         username: username,
//         password: password
//       }).success(function(resp) {
//         AuthToken.set(resp.auth_token);
//         $rootScope.$broadcast(AuthEvents.loginSuccess);
//         d.resolve(resp.user);
//       }).error(function(resp) {
//         $rootScope.$broadcast(AuthEvents.loginFailed);
//         d.reject(resp.error);
//       });
//       return d.promise;
//     }
//   };
// });