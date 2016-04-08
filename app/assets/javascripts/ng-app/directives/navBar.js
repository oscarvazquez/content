angular.module('oscar')
	.directive('navBar', ['$window', '$http', function($window, $http){
			controller = ['$scope', '$location', function($scope, $location){
					console.log($scope.myUser);
					$scope.showMessage = function(messageId){
						console.log('showing message id ' + messageId);
					}
					$scope.showMessages = function(){
						console.log('getting all messages');
					}
					$scope.newMessage = function(){
						console.log('sending user so he can create new message');
					}
					$scope.showUser = function(senderId){
						console.log('this is senderID ' + senderId);
					}
					$scope.markNotiAsRead = function(){
						console.log('marking all notifications as read');
					}
					$scope.showBusiness = function(businessId){
						console.log('showing business ' + businessId);
					}
					$scope.showEvent = function(eventId){
						console.log('showing eventId ' + eventId);
					}
				}]
			return {
				restrict: 'E',
				templateUrl: 'components/navbar.html',
				scope: {
					myUser: '='
				},
				controller: controller
			}
	}])