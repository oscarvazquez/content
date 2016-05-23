angular.module('oscar')
	.factory('businessFactory', function($http){	
		var factory = {}
		factory.getAll = function(info, callback){
			$http.get('/businesses.json').success(function(data){
				callback(data);
			})
		}
		return factory
	})