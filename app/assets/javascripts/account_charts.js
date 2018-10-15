var expand_account_url = function(extended) {
  url = "http://"
  url += window.location.host
  path = '/graphs' + extended
  url = url + path
  return url
}

var drawMonthlyAddedAccounts = function(canvas) {
  dest = expand_account_url('/accounts/monthly_added_accounts')
  promise = $.get(dest).then(function(response){ 
    renderAccountLineChart(canvas, response, "Accounts Added")
  });
}

// TODO refactor - DRY
var renderAccountLineChart = function(canvas, payload, chart_title) {
  console.info("fetched dataset successfully");
  var data = {
    labels: payload["labels"],
    datasets: [
      {
        data: payload["data"],
        label: chart_title,
        fill: true,
        lineTension: 0.3,
        backgroundColor: "rgb(15, 26, 54)",
        borderColor: "#FFFFFF",
        borderCapStyle: 'butt',
        borderDash: [],
        borderDashOffset: 0.0,
        borderJoinStyle: 'miter',
        pointBorderColor: "rgb(15, 26, 54)",
        pointBackgroundColor: "rgb(15, 26, 54)",
        pointBorderWidth: 1,
        pointHoverRadius: 5,
        pointHoverBackgroundColor: "rgb(15, 26, 54)",
        pointHoverBorderColor: "rgb(15, 26, 54)",
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