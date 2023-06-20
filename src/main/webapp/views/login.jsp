<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>

    let login_form = {
        init:function (){
            $('#login_btn').click(function (){
                login_form.send();
            });
        },
        send:function (){
            $('#login_form').attr({
                'action':'/loginimpl', //form의 정보를 server의 application에 전달하세요
                'method':'get'
            });
            $('#login_form').submit();
        }
    };
    $(function (){
        login_form.init(); // form정보를 서버에 전송
    });
</script>


<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">LiveCharts</h1>

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">LOGIN PAGE</h6>
        </div>
        <div class="card-body">
            <%--      아래 컨테이너부터 --%>
            <div class="container">
                <div class="row content">
                    <div class="col-sm-8 alert alert-danger">
                        <strong>Danger!</strong> Keep you safe from the possibility of hacking your keyboard
                    </div>

                    <hr>
                    <form id="login_form" class="form-horizontal well col-sm-8">
                        <input type="hidden" name="redirectURL" value="${redirectURL}">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                            <input id="id" type="text" class="form-control" name="id" placeholder="id">
                        </div>
                        <br/>
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                            <input id="password" type="password" class="form-control" name="pwd" placeholder="Password">
                        </div>

                        <hr>

                        <button type="button" id="login_btn" name="login_btn" class="btn btn-primary">LOGIN</button>
                        <button type="button" class="btn btn-danger">JOIN</button> <br/><br/>
                        <button type="button" class="btn btn-success">Forget?</button>

                    </form>

                </div>
            </div>
            <%--      추가자리 끝--%>

        </div>
    </div>
</div>
