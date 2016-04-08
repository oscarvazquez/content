angular.module('oscar')
	.controller('reviewsController', function($scope, $routeParams, $location, reviewFactory){
		userId = $routeParams.userId
		reviewFactory.getReviews(userId, function(data){
			console.log(data)
		});
	})