angular.module('oscar')
	.directive('reviewTable', ['$window', '$http', function($window, $http){
			controller = ['$scope', '$location', function($scope, $location){
					$scope.showReviews = function(userId){
						console.log(userId);
						$location.path('/users/review/'+ userId);
					}
				}]
			return {
				restrict: 'E',
				templateUrl: 'components/reviewTable.html',
				scope: {
					user: '='
				},
				controller: controller
			}
	}])