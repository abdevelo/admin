<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    #itemimg{
        width:250px;
    }
</style>
<script>
    let item_detail = {
        init:function (){
            $('#register_btn').click(function (){
                item_detail.send();
            })
            $('#delete_btn').click(function (){
                var c = confirm("삭제 하시겠습니까?");
                if ( c == true ){
                    location.href='/item/deleteimpl?id=${gitem.id}';
                };

            });
        },
        send: function (){
            // let id = $('#id').val();
            // let pwd = $('#pwd').val();
            // let name = $('#name').val();
            $('#register_form').attr({
                method:'post',
                action: '/item/updateimpl',
                enctype: 'multipart/form-data'
            });
            $('#register_form').submit();
        },
    };

    // let item_delete = {
    //     init:function (){
    //         $('#delete_btn').click(function (){
    //             var c = confirm("삭제하시겠습니까?");
    //             if( c == true ){
    //                 item_delete.send();
    //             }
    //         })
    //
    //     },
    //     send:function (){
    //         $('#register_btn').attr({
    //             action:'/item/deleteimpl',
    //             method:'post'
    //         });
    //         $('#register_btn').submit();
    //     }
    // };

    $(function (){
        item_detail.init();
        // item_delete.init();
    });
</script>
<div class="container-fluid">
    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800"></h1>
    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Item Detail ${gitem.id}</h6>
        </div>
        <div class="card-body">
            <div class="container">
                <form id="register_form" class="form-horizontal well">

                    <input type="hidden" name="id" value="${gitem.id}">
                    <input type="hidden" name="imgname" value="${gitem.imgname}">

<%--                    hidden 인풋 --%>

<%--                    (1) 이미지 선택 안한 케이스 : 화면에서 name, price 선택함--%>
<%--                        -> 히든 값인 id, imgname 포함해서 4개의 값 전송--%>
<%--                    (2) 이미지 선택 한 케이스 : name,price,img 있음--%>
<%--                        --> 새롭게 입력된 img 이름을 끄집어내서 imgname에 덮어씌우기 (교체)--%>
<%--                        --> 후에 item 을 update--%>


                    <div class="form-group">
                        <div class="col-sm-10">
                            <img id="itemimg" src="/img/${gitem.imgname}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="name">NAME :</label>
                        <div class="col-sm-10">
                            <input type="text" name="name" class="form-control" id="name" value="${gitem.name}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="price">PRICE :</label>
                        <div class="col-sm-10">
                            <input type="number" name="price" class="form-control" id="price" value="${gitem.price}">
                        </div>
                        <div class="col-sm-10">
                            <span id="check_id" class="bg-danger"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="img">IMG :</label>
                        <div class="col-sm-10">
                            <input type="file" name="img" class="form-control" id="img" placeholder="Upload img">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button id="register_btn" type="button" class="btn btn-primary">Update</button>
                            <button id="delete_btn" type="button" class="btn btn-danger">Delete</button>
                        </div>
                    </div>
                </form>            </div>
        </div>
    </div>
</div>
