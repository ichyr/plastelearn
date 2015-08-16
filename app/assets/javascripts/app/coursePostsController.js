app.controller('coursePostsController', ['$scope', '$http', '$location', 'Post', function($scope, $http, $location, Post) {
	$scope.changeTopic = function(firstPostId) {
		// change current object
		// load messages
		// 
	};

	$scope.current = {
		conversation: [{
			author: "Dart Wader",
			created_at: "12 Aug 2015",
			text: "lorem"
		}, {
			author: "Dart Wader",
			created_at: "12 Aug 2015",
			text: "Lorem ipsum Anim Excepteur et occaecat cupidatat."
		}, {
			author: "Dart Wader",
			created_at: "12 Aug 2015",
			text: "Lorem ipsum Aliqua quis Duis id officia culpa aliquip esse voluptate minim dolore dolor minim esse in dolor est quis officia."
		}, {
			author: "Dart Wader",
			created_at: "12 Aug 2015",
			text: "Lorem ipsum Magna aute ea velit anim exercitation velit nisi reprehenderit irure adipisicing esse dolor sint labore magna non in anim cupidatat aute eu ad consequat exercitation est officia laborum velit magna occaecat in velit nisi cupidatat enim tempor incididunt Ut pariatur veniam fugiat dolore Ut do in et reprehenderit in enim ad sit magna pariatur nostrud fugiat eu sint ex mollit amet pariatur mollit sed ad enim deserunt amet tempor eiusmod aute ut consequat officia mollit deserunt velit dolore quis sit sunt ea sed adipisicing fugiat quis sint incididunt cillum in pariatur in ullamco dolor occaecat ullamco reprehenderit ut reprehenderit aute mollit pariatur labore voluptate ut Duis nulla ut occaecat officia laboris magna proident in fugiat sunt minim officia officia elit Excepteur veniam est Ut elit aliqua labore ullamco anim quis labore sed aliqua id elit sit anim amet proident culpa eiusmod fugiat Duis quis cillum in et adipisicing id qui elit cillum in eu labore laborum Ut dolore id nostrud exercitation Duis deserunt sit fugiat sed non velit magna incididunt est magna in et Ut fugiat qui ut occaecat anim elit consequat anim et aute enim dolor dolore irure enim velit ad sint ad irure labore cillum Excepteur velit eu sunt commodo aute laborum nisi minim ex ut fugiat quis commodo in quis do.}"
		}],
		topicId: 1,
		title: "What is the aim of the lateral conditions for the brownian movement tripziozonal muscule?"
	}

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

	// Initialize course id in the scope of controller
	_itemsParseIdController($scope, $location);

}])