angular.module('oscar')
	.directive('comments', ['$window', '$http', function($window, $http){
			controller = ['$scope', '$location', 'Upload', function($scope, $location, Upload, commentFactory){
					$scope.showUser = function(userId, userType){
						console.log(userId);
						console.log(userType)
						if(userType = "User"){
							$location.path('/users/' + userId + '/profile')
						}
					}
					$scope.addComment = function(file){
						$scope.newComment.commentable_type = $scope.commentabletype
						$scope.newComment.commentable_id = $scope.commentableid						

						Upload.upload({
							url: '/comments.json',
							data: {file: $scope.file, comment: $scope.newComment}
						}).then(function(resp){
							$scope.newComment.comment = ''
							$scope.commentable.comments.push(resp.data)
						}, function(resp){
							console.log('error');
						}, function(evt){
							console.log('progress');
						})

					}
					$scope.deleteComment = function(comment){
						$http.delete('/comments/' + comment.id + '.json').then(function(message){
							for(var i = 0; i < $scope.commentable.comments.length; i++){
								if ($scope.commentable.comments[i].id == comment.id){
									$scope.commentable.comments.splice(i, 1);
								}
							}
						})
					}
				}]
			return {
				restrict: 'E',
				templateUrl: 'components/comments.html',
				scope: {
					commentable: '=',
					commentableid: '@',
					commentabletype: '@'
				},
				controller: controller
			}
	}])