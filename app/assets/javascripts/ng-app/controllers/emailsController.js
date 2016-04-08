angular.module('oscar')
	.controller('emailsController', function($scope, $routeParams, $timeout, $location, userFactory){
		email_token = $routeParams.token
		userFactory.check_email_token(email_token, function(data){
			if (data.status == "success"){
				$scope.message = data.message;
				$timeout(function(){
					$location.path('/login')
				}, 4000)
			}
		});
	})