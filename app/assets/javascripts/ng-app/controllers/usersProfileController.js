angular.module('oscar')
	.controller('usersProfileController',
		function($scope, $location, $routeParams, userFactory){
			var userId = $routeParams.userId
			$scope.doneLoading = false
			userFactory.getUser(userId, function(data){
				if(data.loggedIn === 'false'){
					$location.path('/login')
				}
				if(data.loggedIn === true){
					$scope.user = data;
					$scope.loggedIn = true;
					$scope.doneLoading = true
				}
			})
			userFactory.getUserProfile(userId, function(data){
				console.log(data)
				$scope.userProfile = data.data;
				$scope.doneLoadingProfile = true
			})
		})