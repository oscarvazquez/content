angular.module('oscar')
	.controller('usersController', function($scope, $location, $timeout, userFactory){
	$scope.message = false
	$scope.addUser = function(){
		userFactory.addUser($scope.newUser, function(data){
			if(data.status == 'success'){
				$scope.alertStyle = 'success'
				$scope.message = [data.message]
				$scope.email = data.email
				$scope.newUser = {};
				$timeout(function(){
					$location.path('/login')
				}, 10000)
			} else{
				$scope.alertStyle = 'error'
				$scope.message = data.message
				$scope.newUser.password = null;
				$scope.newUser.password_confirmation = null;
			}
		})
	}
})