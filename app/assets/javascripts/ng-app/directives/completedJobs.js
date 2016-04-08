angular.module('oscar')
	.directive('completedJobs', ['$window', '$http', function($window, $http){
			controller = ['$scope', '$location', function($scope, $location){
					$scope.showJob = function(jobId){
						console.log('this is the JobId ' + jobId);
					}
				}]
			return {
				restrict: 'E',
				templateUrl: 'components/completedJobs.html',
				scope: {
					user: '='
				},
				controller: controller
			}
	}])