// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function generateChart(dataArray){
    var chart = new Highcharts.Chart({
        chart: {
            type: 'bar',
            renderTo: 'container'
        },

        xAxis: {
            categories: ['1', '2', '3', '4', '5', '6',
                '7', '8', '9', '10']
        },
        title: {
            text: "Grade distribution"
        },
        series: [{
            name: "Grades",
            data: dataArray,
            showInLegend: false
        }],        yAxis: {
            min: 0,
            title: {
                text: 'Grade',
                align: 'high'
            },
            labels: {
                overflow: 'justify'
            }
        },
        tooltip: {
            valueSuffix: ''
        },
        plotOptions: {
            bar: {
                dataLabels: {
                    enabled: true
                }
            }
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'top',
            x: -40,
            y: 100,
            floating: true,
            borderWidth: 1,
            backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
            shadow: true
        },
        credits: {
            enabled: false
        }

    });
}

