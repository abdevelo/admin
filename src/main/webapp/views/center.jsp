<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--웹소켓--%>
<script>
  let websocket_center = {
    stompClient: null, // ws와의 커넥션 정보
    init: function () {
      this.connect();
    },
    connect: function () {
      var sid = this.id;
      var socket = new SockJS('${adminserver}/wss'); //ws가 아닌 wss
      var tasksWidth =
      this.stompClient = Stomp.over(socket);
      this.stompClient.connect({}, function (frame) {
        console.log('Connected: ' + frame);
        this.subscribe('/sendadm', function (msg) {
          //msg로 들어온 데이터는 Msgadm 객체로 content1, 2, 3, 4 를 가지고 있음
          $('#content1_msg').text(JSON.parse(msg.body).content1);
          $('#content2_msg').text(JSON.parse(msg.body).content2);
          $('#content3_msg').text(JSON.parse(msg.body).content3);
          $('#content4_msg').text(JSON.parse(msg.body).content4);
          $('#progress1').css('width', JSON.parse(msg.body).content1 + "%");
          $('#progress1').attr('aria-valuenow',JSON.parse(msg.body).content1);
          $('#progress2').css('width', JSON.parse(msg.body).content2/10 + "%");
          $('#progress2').attr('aria-valuenow',JSON.parse(msg.body).content2/10);
          $('#progress3').css('width', JSON.parse(msg.body).content3/500 * 100 + "%");
          $('#progress3').attr('aria-valuenow',JSON.parse(msg.body).content3/500 * 100);
          $('#progress4').css('width', JSON.parse(msg.body).content4/150 * 100 + "%");
          $('#progress4').attr('aria-valuenow',JSON.parse(msg.body).content4/150 * 100);
        });
      })
    }
  };


  $(function (){
    websocket_center.init();
  });
</script>

<%--월별남녀비중매출액 그래프--%>
<script>
  let chart_gender = {
    init:function(){
      this.getData();
    },
    getData:function () {
      $.ajax({
        url:'/chartgender',
        success:function(result){
          chart_gender.display(result);
          alert(result.month);
        }
      })
    },
    display:function(result){
      Highcharts.chart('c2', {
        chart: {
          type: 'column'
        },
        title: {
          text: 'Sales Percentage By Gender'
        },
        xAxis: {
          categories:
        },
        yAxis: {
          min: 0,
          title: {
            text: 'Assists'
          }

        },
        tooltip: {
          pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.percentage:.0f}%)<br/>',
          shared: true
        },
        series: [{
          name: 'Male',
          data: result.male
        }, {
          name: 'Female',
          data: result.female
        }]


      });
    }
  }
  $(function (){
    chart_gender.init();
  })


</script>

<%--꺾은선그래프--%>
<script>
  let chart01 = {
    init: function() {
      this.getData();
    },
    getData:function(){
      $.ajax({
        url:'/chartgender',
        success:function(result){
          chart01.display(result);
          alert(result);
          console.log(typeof result.male[0]);
          console.log(result.male);
          console.log(result);
        }
      })
    },
    display:function (result){
      Highcharts.chart('c0', {
        chart: {
          type: 'spline'
        },
        title: {
          text: 'Monthly Average Temperature'
        },
        xAxis: {
          categories: result.month,
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
        // series 가 data
        series: [{
          name: 'Tokyo',
          marker: {
            symbol: 'square'
          },
          data: result.male[0]
        }, {
          name: 'Bergen',
          marker: {
            symbol: 'diamond'
          },
          data:result.female[0]
        }
        ]
      }); // end of import source
    }
  };
  $(function (){
    chart01.init();
  })
</script>
<%--파이차트--%>
<script>
  let chart03 = {
    init: function () {
      this.getdata1();
    },
    getdata1: function () {
      $.ajax({
        url:'/chart0301',
        success:function (result){
          chart03.display1(result);
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

    }
  };
  $(function(){
    chart03.init();
  });
</script>

<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4">
  <h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
  <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i
          class="fas fa-download fa-sm text-white-50"></i> DOWNLOAD </a>
</div>

<!-- Content Row / ICON -->
<div class="row">

  <!-- Earnings (Monthly) Card Example -->
  <div class="col-xl-3 col-md-6 mb-4">
    <div class="card border-left-primary shadow h-100 py-2">
      <div class="card-body">
        <div class="row no-gutters align-items-center">
          <div class="col mr-2">
            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">EARNINGS(MONTHLY)
            </div>
            <div class="row no-gutters align-items-center">
              <div class="col-auto">
                <div id="content1_msg" class="h5 mb-0 mr-3 font-weight-bold text-gray-800">Loading..</div>
              </div>
              <div class="col">
                <div class="progress progress-sm mr-2">
                  <div id="progress1" class="progress-bar bg-primary" role="progressbar"
                       style="width: 50%" aria-valuenow="0" aria-valuemin="0"
                       aria-valuemax="100"></div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-auto">
            <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Earnings (Monthly) Card Example -->
  <div class="col-xl-3 col-md-6 mb-4">
    <div class="card border-left-success shadow h-100 py-2">
      <div class="card-body">
        <div class="row no-gutters align-items-center">
          <div class="col mr-2">
            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">EARNINGS(ANNUAL)
            </div>
            <div class="row no-gutters align-items-center">
              <div class="col-auto">
                <div id="content2_msg" class="h5 mb-0 mr-3 font-weight-bold text-gray-800">Loading..</div>
              </div>
              <div class="col">
                <div class="progress progress-sm mr-2">
                  <div id="progress2" class="progress-bar bg-success" role="progressbar"
                       style="width: 50%" aria-valuenow="0" aria-valuemin="0"
                       aria-valuemax="100"></div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-auto">
            <i class="fas fa-baby-carriage fa-2x text-gray-300"></i>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Earnings (Monthly) Card Example -->
  <div class="col-xl-3 col-md-6 mb-4">
    <div class="card border-left-danger shadow h-100 py-2">
      <div class="card-body">
        <div class="row no-gutters align-items-center">
          <div class="col mr-2">
            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Tasks
            </div>
            <div class="row no-gutters align-items-center">
              <div class="col-auto">
                <div id="content3_msg" class="h5 mb-0 mr-3 font-weight-bold text-gray-800">Loading..</div>
              </div>
              <div class="col">
                <div class="progress progress-sm mr-2">
                  <div id="progress3" class="progress-bar bg-danger" role="progressbar"
                       style="width: 50%" aria-valuenow="0" aria-valuemin="0"
                       aria-valuemax="100"></div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-auto">
            <i class="fas fa-chalkboard-teacher fa-2x text-gray-300"></i>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Pending Requests Card Example -->
  <div class="col-xl-3 col-md-6 mb-4">
    <div class="card border-left-warning shadow h-100 py-2">
      <div class="card-body">
        <div class="row no-gutters align-items-center">
          <div class="col mr-2">
            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">PENDING REQUESTS
            </div>
            <div class="row no-gutters align-items-center">
              <div class="col-auto">
                <div id="content4_msg" class="h5 mb-0 mr-3 font-weight-bold text-gray-800">Loading..</div>
              </div>
              <div class="col">
                <div class="progress progress-sm mr-2">
                  <div id="progress4" class="progress-bar bg-warning" role="progressbar"
                       style="width: 50%" aria-valuenow="0" aria-valuemin="0"
                       aria-valuemax="100"></div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-auto">
            <i class="fas fa-arrow-circle-up fa-2x text-gray-300"></i>
          </div>
        </div>
      </div>
    </div>
  </div>

</div>
<!-- Content Row / ICON -->

<!---------------- Content Row 1------------------>
<div class="row">




  <!---------------- Content Row 2------------------>


<%--  월별 남녀 매출 비중 그래프 뿌릴 곳 --%>
  <figure class="highcharts-figure">
    <div id="c2"></div>
  </figure>

  <!-- 꺾은선 그래프 -->
  <div class="col-sm-5 text-left">
      <h3>CHART01</h3>
      <div id="c0"></div>
    </div>

  <!-- 파이 차트 -->
  <div class="col-sm-5 text-left">
    <h3>CHART03</h3>
    <div class="" id="c1"></div>
  </div>
</div>


<!---------------- Content Row 3------------------>
<div class="row">
  <!-- Content Column -->
  <div class="col-lg-6 mb-4">
    <!-- Project Card Example -->
    <div class="card shadow mb-4">
      <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary">Projects</h6>
      </div>
      <div class="card-body">
        <h4 class="small font-weight-bold">Server Migration <span
                class="float-right">20%</span></h4>
        <div class="progress mb-4">
          <div class="progress-bar bg-danger" role="progressbar" style="width: 20%"
               aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
        </div>
        <h4 class="small font-weight-bold">Sales Tracking <span
                class="float-right">40%</span></h4>
        <div class="progress mb-4">
          <div class="progress-bar bg-warning" role="progressbar" style="width: 40%"
               aria-valuenow="40" aria-valuemin="0" aria-valuemax="100"></div>
        </div>
        <h4 class="small font-weight-bold">Customer Database <span
                class="float-right">60%</span></h4>
        <div class="progress mb-4">
          <div class="progress-bar" role="progressbar" style="width: 60%"
               aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
        </div>
        <h4 class="small font-weight-bold">Payout Details <span
                class="float-right">80%</span></h4>
        <div class="progress mb-4">
          <div class="progress-bar bg-info" role="progressbar" style="width: 80%"
               aria-valuenow="80" aria-valuemin="0" aria-valuemax="100"></div>
        </div>
        <h4 class="small font-weight-bold">Account Setup <span
                class="float-right">Complete!</span></h4>
        <div class="progress">
          <div class="progress-bar bg-success" role="progressbar" style="width: 100%"
               aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
        </div>
      </div>
    </div>
    <!-- Color System -->
    <div class="row">
      <div class="col-lg-6 mb-4">
        <div class="card bg-primary text-white shadow">
          <div class="card-body">
            Primary
            <div class="text-white-50 small">#4e73df</div>
          </div>
        </div>
      </div>
      <div class="col-lg-6 mb-4">
        <div class="card bg-success text-white shadow">
          <div class="card-body">
            Success
            <div class="text-white-50 small">#1cc88a</div>
          </div>
        </div>
      </div>
      <div class="col-lg-6 mb-4">
        <div class="card bg-info text-white shadow">
          <div class="card-body">
            Info
            <div class="text-white-50 small">#36b9cc</div>
          </div>
        </div>
      </div>
      <div class="col-lg-6 mb-4">
        <div class="card bg-warning text-white shadow">
          <div class="card-body">
            Warning
            <div class="text-white-50 small">#f6c23e</div>
          </div>
        </div>
      </div>
      <div class="col-lg-6 mb-4">
        <div class="card bg-danger text-white shadow">
          <div class="card-body">
            Danger
            <div class="text-white-50 small">#e74a3b</div>
          </div>
        </div>
      </div>
      <div class="col-lg-6 mb-4">
        <div class="card bg-secondary text-white shadow">
          <div class="card-body">
            Secondary
            <div class="text-white-50 small">#858796</div>
          </div>
        </div>
      </div>
      <div class="col-lg-6 mb-4">
        <div class="card bg-light text-black shadow">
          <div class="card-body">
            Light
            <div class="text-black-50 small">#f8f9fc</div>
          </div>
        </div>
      </div>
      <div class="col-lg-6 mb-4">
        <div class="card bg-dark text-white shadow">
          <div class="card-body">
            Dark
            <div class="text-white-50 small">#5a5c69</div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="col-lg-6 mb-4">

    <!-- Illustrations -->
    <div class="card shadow mb-4">
      <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary">Illustrations</h6>
      </div>
      <div class="card-body">
        <div class="text-center">
          <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" style="width: 25rem;"
               src="img/undraw_posting_photo.svg" alt="...">
        </div>
        <p>Add some quality, svg illustrations to your project courtesy of <a
                target="_blank" rel="nofollow" href="https://undraw.co/">unDraw</a>, a
          constantly updated collection of beautiful svg images that you can use
          completely free and without attribution!</p>
        <a target="_blank" rel="nofollow" href="https://undraw.co/">Browse Illustrations on
          unDraw &rarr;</a>
      </div>
    </div>

    <!-- Approach -->
    <div class="card shadow mb-4">
      <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary">Development Approach</h6>
      </div>
      <div class="card-body">
        <p>SB Admin 2 makes extensive use of Bootstrap 4 utility classes in order to reduce
          CSS bloat and poor page performance. Custom CSS classes are used to create
          custom components and custom utility classes.</p>
        <p class="mb-0">Before working with this theme, you should become familiar with the
          Bootstrap framework, especially the utility classes.</p>
      </div>
    </div>

  </div>
</div>