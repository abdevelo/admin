<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
    let cust_detail = {
        init:function (){
            $('#update_btn').click(function (){
                cust_detail.send();
            })
        },
        send: function (){
            $('#register_form').attr({
                action:'/cust/updateimpl',
                method:'post'
            });
            $('#register_form').submit();
        }
    };

    let cust_delete = {
        init:function () {
            $('#delete_btn').click(function () {
                var c = confirm("삭제 하시겠습니까?");
                if (c == true) {
                    cust_delete.send();
                }
            })
        },
        send: function () {
            $('#register_form').attr({
                action:'/cust/deleteimpl',
                method:'post'
            });
            $('#register_form').submit();
        }
    };
    $(function (){
        cust_detail.init();
        cust_delete.init();
    })
</script>
<div class="container-fluid">
    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800"></h1>
    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Cust Add</h6>
        </div>
        <div class="card-body">
            <div class="container">
                <form id="register_form" name="register_form" class="form-horizontal well">
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="id">ID:</label>
                        <div class="col-sm-10">
                            <input type="text" name="id" class="form-control" id="id" value="${cust.id}" readonly>
                        </div>
                        <div class="col-sm-10">
                            <span id="check_id" class="bg-danger"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="pwd">Password:</label>
                        <div class="col-sm-10">
                            <input type="password" name="pwd" class="form-control" id="pwd" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="name">NAME:</label>
                        <div class="col-sm-10">
                            <input type="text" name="name" class="form-control" id="name" value="${cust.name}" >
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button id="update_btn" type="button" class="btn btn-primary">Update</button>
                            <button id="delete_btn" type="button" class="btn btn-primary">Delete</button>
                        </div>
                    </div>
                </form>            </div>
        </div>
    </div>
</div>
