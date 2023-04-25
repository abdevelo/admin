<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--chart01--%>
<script>
    // chart01 의 변수로서 chart 만들기를 선언
    // function 을 호출하면서 chart01 을 init
    let chart01 = {
        init: function () {

            // Data retrieved https://en.wikipedia.org/wiki/List_of_cities_by_average_temperature
            Highcharts.chart('c0', {
                chart: {
                    type: 'spline'
                },
                title: {
                    text: 'Monthly Average Temperature'
                },
                subtitle: {
                    text: 'Source: ' +
                        '<a href="https://en.wikipedia.org/wiki/List_of_cities_by_average_temperature" ' +
                        'target="_blank">Wikipedia.com</a>'
                },
                xAxis: {
                    categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    accessibility: {
                        description: 'Months of the year'
                    }
                },
                yAxis: {
                    title: {
                        text: 'Temperature'
                    },
                    labels: {
                        formatter: function () {
                            return this.value + '°';
                        }
                    }
                },
                tooltip: {
                    crosshairs: true,
                    shared: true
                },
                plotOptions: {
                    spline: {
                        marker: {
                            radius: 4,
                            lineColor: '#666666',
                            lineWidth: 1
                        }
                    }
                },
                // series 가 data

                series: [{
                    name: 'Tokyo',
                    marker: {
                        symbol: 'square'
                    },
                    data: [5.2, 5.7, 8.7, 13.9, 18.2, 21.4, 25.0,23.0, 22.8, 17.5, 12.1, 7.6]

                }, {
                    name: 'Bergen',
                    marker: {
                        symbol: 'diamond'
                    },
                    data: [1.0, 1.6, 3.3, 5.9, 10.5, 13.5, 14.5, 14.4, 11.5, 8.7, 4.7, 2.6]
                } , {
                    name: 'Korea',
                    marker: {
                        symbol: 'diamond'
                    },
                    data: [2.0, 3.6, 4.3, 6.9, 11.5, 14.5, 15.5, 15.4, 12.5, 9.7, 5.7, 3.6]
                }
                ]
            }); // end of import source
        }
    };
    let chart03 = {
        init: function () {
            this.getdata1();
            this.getdata2();
            this.getdata3();
        },
        getdata1: function () {
            $.ajax({
                url:'/chart0301',
                success:function (result){
                    chart03.display1(result);
                }
            })
        },
        getdata2: function () {
            $.ajax({
                url:'/chart0302',
                success:function (result2){
                    chart03.display2(result2);
                }
            })
        },
        getdata3: function () {
            $.ajax({
                url:'/chart0303',
                success:function (result3){
                    chart03.display3(result3);
                    console.log(result3);
                }
            })
        },
        display1: function (result) {
            // the start of chart code
            // Data retrieved from https://olympics.com/en/olympic-games/beijing-2022/medals
            Highcharts.chart('c1', {
                chart: {
                    type: 'pie',
                    options3d: {
                        enabled: true,
                        alpha: 45
                    }
                },
                title: {
                    text: 'Beijing 2022 gold medals by country',
                    align: 'left'
                },
                subtitle: {
                    text: '3D donut in Highcharts',
                    align: 'left'
                },
                plotOptions: {
                    pie: {
                        innerSize: 100,
                        depth: 45
                    }
                },
                series: [{
                    name: 'Medals',
                    data: result
                }]
            }); // the end of chart code

        },
        display2: function (result2) {
            Highcharts.chart('c2', {
                chart: {
                    type: 'cylinder',
                    options3d: {
                        enabled: true,
                        alpha: 15,
                        beta: 15,
                        depth: 50,
                        viewDistance: 25
                    }
                },
                title: {
                    text: 'Number of confirmed COVID-19'
                },
                xAxis: {
                    categories: result2.age,
                    title: {
                        text: 'Age groups'
                    }
                },
                yAxis: {
                    title: {
                        margin: 20,
                        text: 'Reported cases'
                    }
                },
                plotOptions: {
                    series: {
                        depth: 25,
                        colorByPoint: true
                    }
                },
                series: [{
                    data: result2.data2,
                    name: 'Cases',
                    showInLegend: false
                }]
            });

        },
        display3: function (result3) {
            Highcharts.chart('c3', {
                chart: {
                    type: 'area'
                },
                title: {
                    useHTML: true,
                    text: 'Countries/regions with highest Gt CO<sub>2</sub>-emissions',
                    align: 'left'
                },
                subtitle: {
                    text: 'Source: ' +
                        '<a href="https://energiogklima.no/klimavakten/land-med-hoyest-utslipp/"' +
                        'target="_blank">Energi og Klima</a>',
                    align: 'left'
                },
                accessibility: {
                    point: {
                        valueDescriptionFormat: '{index}. {point.category}, {point.y:,.1f} billions, {point.percentage:.1f}%.'
                    }
                },
                yAxis: {
                    labels: {
                        format: '{value}%'
                    },
                    title: {
                        enabled: false
                    }
                },
                tooltip: {
                    pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.percentage:.1f}%</b> ({point.y:,.1f} billion Gt)<br/>',
                    split: true
                },
                plotOptions: {
                    series: {
                        pointStart: 1990
                    },
                    area: {
                        stacking: 'percent',
                        marker: {
                            enabled: false
                        }
                    }
                },
                series: [{
                    name: 'China',
                    data: result3.china
                    // data:result3[china:0]
                }, {
                    name: 'USA',
                    data: result3.usa
                }, {
                    name: 'EU',
                    data: result3.eu
                }, {
                    name: 'India',
                    data: result3.india
                }]
            });


        }
    };

    $(function(){
        chart01.init();
        chart03.init();
    });
</script>
<div class="container-fluid">
  <!-- Content Row -->
  <div class="row">
<%--    추가한 chart starts--%>
      <div class="col-sm-10 text-left">
          <h3>CHART01</h3>
          <div id="c0"></div>
          <h3>CHART03</h3>
          <div class="" id="c1"></div>
          <div class="" id="c2"></div>
          <div class="" id="c3"></div>
      </div>
      <div class="container">
      </div>
      </div>
    <%--    추가한 chart ends--%>

  </div>  <!-- Content Row Ends-->

</div>
<%--chart01--%>