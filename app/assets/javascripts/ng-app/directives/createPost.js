angular.module('oscar')
	.directive('createPost', ['$window', '$http', function($window, $http){
			controller = ['$scope', '$location', 'Upload', function($scope, $location, Upload){
					$scope.addPost = function(file){

						Upload.upload({
							url: '/posts.json',
							data: {file: $scope.file, post: $scope.newPost}
						}).then(function(resp){
							$scope.newPost.post = ''
							$scope.file = ''
							$scope.posts.unshift(resp.data)
						}, function(resp){
							console.log('error');
						}, function(evt){
							console.log('progress');
						})

					}
				}]
			return {
				restrict: 'E',
				templateUrl: 'components/createPost.html',
				scope: {
					posts: '='
				},
				controller: controller
			}
	}])