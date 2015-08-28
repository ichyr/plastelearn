app.controller('coursePostsController', ['$log', '$scope', '$http', '$location', 'Post', function($log, $scope, $http, $location, Post) {

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

	$scope.showModal = function() {
		$log.log("triggered");
		$('#newTopicModal').modal('toggle');
	};	

	$scope.closeModal = function() {
		$log.log("triggered");
		$('#newTopicModal').modal('toggle');
	};

	$scope.createThread = function() {
		if( $scope.newTopic != null && $scope.newTopic != "" && $scope.newTopic != undefined ) {
			var newPost = {
				content: $scope.newTopic,
				parent_id: 0
			};

			postService.service.save(newPost, function(data){
				$scope.topics.push({id: data.id, content: data.content });
				$scope.changeTopic(data.id, data.content);
			});

			$scope.closeModal();
		}

	};

	$('#newTopicModal').on('hide.bs.modal', function () {
		$scope.newTopic = null;
	})


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
