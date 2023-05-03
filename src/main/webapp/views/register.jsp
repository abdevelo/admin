<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
    // register.jsp
    let register_form = {
        init:function (){
            $('#register_btn').addClass('disabled');

            $('#register_btn').click(function (){
                let txt_id = $(this).val();
                $.ajax({ // id를 서버에 보내기
                    type:"post",
                    url :'/checkid',
                    data:{'id':txt_id}, //id라는 이름으로 id 값을 전송하겠다
                    success:function (result){
                        if(result == 0){
                            register_form.send();
                        }else{
                            alert("id를 확인하세요.");
                        }
                    }
                });

            });

            $('#lev').keyup(function (){
                let id = $('#id').val();
                let pwd = $('#pwd').val();
                let lev = $('#lev').val();
                if( id != '' && pwd != '' && lev !=''){
                    $('#register_btn').removeClass('disabled');
                }
            });
            $('#id').keyup(function (){
                let txt_id = $(this).val(); // input태그(명:id)에 입력된 값
                if(txt_id.length <= 3){
                    return;
                } // 그 값의 길이가 3자리가 안되면 여기서 끝
                $.ajax({ // id를 서버에 보내기
                    url :'/checkid',
                    data:{'id':txt_id}, //id라는 이름으로 id 값을 전송하겠다
                    success:function (result){
                        if(result == 0){
                            $('#check_id').text('사용가능합니다.');
                            $('#pwd').focus();
                        }else{
                            $('#check_id').text('사용불가능합니다.');
                        }
                    }
                });
            });
        },
        send:function (){
            let txt_id = $('#id').val();
            let pwd = $('#pwd').val();
            let lev = $('#lev').val();
            if(id.length <=3){
                $('#check_id').text('4자리 이상이어야 합니다.'); // 숨겨진 span 영역에 뿌리는 문구
                $('#pwd').focus();
                return;
            }
            if( pwd == ''){
                $('#pwd').focus();
                return;
            }
            if( lev == ''){
                $('#lev').focus();
                return;
            }
            $('#register_form').attr({
                'action':'/registerimpl', //action하면 하게될 서버의 작업
                'method':'post'
            });
            $('#register_form').submit();
        }
    };

    $(function (){
        register_form.init();
    });
</script>


<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">LOGIN PAGE</h1>

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">LOGIN PAGE</h6>
        </div>
        <div class="card-body">
            <%--      아래 컨테이너부터 --%>
            <div class="container">
                <div class="col-sm-6  text-left ">
                    <h1>Register Page</h1>
                    <form id="register_form" class="form-horizontal well">
                        <div class="form-group">
                            <label class="control-label col-sm-10" for="id">ID:</label>
                            <div class="col-sm-10">
                                <input type="text" name="id" class="form-control" id="id" placeholder="Enter id">
                            </div>
                            <div class="col-sm-10">
                                <span id="check_id" class="bg-danger"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-10" for="pwd">Password:</label>
                            <div class="col-sm-10">
                                <input type="password" name="pwd" class="form-control" id="pwd" placeholder="Enter password">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-10" for="lev">LEVEL:</label>
                            <div class="col-sm-10">
                                <input type="text" name="lev" class="form-control" id="lev" placeholder="Enter level">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <button type="button" id="register_btn" name="login_btn" class="btn btn-primary">REGISTER</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <%--      추가자리 끝--%>

        </div>
    </div>
</div>
