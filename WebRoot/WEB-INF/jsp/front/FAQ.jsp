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
    <title>帮助中心</title>
</head>
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
    <!--  -->
    <div class="faq">
        <div class="bar"></div>
        <div flex="" class="tab">
            <div flex="box:mean" class="tab">
                <div class="tab-item tab-active">
                    FAQ
                </div>
                <div class="tab-item">
                    技術支持
                </div>
            </div>
        </div>
        <div class="bar"></div>
        <!-- FAQ -->
        <div class="xs">
            <div class="faq-info">
                <h3>FAQ</h3>
            </div>

            <c:forEach var="var" items="${data}">
                <div class="accordion">
                    <div flex="main:justify cross:center" class="accordion-title">
                        <p>${var.TITLE}</p><i class="icon iconfont icon-you-"></i>
                    </div>
                    <div class="accordion-content">
                            ${var.CONTENT}
                    </div>
                </div>
            </c:forEach>
        </div>
        <!-- 技術支持 -->
        <div class="xs" style="display: none;">
            <div class="technical-support">
                <h3>${technical.TITLE}</h3>
                ${technical.CONTENT}
            </div>
        </div>


    </div>

</div>
<!-- 底部导航 -->
<%@ include file="../front/footer/footer.jsp" %>

<script type="text/javascript">

</script>
</body>
</html>
