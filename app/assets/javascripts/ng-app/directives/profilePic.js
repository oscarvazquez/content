angular.module('oscar')
	.directive('profilePic', ['$window', '$http', function($window, $http){
			controller = ['$scope', '$location', 'Upload', function($scope, $location, Upload){
					$scope.$watch('myUser', function(user){
						if(user != undefined){
							$scope.file = user.profile_pic
						}
					})
					$scope.showUser = function(userId){
						console.log(userId);
					}
					$scope.addPicture = function(file){
						var element = angular.element(document.getElementById('submitPic'))

						Upload.upload({
							url: '/users/profile_picture.json',
							data: {file: $scope.file}
						}).then(function(resp){
							element.html('saved!')
							console.log('done');
							console.log(resp)
						}, function(resp){
							console.log('error');
						}, function(evt){
							element.html('saving...')
							console.log('progress');
						})

					}
					$scope.deleteProfile = function(){
						console.log('unset profile pic')
					}
				}]
			return {
				restrict: 'E',
				templateUrl: 'components/profilePicture.html',
				scope: {
					myUser: '=',
					setProperty: '@'
				},
				controller: controller
			}
	}])