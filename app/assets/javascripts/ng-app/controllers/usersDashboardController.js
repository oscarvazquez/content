angular.module('oscar')
	.controller('usersDashboardController', 
		function($scope, $location, $routeParams, userFactory){
			var userId = $routeParams.userId
			userFactory.getUser(userId, function(data){
				if(data.loggedIn === 'false'){
					$location.path('/login')
				}
				if(data.loggedIn === true){
					$scope.user = data;
					$scope.loggedIn = true;
				}
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