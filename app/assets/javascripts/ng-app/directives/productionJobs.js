angular.module('oscar')
	.directive('productionJobs', ['$window', '$http', function($window, $http){
			controller = ['$scope', '$location', function($scope, $location){
					$scope.showJob = function(jobId){
						console.log('this is the JobId ' + jobId);
					}
					$scope.submitJob =function(jobId){
						console.log('submitting a job')
					}
				}]
			return {
				restrict: 'E',
				templateUrl: 'components/productionJobs.html',
				scope: {
					user: '='
				},
				controller: controller
			}
	}])