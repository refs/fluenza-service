var expandVideoUrl = function(extended) {
  url = "http://"
  url += window.location.host
  path = '/graphs' + extended
  url = url + path
  return url
}

var drawVideoViewsFluctuations = function(canvas, IID) {
  dest = expandVideoUrl('/videos/' + IID + '/views_fluctuation')
  promise = $.get(dest).then(function(response){ 
    renderLineChart(canvas, response, "Views")
  });
}

var drawVideoLikesFluctuations = function(canvas, IID) {
  dest = expandVideoUrl('/videos/' + IID + '/likes_fluctuation')
  promise = $.get(dest).then(function(response){ 
    renderLineChart(canvas, response, "Likes")
  });
}

var renderLineChart = function(canvas, payload, chart_title) {
  console.info("fetched dataset successfully");
  var data = {
    labels: payload["labels"],
    datasets: [
      {
        data: payload["data"],
        label: chart_title,
        fill: false,
        lineTension: 0,
        borderColor: '#2bbbad',
        borderWidth: 3,
        borderCapStyle: 'square',
        pointBackgroundColor: '#2bbbad',
        pointBorderColor: '#2bbbad',
        pointBorderWidth: 4,
        pointRadius: 1,
        pointHoverBackgroundColor: '#59BBAA',
        pointHoverBorderColor: '#59BBAA',
        pointHoverRadius: 2
      }
    ]
    };
    var lineChart = new Chart(canvas, {
      type: 'line',
      data: data,
      options: {
        tooltips: {
            mode: 'index',
            intersect: false,
        },
        hover: {
            mode: 'nearest',
            intersect: true
        },
          scales: {
              xAxes: [{
                  ticks: {
                      autoSkip: true,
                      maxTicksLimit: 16
                  }
              }],
              yAxes: [
                  {
                      ticks: {
                          callback: function(label, index, labels) {
                              return Humanize.compactInteger(label, 2)
                          }
                      }
                  }
              ]
          }
    }
    });
}
