// TODO abstract to its own module
var expand_url = function(extended) {
  url = "http://"
  url += window.location.host
  path = '/graphs' + window.location.pathname + '/' + extended
  url = url + path
  return url
}

var drawYoutubeSubscribers = function(canvas) {
  dest = expand_url('youtube_subscribers')
  promise = $.get(dest).then(function(response){
    renderLineChart(canvas, response, "Subscribers")
  });
}

var drawYoutubeViews = function(canvas) {
  dest = expand_url('youtube_views')
  promise = $.get(dest).then(function(response){
    renderLineChart(canvas, response, "Views")
  });
}

var drawInstagramFollowers = function(canvas) {
  dest = expand_url('instagram_followers')
  promise = $.get(dest).then(function(response){
    renderLineChart(canvas, response, "Followers")
  });
}

var drawInstagramLikes = function(canvas) {
  dest = expand_url('instagram_likes')
  promise = $.get(dest).then(function(response){
    renderLineChart(canvas, response, "Liked media")
  });
}
