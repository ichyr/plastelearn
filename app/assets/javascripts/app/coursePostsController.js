app.controller('coursePostsController', ['$scope', '$http', '$location', 'Post', function($scope, $http, $location, Post) {

	// Initialize course id in the scope of controller
	_itemsParseIdController($scope, $location);
	var postService = new Post($scope.courseId);

	// Initialize the list of topics
	$scope.topics = postService.all();

	// Initialize conversation array
	$scope.current = {
		selected: false
	};

	$scope.changeTopic = function(topicId, topicText) {
		$scope.current.conversation = postService.getDiscussion(topicId);
		$scope.current.title = topicText;
		$scope.current.topicId = topicId;
		$scope.current.selected = true;
	};



	$scope.submitNewPost = function() {
		var newPost = {
			content: $scope.newPostText,
			parent_id: $scope.current.topicId
		};

		postService.service.save(newPost, function(post){
			$scope.current.conversation.push(post);
			$scope.newPostText = "";
		});
		
	}

	// private like functions

	function _itemsParseIdController($scope, $location) {
		$scope.courseId = (/courses\/(\d+)/.exec($location.absUrl())[1]);
	};

}])