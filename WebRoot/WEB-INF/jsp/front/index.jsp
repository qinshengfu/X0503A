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
    <title>首页</title>
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
<div class="content">
    <div class="home">
        <!-- logo -->
        <div class="head">
            <div class="head-nav">
                <div class="head-logo"><img src="static/front/images/logo.png" alt=""></div>
            </div>
        </div>
        <!-- 轮播 -->
        <div class="swiper-container">
            <div class="swiper-wrapper">
                <c:forEach items="${chart}" var="var">
                    <div class="swiper-slide"><img src="${var.PIC_PATH}"></div>
                </c:forEach>
            </div>
            <div class="swiper-pagination"></div>
        </div>
        <!-- 澳门六合彩 -->
        <div class="content">
            <div class="lottery-list">
                <div flex="cross:center main:justify" class="title s-1">
                    <div flex="main:justify" class="left"><b class="name">${par.SYS_NAME}</b>
                        <p class="wrap-issue">第<b class="issue">${latest.SCENE}</b>期</p>
                    </div>
                    <div class="line"></div>
                    <div class="right">
                        <p class="text">下期截止時間</p>
                        <p class="time">${latest.NEXT_PERIOD}</p>
                    </div>
                </div>
                <div flex="dir:top main:center" class="count-down">
                    <!---->
                    <div flex="dir:top" class="inner-wrap">
                        <%-- 倒计时 --%>
                        <div id="countDown" flex="cross:center" flex-box="0" class="lottery-time">

                        </div>

                        <div flex="main:justify" class="option-btn">
                            <div flex="" class="_t">
                                <div flex="main:center cross:center" class="live-btn">
                                    <span>開獎驗證</span>
                                    <!-- 開獎驗證 提示弹窗 -->
                                    <div class="lottery-certifly" style="display: none;">
                                        <div class="content">
                                            <div flex="cross:center" class="title"><img src="static/front/images/tc.png"
                                                                                        alt="">
                                                <h3>即時開獎驗證</h3>
                                            </div>
                                            <div class="content-txt">
                                                <p class="txt">開獎現場直播，與中央電視台1套同步，開獎過程100%公開公正！</p>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 開獎驗證 提示弹窗-->
                                </div>
                                <%--<div flex="main:center cross:center" class="verify-btn"><span>直播</span></div>--%>
                            </div>
                            <div class="history-btn"><span id="openRecord">历史记录查询</span><i
                                    class="icon iconfont icon-you-"></i></div>
                        </div>
                    </div>
                </div>
                <!-- 开奖号码 -->
                <div class="current-info">
                    <div class="current-info-inner">
                        <div flex="cross:center" class="open-num lhc" id="openBonus">


                        </div>
                    </div>
                </div>

                <div flex="main:center cross:center" class="last-issue"><span>查看近五期</span>
                    <i class="icon iconfont icon-you-"></i>
                </div>
                <%-- 最近五期数据 --%>
                <ul class="last-issue-list" id="dataList" style="display: none;">

                </ul>
            </div>

            <%-- 公司简介 --%>
            <div class="lottery-list gsjj">
                ${par.COMPAN_PROFILE}
            </div>
        </div>
    </div>

</div>

<!-- 底部导航 -->
<%@ include file="../front/footer/footer.jsp" %>
<!--底部导航-->

<script>

    // 点击历史记录
    $("#openRecord").click(function () {
        window.location.assign("release/to_news")
    });

    // 倒计时 返回超时的分钟数
    function endofCountdown() {
        //结束时间
        var endDate = new Date("${latest.NEXT_PERIOD}");
        //当前时间
        var nowDate = new Date();
        //相差的总秒数
        var totalSeconds = parseInt((nowDate - endDate) / 1000);
        // 分钟数
        return Math.floor(totalSeconds / 60);

    }

    // 客户端检查是否结束
    function isEnd(status) {
        var minutes = endofCountdown();
        // 倒计时超过两分钟 直接把最新一期数据显示出来
        if (minutes >= 2) {
            // 服务端验证是否结束
            $.get("release/checkIsOver", function (result) {
                if (result.success) {
                    // 直接显示最新一期
                    showLatest(result.data);
                    return false;
                } else {
                    setTimeout(function () {
                        isEnd(status)
                    }, 1000)
                }
            });
            return;
        }
        // 超过结束时间 并且 在两分钟内执行开奖动画渲染
        if (minutes > -1 && minutes <= 2) {
            status = false;
            // 服务端验证是否结束
            $.get("release/checkIsOver", function (result) {
                if (result.success) {
                    // 动态创建开奖号码
                    setOpenBonusNumber(result.data);
                    return false;
                } else {
                    setTimeout(function () {
                        isEnd(status)
                    }, 1000)
                }
            });
        }
        if (status) {
            setTimeout(function () {
                isEnd(status)
            }, 1000)
        }

    }

    // 显示最新数据
    function showLatest(data) {
        deleteLiContent();
        // 获取父节点
        var div_array = document.getElementById("openBonus");
        // 创建Ul节点
        var ulDom = document.createElement("ul");
        // 设置节点属性
        ulDom.setAttribute("flex", "");
        ulDom.setAttribute("id", "open-num-list");
        ulDom.setAttribute("class", "open-num-list");
        // 把新创建的ul节点 追加到父节点上
        div_array.appendChild(ulDom);

        // 拼接前六个号码
        let i = 1;
        while (i <= 6) {
            var colorKey = "COLOR" + i;
            var zodiacKey = "ZODIAC" + i;
            var num = "NUM" + i;
            // 创建li节点
            var liDom = document.createElement("li");
            liDom.setAttribute("flex", "dir:top");
            liDom.setAttribute("class", "open-ball");
            // 定义颜色类名称
            var classColor = checkColor(data[colorKey]);
            var str = "";
            str += "<span flex=\"main:center cross:center\" class=\"number " + classColor + "\">\n" +
                "      " + data[num] + " \n" +
                "   </span>\n" +
                "   <b class=\"sheng-xiao\"> " + data[zodiacKey] + " </b>";

            liDom.innerHTML = str;
            // 追加到ul 节点上
            ulDom.appendChild(liDom);
            i++;
        }

        // 定义颜色类名称
        classColor = checkColor(data.COLOR7);

        // 创建 “+号” 的li节点
        var liDomPlus = document.createElement("li");
        liDomPlus.setAttribute("class", "symbol");
        liDomPlus.innerText = "+";
        // 追加到ul 节点上
        ulDom.appendChild(liDomPlus);

        str = "";
        str += "<span flex=\"main:center cross:center\" class=\"number " + classColor + "\">\n" +
            "      " + data.NUM7 + " \n" +
            "   </span>\n" +
            "   <b class=\"sheng-xiao\"> " + data.ZODIAC7 + " </b>";

        // 创建li节点
        liDom = document.createElement("li");
        liDom.setAttribute("flex", "dir:top");
        liDom.setAttribute("class", "open-ball");
        liDom.innerHTML = str;
        // 追加到ul 节点上
        ulDom.appendChild(liDom);
    }

    // 显示上一期数据
    function showLast() {
        var data =  ${last};

        // 获取父节点
        var div_array = document.getElementById("openBonus");
        // 创建Ul节点
        var ulDom = document.createElement("ul");
        // 设置节点属性
        ulDom.setAttribute("flex", "");
        ulDom.setAttribute("id", "open-num-list");
        ulDom.setAttribute("class", "open-num-list");
        // 把新创建的ul节点 追加到父节点上
        div_array.appendChild(ulDom);

        // 拼接前六个号码
        let i = 1;
        while (i <= 6) {
            var colorKey = "COLOR" + i;
            var zodiacKey = "ZODIAC" + i;
            var num = "NUM" + i;
            // 创建li节点
            var liDom = document.createElement("li");
            liDom.setAttribute("flex", "dir:top");
            liDom.setAttribute("class", "open-ball");
            // 定义颜色类名称
            var classColor = checkColor(data[colorKey]);
            var str = "";
            str += "<span flex=\"main:center cross:center\" class=\"number " + classColor + "\">\n" +
                "      " + data[num] + " \n" +
                "   </span>\n" +
                "   <b class=\"sheng-xiao\"> " + data[zodiacKey] + " </b>";

            liDom.innerHTML = str;
            // 追加到ul 节点上
            ulDom.appendChild(liDom);
            i++;
        }

        // 定义颜色类名称
        classColor = checkColor(data.COLOR7);

        // 创建 “+号” 的li节点
        var liDomPlus = document.createElement("li");
        liDomPlus.setAttribute("class", "symbol");
        liDomPlus.innerText = "+";
        // 追加到ul 节点上
        ulDom.appendChild(liDomPlus);

        str = "";
        str += "<span flex=\"main:center cross:center\" class=\"number " + classColor + "\">\n" +
            "      " + data.NUM7 + " \n" +
            "   </span>\n" +
            "   <b class=\"sheng-xiao\"> " + data.ZODIAC7 + " </b>";

        // 创建li节点
        liDom = document.createElement("li");
        liDom.setAttribute("flex", "dir:top");
        liDom.setAttribute("class", "open-ball");
        liDom.innerHTML = str;
        // 追加到ul 节点上
        ulDom.appendChild(liDom);
    }

    // 删除上一期节点
    function deleteLiContent() {
        var div_array = document.getElementById("open-num-list");
        // 删除全部节点
        div_array.remove();
    }

    // 文字转语音
    function textToSpeech(text) {
        // 百度文字转语音开放API
        var url = "http://tts.baidu.com/text2audio?lan=zh&ie=UTF-8";
        // 播放语速 可以是1-9的数字，数字越大，语速越快。
        var rate = 4;
		// 音调，取值0-15，默认为5中语调
		var pit = 6;
		// 发音人选择, 0为普通女声，1为普通男生，3为情感合成-度逍遥，4为情感合成-度丫丫，默认为普通女声
		var per = 4;
        url += "&spd=" + rate + "&pit=" + pit + "&per=" + per;
		url += "&text=" + encodeURI(text);
        var audio = new Audio(url);
        audio.src = url;
        setTimeout(function () {
            audio.play();
        }, 350);
        return url;
    }

    // 渲染开奖号码
    function setOpenBonusNumber(data) {
        deleteLiContent();
        // 获取父节点
        var div_array = document.getElementById("openBonus");
        // 创建Ul节点
        var ulDom = document.createElement("ul");
        // 设置节点属性
        ulDom.setAttribute("flex", "");
        ulDom.setAttribute("id", "open-num-list");
        ulDom.setAttribute("class", "open-num-list");
        // 把新创建的ul节点 追加到父节点上
        div_array.appendChild(ulDom);
        let i = 1;
        firstSixNumber(i, data, ulDom)
    }

    // 拼接前六个号码 
    function firstSixNumber(i, data, ulDom) {
        if (i <= 6) {
            var colorKey = "COLOR" + i;
            var zodiacKey = "ZODIAC" + i;
            var num = "NUM" + i;
            // 定义颜色类名称
            var classColor = checkColor(data[colorKey]);

            // 创建li节点
            var liDom = document.createElement("li");
            liDom.setAttribute("flex", "dir:top");
            liDom.setAttribute("class", "open-ball");

            var str = "";
            str += "<span flex=\"main:center cross:center\" class=\"number " + classColor + "\">\n" +
                "         " + data[num] + "\n" +
                "   </span>\n" +
                "   <b class=\"sheng-xiao\">" + data[zodiacKey] + "</b>";

            liDom.innerHTML = str;
            // 追加到ul 节点上
            ulDom.appendChild(liDom);
            // 播放开奖号码
            var text = splicingText(i, data[num]);
            textToSpeech(text);
            i++;
        } else {
            // 拼接 特码
            specialCode(data, ulDom);
            return;
        }
        // 延迟5秒
        setTimeout(function () {
            firstSixNumber(i, data, ulDom)
        }, 5000)
    }

    // 拼接特码
    function specialCode(data, ulDom) {
        var colorKey = "COLOR7";
        var zodiacKey = "ZODIAC7" ;
        var num = "NUM7";
        // 定义颜色类名称
        var classColor = checkColor(data[colorKey]);

        // 创建 “+号” 的li节点
        var liDomPlus = document.createElement("li");
        liDomPlus.setAttribute("class", "symbol");
        liDomPlus.innerText = "+";
        // 追加到ul 节点上
        ulDom.appendChild(liDomPlus);

        // 延迟5秒
        setTimeout(function () {
            // 创建li节点
            var liDom = document.createElement("li");
            liDom.setAttribute("flex", "dir:top");
            liDom.setAttribute("class", "open-ball");

            var str = "";
            str += "<span flex=\"main:center cross:center\" class=\"number " + classColor + "\">\n" +
                "         " + data[num] + "\n" +
                "   </span>\n" +
                "   <b class=\"sheng-xiao\">" + data[zodiacKey] + "</b>";

            liDom.innerHTML = str;
            // 追加到ul 节点上
            ulDom.appendChild(liDom);
            // 播放开奖号码
            var text = splicingText(7, data[num]);
            textToSpeech(text);
        }, 5000);
    }

    // 拼接语音文本
    function splicingText(index, openCode) {
        if (index < 7) {
            return "第" + index + "个号码是" + openCode;
        } else {
            return "特码是" + openCode;
        }
    }

</script>

<script type="text/javascript">


    $(function () {
        // 显示上一期数据
        showLast();

        // 写入最近五期列表
        $.get("release/latestFiveIssues", function (result) {
            setListData(result.data.pd)
        }, "json");

        $("#autoClick").trigger("click");

        // 倒计时
        countDown("countDown", "${latest.NEXT_PERIOD}");

        isEnd(true)
    });


    /*设置列表数据*/
    function setListData(curPageData) {
        var listDom = document.getElementById("dataList");

        for (var i = 0; i < curPageData.length; i++) {
            var pd = curPageData[i];

            var str = '';
            // 渲染头部
            str += "     <div class=\"issue-text\">\n" +
                "           第<span class=\"issue\">" + pd.SCENE + "</span>期\n" +
                "       </div>" +
                "       <ul flex=\"\" class=\"history-list lhc\">";
            // 渲染开奖号码
            for (let i = 1; i <= 6; i++) {
                var colorKey = "COLOR" + i;
                var zodiacKey = "ZODIAC" + i;
                var num = "NUM" + i;
                // 定义颜色类名称
                var classColor = checkColor(pd[colorKey]);
                var content = "<li flex=\"dir:top main:center cross:center\">\n" +
                    "                                <span flex=\"main:center cross:center\" class=\"ball " + classColor + "\">\n" +
                    "                                    " + pd[num] + "\n" +
                    "                                </span>\n" +
                    "                                <b class=\"sheng-xiao\"> " + pd[zodiacKey] + " </b>\n" +
                    "                            </li>";
                str += content;
            }
            // 渲染特码及尾部
            str += "<li class=\"symbol\">+</li>\n" +
                "                            <li flex=\"dir:top main:center cross:center\">\n" +
                "                                <span flex=\"main:center cross:center\" class=\"ball " + checkColor(pd.COLOR7) + "\">\n" +
                "                                    " + pd.NUM7 + "\n" +
                "                                </span>\n" +
                "                                <b class=\"sheng-xiao\"> " + pd.ZODIAC7 + " </b>\n" +
                "                            </li>\n" +
                "                        </ul>";

            // 创建节点
            var liDom = document.createElement("li");
            // 设置节点属性
            liDom.setAttribute("flex", "cross:center main:justify");
            liDom.setAttribute("class", "list-item");
            liDom.innerHTML = str;
            listDom.appendChild(liDom);
        }
    }

    //轮播图
    var mySwiper = new Swiper('.swiper-container', {
        autoplay: true,
        pagination: {
            el: '.swiper-pagination',
        },
    });

    //开奖验证提示弹窗
    $('.live-btn span').click(function () {
        //取消事件冒泡
        event.stopPropagation();
        $(this).next().fadeIn()
    });

    $(document).click(function (event) {
        var _con = $('.lottery-certifly');   // 设置目标区域
        if (!_con.is(event.target) && _con.has(event.target).length === 0) { // Mark 1
            $('.lottery-certifly').fadeOut();          //淡出消失
        }
    });

    //查看显示隐藏
    $('.last-issue').click(function () {
        $(this).next('.last-issue-list').slideToggle();
        $(this).children('.icon').toggleClass('rotate') //图标旋转
    })
</script>
</body>
</html>
