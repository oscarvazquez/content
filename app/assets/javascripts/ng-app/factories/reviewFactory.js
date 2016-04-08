angular.module('oscar')
	.factory('reviewFactory', function($http){	
		var factory = {}
		factory.getReviews = function(info, callback){
			$http.get('/reviews/' + info + '.json', {user: info}).success(function(data){
				callback(data);
			})
		}
		return factory
	})