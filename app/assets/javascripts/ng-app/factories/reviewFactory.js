angular.module('oscar')
	.factory('reviewFactory', function($http){	
		var factory = {}
		factory.getReviews = function(info, callback){
			$http.get('/reviews/' + info + '.json').success(function(data){
				callback(data);
			})
		}
		return factory
	})