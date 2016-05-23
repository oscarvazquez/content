angular.module('oscar')
	.directive('likes', ['$window', '$http', function($window, $http){
			controller = ['$scope', '$location', function($scope){
					$scope.showLikes = function(likeable){
						console.log(likeable);
					}
					$scope.likeLikeable = function(likeable){
						$scope.newLike = {}
						$scope.newLike.likeable_id = $scope.likeableid
						$scope.newLike.likeable_type = $scope.likeabletype
						$http.post('/likes.json', {like: $scope.newLike}).then(function(like){
							likeable.like_count += 1
							likeable.liked = true
							likeable.users_like = like.data.like
						})
					}
					$scope.unlikeLikeable = function(likeable){
						$http.delete('/likes/' + likeable.users_like.id + '.json', {like: $scope.oldLike}).then(function(like){
							likeable.like_count -= 1
							likeable.liked = false
							likeable.users_like = ''
						})
					}					
				}]
			return {
				restrict: 'E',
				templateUrl: 'components/likes.html',
				scope: {
					likeable: '=',
					likeableid: '@',
					likeabletype: '@',
					buttonstyle: '@'
				},
				controller: controller
			}
	}])