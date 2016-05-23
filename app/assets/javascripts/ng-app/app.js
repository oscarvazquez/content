var oscar = angular.module('oscar', [
	'ngRoute', 
	'templates', 
	'ngFileUpload',
  'ui.bootstrap',
  'ngAnimate',
  'ngAria',
  'ngMaterial',
  'ng-sweet-alert'
]);

(function(){
        oscar.config(function ($routeProvider, $locationProvider) {
        $routeProvider
            .when('/', {
              templateUrl: 'home.html'
            })
            .when('/register', {
                controller: 'usersController',
                templateUrl: 'users/new.html'
            })
            .when('/login', {
                controller: 'sessionsController',
                templateUrl: 'sessions/new.html'
            })
           	.when('/users/email_verification/:token', {
           		controller: 'emailsController',
           		templateUrl: 'users/email.html'
           	})
            .when('/users/dashboard/:userId', {
              controller: 'usersDashboardController',
              templateUrl: 'users/show.html'
            })
            .when('/users/:userId/profile', {
              controller: 'usersProfileController',
              templateUrl: 'users/profile.html'
            })
            .when('/users/review/:userId', {
              controller: 'reviewsController',
              templateUrl: 'reviews/show.html'
            })
            .when('/businesses', {
              controller: 'businessesController',
              templateUrl: 'businesses/index.html'
            });

        $locationProvider.html5Mode(true);
    })
}());