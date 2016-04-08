angular.module('oscar')
	.factory('userFactory', function($http){
	var factory = {};
	factory.addUser = function(info, callback){
		$http.post('/users.json', {user: info}).success(function(data){
			callback(data);
		})
	}
	factory.check_email_token = function(token, callback){
		$http.get('/users/check_email/' + token + '.json').success(function(data){
			callback(data);
		})
	}
	factory.getUser = function(userId, callback){
		$http.get('/users/' + userId + '.json').success(function(data){
			callback(data);
		})
	}
	return factory;
})