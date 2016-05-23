angular.module('oscar')
	.controller('usersDashboardController', 
		function($scope, $location, $routeParams, $timeout, userFactory){
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

					// $timeout(function(){
					// 	$scope.doneLoading = true
					// }, 3000)
				}
			})
			userFactory.getUserProfile(userId, function(data){
				$scope.userProfile = data.data;
				$scope.doneLoadingProfile = true
			})			
			$scope.getUser = function(){
				userFactory.getUser(userId, function(data){
					if(!data.loggedIn){
						$location.path('/login')
					}
					if(data.loggedIn == true){
						console.log(data);
						$scope.user = data;
					}
				})
			}			
})