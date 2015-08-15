// Creation of application
var app = angular.module('discussCourse', ['ngResource']);

app.config(function($httpProvider) {
	var authToken;
	authToken = $("meta[name=\"csrf-token\"]").attr("content");
	return $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken;
});