angular.module('oscar')
	.controller('reviewsController', function($scope, $routeParams, $location, userFactory, reviewFactory){
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
		reviewFactory.getReviews(userId, function(data){
			$scope.userId = data.id
			$scope.rating = data.rating
			$scope.count_5 = data.rating_5
			$scope.count_4 = data.rating_4
			$scope.count_3 = data.rating_3
			$scope.count_2 = data.rating_2
			$scope.count_1 = data.rating_1
			$scope.reviewCount = data.review_count
			$scope.reviews = data.reviews
		});
		$scope.predicate = 'like_count';
		$scope.reverse = true;
		$scope.order = function(predicate) {
			$scope.reverse = ($scope.predicate === predicate) ? !$scope.reverse : false;
			$scope.predicate = predicate;
		};
	})