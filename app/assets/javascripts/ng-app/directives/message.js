angular.module('oscar')
	.directive('message', ['$http', function($http){
			controller = ['$scope', '$location', function($scope, $location){
					$scope.newMessage = function(){
						console.log('creating new message');
						console.log($scope.receiverId);
						console.log($scope.receiverName);
						console.log($scope.receiverType);
						sweetAlert({
							title: "New Message",
							text: "Write a message to " + $scope.receiverName,
							type: "input",
							showCancelButton: true,
							closeOnConfirm: false,
							animation: "slide-from-top",
							inputPlaceholder: 'Write Something'
						},
						function(inputValue){
							if(inputValue === false) return false;
							if(inputValue === ""){
								sweetAlert.showInputError("You need to write something!");
								return false;
							}
							var newMessage = {
								receiver_id: $scope.receiverId,
								receiver_type: $scope.receiverType,
								message: inputValue
							}
							$http.post("/messages", {message: newMessage}).then(function(data){
								console.log(data);
							})
							sweetAlert("Nice!", "You wrote: " + inputValue, "success");
						})
					}
				}]

			var newTemplate = '<button class = "btn btn-primary" ng-click = "newMessage()">Send Message</button>'
			return {
				restrict: 'E',
				scope: {
					receiverId: '@',
					receiverName: '@',
					receiverType: '@'
				},
				controller: controller,
				template: newTemplate
			}
	}])