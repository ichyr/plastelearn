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
				},
				getDiscussion: {
					method: 'GET',
					isArray: true
				}
			})
		};

		Post.prototype.create = function(attrs) {
			new this.service({
				post: attrs
			}).$save(function(post) {
				attrs.id = post.id;
				return attrs.user_id = post.user_id;
			});
			return attrs;
		};

		Post.prototype.getDiscussion = function(postId) {
			return this.service.getDiscussion({id: postId});
		};

		Post.prototype.all = function() {
			return this.service.query();
		};

		return Post;
	})();
});