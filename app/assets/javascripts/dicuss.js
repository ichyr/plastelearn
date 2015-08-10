// Turbolinks antidote
$(document).on('page:load', function() {
	return $('[ng-app]').each(function() {
		var module;
		module = $(this).attr('ng-app');
		return angular.bootstrap(this, [module]);
	});
});

// Creation of application
var app = angular.module('discusCourse');

var defaults;
defaults = $http.defaults.headers;
defaults.patch = defaults.patch || {};
defaults.patch['Content-Type'] = 'application/json';

app.config(function($httpProvider) {
	var authToken;
	authToken = $("meta[name=\"csrf-token\"]").attr("content");
	return $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken;
});


angular.module('app').factory('Post', function($resource) {
	var Post;
	return Post = (function() {
		function Post(courseId) {
			this.service = $resource('/courses/:course_id/posts/:id', {
				course_id: courseId,
				id: '@id'
			}, {
				update: {
					method: 'PATCH'
				}
			})
		}

		Post.prototype.create = function(attrs) {
			new this.service({
				post: attrs
			}).$save(function(post) {
				return attrs.id = post.id;
			});
			return attrs;
		};

		Post.prototype.all = function() {
			return this.service.query();
		};

		return Post;
	})();
});