<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<html>
<base href="<%=basePath%>">
<!-- 公共文件 -->
<%@ include file="../front/public/unit.jsp" %>
<head>
    <title>图表资料</title>
</head>

<style>
    .about-container img {
        width: 100%;
        text-align: center;
    }
    .tab{flex-wrap: wrap;height: auto}.tab .tab-item{width: 33.33%;height: .4rem;}
    .tab .tab-item{
        background-color: #0068b7 !important;
        border: 1px solid #fff;
    }
</style>

<script>
    // eslint-disable-next-line
    !function (e, t) {
        var n = t.documentElement,
            d = e.devicePixelRatio || 1;

        function i() {
            var e = n.clientWidth / 3.75;
            n.style.fontSize = e + "px"
        }

        if (function e() {
            t.body ? t.body.style.fontSize = "16px" : t.addEventListener("DOMContentLoaded", e)
        }(), i(), e.addEventListener("resize", i), e.addEventListener("pageshow", function (e) {
            e.persisted && i()
        }), 2 <= d) {
            var o = t.createElement("body"),
                a = t.createElement("div");
            a.style.border = ".5px solid transparent", o.appendChild(a), n.appendChild(o), 1 === a.offsetHeight && n.classList.add(
                "hairlines"), n.removeChild(o)
        }
    }(window, document)
</script>
<body>
<div class="home">
    <!-- logo -->
    <div class="head">
        <div class="head-nav">
            <div class="head-logo"><img src="static/front/images/logo.png" alt=""></div>
        </div>
    </div>
    <!-- 主体 -->
    <div class="about-us" >

        <div class="bar"></div>
        <div flex="" class="tab" id="titleDataList">
            <%-- 标题列表 --%>
            <%--<div flex="box:mean" class="tab">
                <div class="tab-item tab-active">
                    ${dataList[0].TITLE}
                </div>
                <c:forEach var="var" items="${dataList}" begin="1" step="1">
                    <div class="tab-item">
                            ${var.TITLE}
                    </div>
                </c:forEach>
            </div>--%>
        </div>

        <div class="bar"></div>

        <!-- 内容 -->
        <div id="dataList">
            <%--<div class="about-container xs">
                ${dataList[0].CONTENT}
            </div>
            <c:forEach var="var" items="${dataList}" begin="1" step="1">
                <div class="about-container xs" style="display: none;">
                        ${var.CONTENT}
                </div>
            </c:forEach>--%>
        </div>
    </div>
</div>
<!-- 底部导航 -->
<%@ include file="../front/footer/footer.jsp" %>


</body>

<%-- 渲染页面 --%>
<script>


    $(function () {
        var url = "release/chartInfo";
        $.get(url, function (result) {
            if (result.success) {
                setTitleDataList(result.data.dataList);
                setDataList(result.data.dataList);
            }
        })
    });

    /*设置标题数据列表*/
    function setTitleDataList(data) {
        var listDom = document.getElementById("titleDataList");

        var str = '';

        // 渲染第一个
        str += "<div class=\"tab-item tab-active\">\n" +
            "     " + data[0].TITLE + "\n" +
            "   </div>";
        // 渲染剩下的
        for (var i = 1; i < data.length; i++) {
            var pd = data[i];
            str += "<div class=\"tab-item\">\n" +
                "     " + pd.TITLE + "\n" +
                "  </div>";
        }
        // 创建新节点并追加到元素上
        var liDom = document.createElement("div");
        liDom.setAttribute("flex", "box:mean");
        liDom.setAttribute("class", "tab");
        liDom.innerHTML = str;
        listDom.appendChild(liDom);
    }

    /*设置内容数据列表*/
    function setDataList(data) {
        var listDom = document.getElementById("dataList");

        var str = '';

        // 渲染第一个
        str += " <div class=\"about-container xs\">\n" +
            "       " + data[0].CONTENT + "" +
            "    </div>";
        // 渲染剩下的
        for (var i = 1; i < data.length; i++) {
            var pd = data[i];

            str += "<div class=\"about-container xs\" style=\"display: none;\">\n" +
                "      " + pd.CONTENT + " " +
                "   </div>";

        }
        listDom.innerHTML = str;
    }

</script>

</html>
