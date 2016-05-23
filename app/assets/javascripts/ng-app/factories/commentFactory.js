angular.module('oscar')
	.factory('commentFactory', function($http){
			var factory = {}
			factory.addComment = function(comment, callback){
				$http.post('/comments', {comment: comment}).then(function(comment){
					callback(comment);
				})
			}
			return factory;
		})