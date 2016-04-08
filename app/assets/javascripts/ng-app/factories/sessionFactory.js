angular.module('oscar')
	.factory('sessionFactory', function($http){	
		var factory = {}
		factory.loginUser = function(info, callback){
			$http.post('/sessions.json', {user: info}).success(function(data){
				callback(data);
			})
		}
		return factory
	})