<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <!-- 下拉框 -->
    <link rel="stylesheet" href="static/ace/css/chosen.css"/>
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/index/top.jsp" %>
    <%--layui--%>
    <link rel="stylesheet" href="static/front/layui/css/layui.css"/>
    <script src="static/front/layui/layui.js"></script>
</head>

<body class="no-skin">

<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
    <!-- /section:basics/sidebar -->
    <div class="main-content">
        <div class="main-content-inner">
            <div class="page-content">
                <div class="row">
                    <div class="col-xs-12">

                        <!-- 检索  -->
                        <form action="sys_config/list.do" method="post" name="Form" id="Form">
                            <c:if test="${QX.cha == 1 }">
                                <table class="table table-striped table-bordered table-hover">
                                    <th style="width: 10%; text-align: left; padding-top: 13px;">基础设置：</th>

                                    <tr>
                                        <td>六合彩名称：
                                            <input class="inspect" type="text" name="SYS_NAME" id="SYS_NAME"
                                                   value="${pd.SYS_NAME}" placeholder="请输入六合彩名称" style="width: 12%;"/>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>公司简介：
											<label for="COMPAN_PROFILE"></label><textarea class="inspect" type="text" name="COMPAN_PROFILE"
																						  placeholder="请输入公司简介"
																						  id="COMPAN_PROFILE"
																						  style="width: 30%; height: 50px;">
                                                    ${pd.COMPAN_PROFILE}
                                            </textarea>
                                        </td>
                                    </tr>
                                </table>
                            </c:if>

                            <table class="table table-striped table-bordered table-hover">
                                <c:if test="${QX.cha == 0 }">
                                    <tr>
                                        <td colspan="100" class="center">您无权查看</td>
                                    </tr>
                                </c:if>
                            </table>

                            <div class="page-header position-relative">
                                <table style="width:100%;">
                                    <tr>
                                        <td style="vertical-align:top;" class="center" colspan="6">
                                            <c:if test="${QX.edit == 1 }">
                                                <a class="btn btn-mini btn-primary" onclick="edit();">保存</a>
                                                <a class="btn btn-mini btn-success" onclick="formReset()">取消</a>
                                                <c:if test="${QX.del == 1 }">
                                                    <a class="btn btn-mini btn-danger" onclick="wipeData();">清空数据</a>
                                                </c:if>
                                            </c:if>

                                        </td>
                                    </tr>
                                </table>
                            </div>

                        </form>

                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.row -->
            </div>
            <!-- /.page-content -->
        </div>
    </div>
    <!-- /.main-content -->

    <!-- 返回顶部 -->
    <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
        <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
    </a>

</div>
<!-- /.main-container -->

<!-- basic scripts -->
<!-- 页面底部js¨ -->
<%@ include file="../../system/index/foot.jsp" %>
<!-- 删除时确认窗口 -->
<script src="static/ace/js/bootbox.js"></script>
<!-- ace scripts -->
<script src="static/ace/js/ace/ace.js"></script>
<!-- 下拉框 -->
<script src="static/ace/js/chosen.jquery.js"></script>
<!-- 日期框 -->
<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<script type="text/javascript">
    $(top.hangge());//关闭加载状态
    //检索
    function tosearch() {
        top.jzts();
        $("#Form").submit();
    }

    layui.use('laydate', function () {
        var laydate = layui.laydate;

        //执行一个laydate实例
        //时间范围
        laydate.render({
            elem: '#CASH_TIME'
            , type: 'time'
            , range: true
        });

        //日期时间
        laydate.render({
            elem: '#TASK_TIME'
            , type: 'time'
        });
    });

    //清空数据
    function wipeData() {
        bootbox.confirm("确定要清空数据吗?", function (r) {
            if (r) {
                top.jzts();
                var url = "sys_config/wipeAllData.do";
                $.get(url, function (data) {
                    if (data === "success") {
                        alert("清空数据成功！")
                        location.reload(); //刷新页面
                    }
                });
            }
        });
    }

    //复位
    function formReset() {
        document.getElementById("Form").reset();
    }

    //判断不能为空
    function check() {  //Form是表单的ID
        for (var i = 0; i < document.Form.getElementsByClassName("inspect").length - 1; i++) {
            var r = document.getElementsByClassName("inspect")[i].value.trim();
            if ('' == r) {
                $(document.getElementsByClassName("inspect")[i]).tips({
                    side: 1,
                    msg: '不能为空',
                    bg: '#AE81FF',
                    time: 2
                });
                document.getElementsByClassName("inspect")[i].focus();
                return false;
            }
        }

        return true;
    }

    // 只能输入 0 或者 1
    function isNum(num) {
        //RegExp 对象表示正则表达式，它是对字符串执行模式匹配的强大工具。
        return (new RegExp(/^[01]$/).test(num));
    }

    //获取from表单数据并传到后台
    function edit() {
        //取表单值
        finalRes = $("#Form").serializeArray().reduce(function (r, item) {
            r[item.name] = item.value;
            return r;
        }, {});
        //打印控制台查看数据是否符合
        console.log(finalRes)
        //通过ajax传到后台
        if (check()) {
            $.ajax({
                url: "sys_config/edit.do",
                type: "post",
                data: finalRes,
                timeout: 10000, //超时时间设置为10秒
                success: function (data) { //回调函数
                    if (data === "success") {
                        alert("参数更改成功~");
                        location.reload(); //刷新页面
                    } else {
                        alert("参数更改失败~");
                        location.reload(); //刷新页面
                    }
                }
            });
        }
    }

</script>


</body>
</html>