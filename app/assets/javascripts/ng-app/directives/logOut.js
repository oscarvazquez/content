angular.module('oscar')
	.directive('logOut', ['$window', '$http', function($window, $http){
		var template = "<a id = 'logout' class = 'button' ng-click = 'logOut()' role = 'button'>Logout</a>",
			controller = ['$scope', '$location', function($scope, $location){
					$scope.logOut = function(){
						$http.delete('/sessions.json').success(function(data){
							$location.path("/");
						})
					}
				}]
			return {
				restrict: 'E',
				scope: {},
				controller: controller,
				template: template
			}
	}])