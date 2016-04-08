angular.module('oscar')
	.directive('mapGeoLocation', ['$window', '$http', function($window, $http){
		var template = "<div id = 'map'></div><button class = 'btn' id = 'status'>Get Current Position</button><br />",
			mapContainer = null,
			status = null,
			userID = null,
			myUser = null
		var linkFunction = function(scope, element, attr) {
			scope.$watch('myUser', function(newValue){
				if(newValue != undefined){
					userID = newValue.id
					myUser = newValue
					status = angular.element(document.getElementById('status'))
					mapContainer = angular.element(document.getElementById('map'))
					mapContainer.attr('style', 'height: ' + scope.height +
									  'px;width: ' + scope.width + 'px')
		
					if(newValue.set_location == true){
						status.html('Update Current Location')
						var latlng = new google.maps.LatLng(newValue.lat, newValue.lng)

						var options = {
							zoom: 6, 
							center: latlng,
							mapTypeControl: true, 
							mapTypeId: google.maps.MapTypeId.ROADMAP
						}

						var map = new google.maps.Map(mapContainer[0], options);

						var marker = new google.maps.Marker({
							position: latlng,
							map: map,
							title: "Current Location"
						})
					}
					wireEvents();
				}
			})
			
			function wireEvents(){
				status.on('click', function(event){
					status.html('Looking up geolocation...')
					$window.navigator.geolocation.getCurrentPosition(mapLocation, geoError)
				})
			}

			function mapLocation(pos, update){
				status.html('Update Current Location');
				var latlng = new google.maps.LatLng(pos.coords.latitude, pos.coords.longitude)

				var options = {
					zoom: 8, 
					center: latlng,
					mapTypeControl: true, 
					mapTypeId: google.maps.MapTypeId.ROADMAP
				}

				var map = new google.maps.Map(mapContainer[0], options);

				var marker = new google.maps.Marker({
					position: latlng,
					map: map,
					title: "Current Location"
				})

				var location = {
					lat: pos.coords.latitude,
					lng: pos.coords.longitude,
					userID: userID
				}
				updateLocation(location)

			}

			function updateLocation(location){
				$http.post('/users/add_location.json', {location: location}).success(function(data){
					myUser.lat = data.user.lat
					myUser.lng = data.user.lng
					myUser.set_location = true
				})
			}

			function geoError(error){
				console.log('error')
				status.html("Try Again, " + error.message)
			}
		}
		return {
			restrict: 'E',
			scope: {
				myUser: '=',
				height: '@',
				width: '@',
				link: '&'
			},
			link: linkFunction,
			template: template
		}
	}])

