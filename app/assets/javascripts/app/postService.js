app.factory('Post', function($resource) {
	var Post;
	return Post = (function() {
		function Post(courseId) {
			this.service = $resource('/courses/:course_id/posts/:id.json', {
				course_id: courseId,
				id: '@id'
			}, {
				update: {
					method: 'PATCH'
				}
			})

			console.log(courseId);
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