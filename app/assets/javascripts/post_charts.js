var expandVideoUrl = function(extended) {
  url = "http://"
  url += window.location.host
  path = '/graphs' + extended
  url = url + path
  return url
}

var drawPostLikesFluctuations = function(canvas, IID) {
  dest = expandVideoUrl('/posts/' + IID + '/likes_fluctuation')
  promise = $.get(dest).then(function(response){ 
    renderLineChart(canvas, response, "Likes")
  });
}

// TODO refactor - DRY
var renderLineChart = function(canvas, payload, chart_title) {
  console.info("fetched dataset successfully");
  var data = {
    labels: payload["labels"],
    datasets: [
      {
        data: payload["data"],
        label: chart_title,
        fill: false,
        lineTension: 0.1,
        backgroundColor: "rgba(75,192,192,0.4)",
        borderColor: "#162752",
        borderCapStyle: 'butt',
        borderDash: [],
        borderDashOffset: 0.0,
        borderJoinStyle: 'miter',
        pointBorderColor: "#fff",
        pointBackgroundColor: "#fff",
        pointBorderWidth: 1,
        pointHoverRadius: 5,
        pointHoverBackgroundColor: "rgba(75,192,192,1)",
        pointHoverBorderColor: "rgba(220,220,220,1)",
        pointHoverBorderWidth: 2,
        pointRadius: 1,
        pointHitRadius: 10,
        spanGaps: false
      }
    ]
    };
    var lineChart = new Chart(canvas, {
      type: 'line',
      data: data
    });
}