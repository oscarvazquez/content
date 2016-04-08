angular.module('oscar')
	.controller('sessionsController', function($scope, $location, sessionFactory){
		$scope.message = false;
		$scope.createSession = function(){
			sessionFactory.loginUser($scope.newSession, function(data){
				if(data.status == 'success'){
					console.log(data)
					$location.path('/users/dashboard/' + data.user.id)
				} else if (data.status == 'error'){
					console.log('Login credentials are wrong bro')
				}
				$scope.message = data.message
				$scope.newSession.password = null
			})
		}
	})