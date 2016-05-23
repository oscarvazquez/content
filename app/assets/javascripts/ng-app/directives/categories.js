angular.module('oscar')
	.directive('categories', ['$window', '$http', function($window, $http){
			controller = ['$scope', '$compile', function($scope, $compile){
				
				var Categories = angular.element( document.querySelector('#category_box'));
				var colors = ['#354458', '#3a9ad9', '#eb7260', '#5bb12f', '#ff432e']

				$scope.$watch('userProfile', function(user){
					if(user != undefined){
						build_categories(user.categories, colors, Categories, $scope.catDelete)
					}
				})
				$scope.deleteCategory = function(categoryId, callback){
					$http.delete('/categories/' + categoryId + '.json').then(function(data){
						for(var i = 0; i < $scope.userProfile.categories.length; i++){
							if($scope.userProfile.categories[i].id === categoryId){
								var deletedCat = $scope.userProfile.categories.splice(i, 1);
								build_categories($scope.userProfile.categories, colors, Categories, $scope.catDelete);
								deletedCat[0].subcategories = [];
								$scope.userProfile.all_categories.push(deletedCat[0]);
									for(var z = 0; z < $scope.userProfile.all_subcategories.length; z++){
										var length = $scope.userProfile.all_subcategories[z].subcategories.length
										var arr = []
										for(var n = 0; n < length; n++){
											if($scope.userProfile.all_subcategories[z].subcategories[n].category_id != categoryId){
												arr.push($scope.userProfile.all_subcategories[z].subcategories[n])
											}
										}
										$scope.userProfile.all_subcategories[z].subcategories = arr
									}
								callback(deletedCat);
							}
						}
					})
				}
				$scope.confirmDelete = function(category){
					console.log(category);
					sweetAlert({   
						title: "Are you want to delete this category?",   
						text: "When you delete a category all of it's subcategories are deleted as well!",   
						type: "warning",   
						showCancelButton: true,   
						confirmButtonColor: "#DD6B55",   
						confirmButtonText: "Yes, delete it!",  
						closeOnConfirm: false }, 
						function(){
							$scope.deleteCategory(category, function(d){
								sweetAlert({
									title: "Deleted!", 
									text: d[0].category + ' has been deleted from your list of categories!',
									timer: 2000,
									showConfirmationButton: true
								}); 
							})
						});
				}
				$scope.deleteSubCategory = function(subCategoryId){
					$http.delete('/subcategories/' + subCategoryId + '.json').then(function(data){
						for(var i = 0; i < $scope.userProfile.categories.length; i++){
							for(var j = 0; j < $scope.userProfile.categories[i].subcategories.length; j++){
								if($scope.userProfile.categories[i].subcategories[j].id === subCategoryId){
									var x = $scope.userProfile.categories[i].subcategories.splice(j, 1);
									build_categories($scope.userProfile.categories, colors, Categories, $scope.catDelete)
									$scope.userProfile.all_subcategories[0].subcategories.push(x[0])
								}
							}
						}
						for(var x = 0; x < $scope.userProfile.subcategories.length; x++){
							if($scope.userProfile.subcategories[x].id == subCategoryId){
								$scope.userProfile.subcategories.splice(x, 1);
							}
						}
							
					})
				}

				$scope.addSubcategory = function(){
					$scope.changed = false;
					var all_subcategories = $scope.userProfile.all_subcategories
					var div = "<div id = 'sweetInput'></div>"
					var input = '<a ng-repeat = "item in userProfile.subcategories">{{item.subcategory}} - </a>'
					input += '<a ng-repeat = "item in newList">{{item.subcategory}} - </a>'
					input += "<input type = 'text' class = 'form-control' ng-model = 'newSubCategory.subcategory' id = 'newCategory' placeholder = 'Enter Subcategory Name'>"
					input += "<div><ul id = 'newCategoryList'></ul></div>"
					sweetAlert({
						  title: "Add a new Sub Category!",   
						  text: div,  
						  html: true,
						  showCancelButton: true,
						  confirmButtonColor: "#DD6B55",   
						  confirmButtonText: "Save!"
					}, function(isConfirm){
						if(isConfirm){
							$scope.updateSubList();
						} else {
							refresh_sublist_all();
							console.log('cancelled')
						}
					})
					var html = angular.element(input)
					var compiled = $compile(html)
					var box = angular.element( document.querySelector('#sweetInput'));
					box.html(html)
					compiled($scope)
					$scope.loadSubData()			
				}

				$scope.addCategory = function(){
					$scope.changed = false;
					var all_categories = $scope.userProfile.all_categories
					var div = "<div id = 'sweetInput'></div>"
					var input = '<a ng-repeat = "item in userProfile.categories">{{item.category}} - </a>'
					input += '<a ng-repeat = "item in newList">{{item.category}} - </a>'
					input += "<input type = 'text' class = 'form-control' ng-model = 'newCategory.category' id = 'newCategory' ng-change='loadData()' placeholder = 'Enter Category Name'>"
					input += "<div><ul id = 'newCategoryList'></ul></div>"
					
					sweetAlert({
						  title: "Add a new Category!",   
						  text: div,  
						  html: true,
						  showCancelButton: true,
						  confirmButtonColor: "#DD6B55",   
						  confirmButtonText: "Save!"
					}, function(isConfirm){
						if(isConfirm){
							$scope.updateList()
						} else {
							refresh_list_all();
						}
					})

					var html = angular.element(input)
					var compiled = $compile(html)
					var box = angular.element( document.querySelector('#sweetInput'));
					box.html(html)
					compiled($scope)
				}

				$scope.updateList = function(){
					if($scope.changed){
						$http.post("/categories.json", {categories: $scope.newList}).then(function(data){
							for(var x = 0; x<$scope.newList.length; x++){
								$scope.userProfile.categories.push($scope.newList[x])
								for(var n = 0; n<$scope.userProfile.all_categories.length; n++){
									if($scope.userProfile.all_categories[n].id == $scope.newList[x].id){
										$scope.userProfile.all_categories.splice(n, 1);
									}
								}
							}
							for(var z = 0; z < data.data.subcategories.length; z++){
								$scope.userProfile.all_subcategories[0].subcategories.push(data.data.subcategories[z])
							}

							$scope.newList = ''
							build_categories($scope.userProfile.categories, colors, Categories, $scope.catDelete)
						})
					}
				}

				$scope.updateSubList = function(){
					if($scope.changed){
						$http.post("/subcategories.json", {subcategories: $scope.newList}).then(function(data){
							for(var x = 0; x<$scope.newList.length; x++){
								$scope.userProfile.subcategories.push($scope.newList[x]);
								for(var i = 0; i < $scope.userProfile.categories.length; i ++){
									if($scope.newList[x].category_id == $scope.userProfile.categories[i].id){
										$scope.userProfile.categories[i].subcategories.push($scope.newList[x])
									}
								}
							}
							$scope.newList = ''
							build_categories($scope.userProfile.categories, colors, Categories, $scope.catDelete)
						})
					}
				}

				$scope.loadSubData = function(){
					var catList = angular.element( document.querySelector('#newCategoryList'));
					var list = "<div class = 'all_sublist_add' ng-repeat = 'cats in userProfile.all_subcategories'>"
					list += "<li class = 'clickable' ng-repeat = 'cat in cats.subcategories | filter:newSubCategory | limitTo: 15' style= 'background-color:" + colors[1] + ";' ng-click = 'addToNewList(cat)'>{{cat.subcategory}}</li>"
					list += "</div>"
					var html = angular.element(list),
						compiled = $compile(html);
					catList.html(html);
					compiled($scope);
				}

				$scope.loadData = function(){
					var catList = angular.element( document.querySelector('#newCategoryList'));
					var list = "<li class = 'clickable' ng-repeat = 'cats in userProfile.all_categories | filter:newCategory | limitTo: 15' style= 'background-color:" + colors[1] + ";' ng-click = 'addToNewList(cats)'>{{cats.category}}</li>"
					var html = angular.element(list),
						compiled = $compile(html);
					catList.html(html);
					compiled($scope);
				}

				$scope.addToNewList = function(cat){
					$scope.newSubCategory = ''
					$scope.newCategory = ''
					if (!$scope.newList){
						$scope.newList = [cat]
						$scope.changed = true;
					} else{
						$scope.newList.push(cat);
						$scope.changed = true;
					}
					for(var i = 0; i<$scope.userProfile.all_categories.length; i++){
						if($scope.userProfile.all_categories[i] == cat){
							return $scope.userProfile.all_categories.splice(i, 1);
						}
					}
					for(var j = 0;j<$scope.userProfile.all_subcategories.length; j++){
						for(var n = 0;n<$scope.userProfile.all_subcategories[j].subcategories.length; n++){
							if($scope.userProfile.all_subcategories[j].subcategories[n].id == cat.id){
								return $scope.userProfile.all_subcategories[j].subcategories.splice(n, 1);
							}
						}
					}
				}

				var refresh_list_all = function(){
					if($scope.newList){
						for(var i = 0; i < $scope.newList.length; i++){
							$scope.userProfile.all_categories.push($scope.newList[i])
						}
						$scope.newList = '';
					}
				}
				var refresh_sublist_all = function(){
					if($scope.newList){
						for(var i = 0; i < $scope.newList.length; i++){
							$scope.userProfile.all_subcategories[0].subcategories.push($scope.newList[i])
						}
						$scope.newList = '';
					}
				}				

				var build_categories = function(cats, colors, Categories, canDelete){
					var html = ''
					var counter = 0
					if(cats){
						for(var i = 0; i < cats.length; i++){
							html += '<div class = "pad_cat_box" style= "background-color:' + colors[i] +';">'
							if (canDelete == 'true'){
								html += '<span id = "closeCat" class="glyphicon glyphicon-remove clickable" aria-hidden="true" ng-click = "confirmDelete( ' + cats[i].id + ' )"></span>'
							}
							html += '<div class = "categories" style= "background-color:' + colors[i] +';">'
							var cat = cats[i].category
							html += pick_glyph(cat)
							html += ' ' + cats[i].category
							html += "</div>"
							html += "</div>"
							if(cats[i].subcategories){
								html += build_subcategories(cats[i].subcategories, cat, colors[i], canDelete)
							}
						}
						html += "</div>"
					}
					var el = angular.element(html)
					var compiled = $compile(el)
					Categories.html(el)
					compiled($scope)
				}

				var build_subcategories = function(subs, cat, color, canDelete){
					var html = ''
					for(var j = 0; j < subs.length; j++){
						html += '<div class = "pad_cat_box" style= "background-color:' + color +';">'
						if (canDelete == 'true'){
							html += '<span ng-click = "deleteSubCategory(' + subs[j].id + ')" id = "closeCat" class="glyphicon glyphicon-remove clickable" aria-hidden="true"></span>'
						}	
						html += '<div class = "subcategories" style= "background-color:' + color +';">'				
						html += pick_glyph(cat)
						html += ' ' + subs[j].subcategory
						html += '</div>'
						html += '</div>'
					}
					return html;
				}

				var pick_glyph = function(cat){
					var html = ''
					if(cat == 'Law'){
						html += '<span class="glyphicon glyphicon-briefcase" aria-hidden="true"></span>'
					} else if (cat == 'Medical'){
						html += '<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>'
					} else if (cat == 'Finance'){
						html += '<span class="glyphicon glyphicon-usd" aria-hidden="true"></span>'
					} else if (cat == 'Education'){
						html += '<span class="glyphicon glyphicon-apple" aria-hidden="true"></span>'
				    } else {
						html += '<span class="glyphicon glyphicon-user" aria-hidden="true"></span>'
					}
					return html				
				}
			}]	
			return {
				restrict: 'E',
				templateUrl: 'components/categories.html',
				scope: {
					userProfile: '=',
					catDelete: '@'
				},
				controller: controller
			}
	}])