<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    #mimg{
        width:200px;
    }
    #map{
        width:400px;
        height:400px;
        border:2px solid red;
    }
</style>

<script>
    let map01 = {
        map : null,
        init:function (){ //초기화가되면(화면이 준비되면) 지도를 출력
            var mapContainer = document.querySelector('#map');
            var mapOption = {
                center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                level: 3 // 지도의 확대 레벨
            };
            map = new kakao.maps.Map(mapContainer, mapOption);

            // map controller
            var mapTypeControl = new kakao.maps.MapTypeControl();
            map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
            var zoomControl = new kakao.maps.ZoomControl();
            map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);


            //map marker
            var markerPosition  = new kakao.maps.LatLng(33.450701, 126.570667);
            var marker = new kakao.maps.Marker({
                position: markerPosition
            });
            marker.setMap(map);


            // marker + event window
            var iwContent = '<img src="/img/a.jpg" style="width:80px"><div style="padding:5px;">Hello Pants!</div>';
            var infowindow = new kakao.maps.InfoWindow({
                content : iwContent
            });
            kakao.maps.event.addListener(marker, 'mouseover', function() {
                infowindow.open(map, marker);
            });
            kakao.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
            });
            kakao.maps.event.addListener(marker, 'click', function() {
                location.href='http://www.nate.com';
            });
        }
    };
    $(function(){
        map01.init();
    });
</script>


<script>
    let marker_detailmap = {
        map : null,
        init:function (){ //초기화가되면(화면이 준비되면) 지도를 출력
            var mapContainer = document.querySelector('#map');
            var mapOption = {
                center: new kakao.maps.LatLng(${gmarker.lat}, ${gmarker.lng}), // 지도의 중심좌표
                level: 3 // 지도의 확대 레벨
            };
            map = new kakao.maps.Map(mapContainer, mapOption);

            // map controller
            var mapTypeControl = new kakao.maps.MapTypeControl();
            map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
            var zoomControl = new kakao.maps.ZoomControl();
            map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);


            //map marker
            var markerPosition  = new kakao.maps.LatLng(${gmarker.lat}, ${gmarker.lng});
            var marker = new kakao.maps.Marker({
                position: markerPosition
            });
            marker.setMap(map);

            // marker + event window
            var iwContent = '<img src="/img/${gmarker.img}" style="width:80px"><div style="padding:5px;">Hello Pants!</div>';
            var infowindow = new kakao.maps.InfoWindow({
                content : iwContent
            });
            kakao.maps.event.addListener(marker, 'mouseover', function() {
                infowindow.open(map, marker);
            });
            kakao.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
            });
            kakao.maps.event.addListener(marker, 'click', function() {
                location.href="${gmarker.target}";
            });
        }
    };
    let marker_detail = {
        init:function (){
            $('#updated_btn').click(function (){
                marker_detail.send();
            })
        },
        send: function (){
            $('#register_form').attr({
                method:'post',
                action: '/marker/updateimpl',
                enctype:'multipart/form-data'
            });
            $('#register_form').submit();
        }
    };
    $(function (){
        marker_detail.init();
        marker_detailmap.init();
    });
</script>
<div class="container-fluid">
    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800"></h1>
    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Marker Detail : ${gmarker.id}</h6>
        </div>
        <div class="card-body">
            <div class="container">
                <form id="register_form" class="form-horizontal well">

                    <input type="hidden" name="id" value="${gmarker.id}">
                    <input type="hidden" name="img" value="${gmarker.img}">

                    <div class="form-group">
                        <div class="col-sm-10">
                            <img src="/img/${gmarker.img}" id="mimg">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="title">Title :</label>
                        <div class="col-sm-10">
                            <input type="text" name="title" class="form-control" id="title" value="${gmarker.title}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="target">Target :</label>
                        <div class="col-sm-10">
                            <input type="text" name="target" class="form-control" id="target" value="${gmarker.target}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="lat">LAT:</label>
                        <div class="col-sm-10">
                            <input type="text" name="lat" class="form-control" id="lat" value="${gmarker.lat}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="lng">LNG:</label>
                        <div class="col-sm-10">
                            <input type="text" name="lng" class="form-control" id="lng" value="${gmarker.lng}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="imgF">IMG:</label>
                        <div class="col-sm-10">
                            <input type="file" name="imgF" class="form-control" id="imgF" placeholder="Upload img">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="loc">LOC:</label>
                        <div class="col-sm-10">
                            <input type="text" name="loc" class="form-control" id="loc" value="${gmarker.loc}">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button id="updated_btn" type="button" class="btn btn-primary">UPDATE</button>
                            <button id="deleted_btn" type="button" class="btn btn-primary">DELETE</button>
                        </div>
                    </div>
                </form>

                <div class="card-body">
                    <div class="row">
                        <div class="col-sm-10" id="map">
<%--                            지도를 뿌릴 곳, 지도의 width, height 필수로 잡아두기 --%>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
