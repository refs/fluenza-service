var dynamicColors = function () {
    var r = Math.floor(Math.random() * 255);
    var g = Math.floor(Math.random() * 255);
    var b = Math.floor(Math.random() * 255);
    return "rgb(" + r + "," + g + "," + b + ")";
}

var expandCampaignUrl = function(extended) {
    url = "http://";
    url += window.location.host;
    path = '/graphs/' + extended;
    url = url + path;
    return url
};

var drawCampaignVideoVisualizations = function(canvas) {
    pathname = window.location.pathname;
    path_fields = pathname.split("/");
    dest = expandCampaignUrl('campaigns/' + path_fields[path_fields.length - 1] + '/youtube_views');
    $.get(dest).then(function(response){
        renderCampaignViewsLineChart(canvas, response, "views");
    });
};

var drawCampaignPostLikes = function(canvas) {
    pathname = window.location.pathname;
    path_fields = pathname.split("/");
    dest = expandCampaignUrl('campaigns/' + path_fields[path_fields.length - 1] + '/posts_likes');
    $.get(dest).then(function(response){
        renderCampaignViewsLineChart(canvas, response, "views");
    });
};

var prepareDatasets = function(payload)
{
    var ret = [];
    for (var i = 0, len = payload["views"]["data"].length; i < len; i++) {
        var color = dynamicColors();
        ret.push(
            {
                data: payload["views"]["data"][i],
                backgroundColor: color,
                borderColor: color,
                fill: false,
                label: payload["views"]["influencers"][i],
                lineTension: 0,
                borderWidth: 3,
                borderCapStyle: 'square',
                pointBackgroundColor: color,
                pointBorderColor: color,
                pointBorderWidth: 4,
                pointRadius: 1,
                pointHoverBackgroundColor: color,
                pointHoverBorderColor: color,
                pointHoverRadius: 2
            });
    }
    return ret
};

var renderCampaignViewsLineChart = function(canvas, payload, chart_title) {
    console.info("fetched dataset successfully");
    dta = prepareDatasets(payload);
    var data = {
        labels: payload["views"]["labels"],
        datasets: dta
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
};