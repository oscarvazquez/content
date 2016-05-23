angular.module('oscar')
	.controller('businessesController', function($scope, $routeParams, $location, userFactory, reviewFactory, businessFactory){
		userId = $routeParams.userId
		userFactory.getUser(userId, function(data){
			if(data.loggedIn === 'false'){
				$location.path('/login')
				console.log('not logged in');
			}
			if(data.loggedIn === true){
				$scope.user = data;
				$scope.loggedIn = true;
			}
		})
		businessFactory.getAll(function(data){
			console.log(data);
		})
	})