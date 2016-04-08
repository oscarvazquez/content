angular.module('oscar')
	.directive('reviewTable', ['$window', '$http', function($window, $http){
			controller = ['$scope', '$location', function($scope, $location){
					$scope.showReviews = function(){
						console.log('this is going to show all reviews ');
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