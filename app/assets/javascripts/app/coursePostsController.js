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
		$scope.current.selected = true;
	};



	$scope.submitNewPost = function() {
		var newPost = {
			author: "Mama Dia",
			created_at: "Today",
			text: $scope.newPostText
		};

		console.log(newPost);
		$scope.current.conversation.push(newPost);

		$scope.newPostText = "";
	}

	// private like functions

	function _itemsParseIdController($scope, $location) {
		$scope.courseId = (/courses\/(\d+)/.exec($location.absUrl())[1]);
	};

}])