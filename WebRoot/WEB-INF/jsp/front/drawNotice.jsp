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
    <title>开奖公告</title>
</head>
<style>
    .mescroll {
        height: 80%;
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
    <!-- 内容 -->
    <div class="draw-notice mescroll" id="mescroll">
        <div class="bar"></div>
        <div flex="box:mean" class="tab">
            <div class="tab-item tab-active">
                ${par.SYS_NAME}
            </div>
            <div class="tab-item">
                接口調用
            </div>
        </div>
        <div class="bar"></div>

        <!-- 澳门六合彩 -->
        <div class="xs">
            <%--最新公告--%>
            <div class="open-notice">
                ${news.CONTENT}
            </div>
            <!---->
            <div class="search-bar">
                <div flex="main:justify cross:center">
                    <div class="search-bar-title">
                        <p class="lottery-name">${par.SYS_NAME}</p>
                        <p class="title">開獎公告</p>
                    </div>
                </div>
            </div>
            <div class="current-info">
                <!---->
                <div class="lottery-info">
                    <div flex="" class="title">
                        <p><span>第</span><span class="issue">${last.SCENE}</span><span>期開獎號碼</span></p>
                    </div>

                    <div flex="cross:center" class="open-num lhc" id="openBonus">
                        <%--<ul flex="" class="open-num-list">
                            <c:forEach begin="1" end="6" step="1" varStatus="vs">
                                <c:set var="myIndex" value="NUM${vs.index}" scope="page"/>
                                <li flex="dir:top" class="open-ball">
                                    <c:if test="${last[myIndex].color == '红色'}">
                                            <span flex="main:center cross:center" class="number redBg">
                                                    ${last[myIndex].openCode}
                                            </span>
                                    </c:if>
                                    <c:if test="${last[myIndex].color == '绿色'}">
                                            <span flex="main:center cross:center" class="number greenBg">
                                                    ${last[myIndex].openCode}
                                            </span>
                                    </c:if>
                                    <c:if test="${last[myIndex].color == '蓝色'}">
                                            <span flex="main:center cross:center" class="number blueBg">
                                                    ${last[myIndex].openCode}
                                            </span>
                                    </c:if>
                                    <b class="sheng-xiao">${last[myIndex].zodiac}</b>
                                </li>
                            </c:forEach>

                            <li class="symbol">+</li>
                            <li flex="dir:top" class="open-ball">
                                <c:if test="${last.NUM7.color == '红色'}">
                                        <span flex="main:center cross:center" class="number redBg">
                                                ${last.NUM7.openCode}
                                        </span>
                                </c:if>
                                <c:if test="${last.NUM7.color == '绿色'}">
                                        <span flex="main:center cross:center" class="number greenBg">
                                                ${last.NUM7.openCode}
                                        </span>
                                </c:if>
                                <c:if test="${last.NUM7.color == '蓝色'}">
                                        <span flex="main:center cross:center" class="number blueBg">
                                                ${last.NUM7.openCode}
                                        </span>
                                </c:if>
                                <b class="sheng-xiao">${last.NUM7.zodiac}</b>
                            </li>
                        </ul>--%>
                    </div>

                </div>
                <!-- 下期截止時間 -->
                <div class="lottery-time">
                    <h3>
                        下期截止時間<span class="time">${latest.NEXT_PERIOD}</span></h3>
                    <%-- 倒计时 --%>
                    <div flex="" id="countDown" class="count-down">

                    </div>
                </div>
                <!-- 下期截止時間 -->
            </div>

            <!-- 往期开奖列表 -->

            <div id="dataList">

            </div>

            <!-- 往期开奖列表 -->
        </div>
        <!-- 澳门六合彩 -->
        <!-- ------------------------------ -->
        <!-- 接口调用 -->
        <div class="xs" style="display: none;">
            <div class="api">
                <h3 class="title">接口調用</h3>
                <div class="content">
                    <p>
                        本網站提供查詢接口，供查詢開獎數據。
                    </p>
                    <p>地址: http://api.bjjfnet.com/data/opencode/:id</p>
                    <p>請求方式：GET</p>
                    <p>返回類型：JSON</p>
                    <p class="s-title">調用示例</p>
                    <p>1. 台湾六合彩: http://api.bjjfnet.com/data/opencode/2032</p>                   
                    <p class="s-title">返回示例</p>
                    <p>查詢台湾六合彩開獎數據</p>
                    <p>{
                        "code": 0,
                        "message": "Success",
                        "data": [
                        {
                        "issue": "2020070",
                        "openCode": "19,16,06,49,21,07,11",
                        "openTime": "2020-03-10 21:34:30"
                        },
                        ...
                        ]
                        }
                    </p>
                    <p class="s-title">返回字段說明</p>
                    <p>1. code: 消息編碼, 0 代表成功;</p>
                    <p>2. message: 消息描述;</p>
                    <p>3. data: 具體開獎數據。issue:期號, openCode:開獎號碼, openTime:開獎時間。</p>
                </div>
            </div>
        </div>
        <!-- 接口调用 -->


    </div>
</div>
<!-- ------------------------------ -->

<!-- 底部导航 -->
<%@ include file="../front/footer/footer.jsp" %>

<script type="text/javascript">

    $(function() {
        showLast()

        // 倒计时
        countDown("countDown", "${latest.NEXT_PERIOD}");
    });

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

</script>
</body>

<%--下拉刷新，上拉加载--%>
<script type="text/javascript" charset="utf-8">

    $(function () {

        //是否为PC端,如果是scrollbar端,默认自定义滚动条
        var isPC = typeof window.orientation == 'undefined';

        //创建MeScroll对象,内部已默认开启下拉刷新,自动执行up.callback,刷新列表数据;
        var mescroll = new MeScroll("mescroll", {
            //下拉刷新的所有配置项
            down: {
                use: true, //是否初始化下拉刷新; 默认true
                auto: false, //是否在初始化完毕之后自动执行下拉回调callback; 默认true
                autoShowLoading: true, //如果在初始化完毕之后自动执行下拉回调,是否显示下拉刷新进度; 默认false. (需配置down的callback才生效)
                isLock: false, //是否锁定下拉,默认false;
                isBoth: false, //下拉刷新时,如果滑动到列表底部是否可以同时触发上拉加载;默认false,两者不可同时触发;
                callback: function (mescroll) {
                    //加载轮播数据
                    //loadSwiper();
                    //下拉刷新的回调,默认重置上拉加载列表为第一页(down的auto默认true,初始化Mescroll之后会自动执行到这里,而mescroll.resetUpScroll会触发up的callback)
                    mescroll.resetUpScroll();
                },
                offset: 60, //触发刷新的距离,默认80
                outOffsetRate: 0.2, //超过指定距离范围外时,改变下拉区域高度比例;值小于1且越接近0,越往下拉高度变化越小;
                bottomOffset: 20, //当手指touchmove位置在距离body底部20px范围内的时候结束上拉刷新,避免Webview嵌套导致touchend事件不执行
                minAngle: 45, //向下滑动最少偏移的角度,取值区间  [0,90];默认45度,即向下滑动的角度大于45度则触发下拉;而小于45度,将不触发下拉,避免与左右滑动的轮播等组件冲突;
                hardwareClass: "mescroll-hardware", //硬件加速样式;解决iOS下拉因隐藏进度条而闪屏的问题,参见mescroll.css
                mustToTop: false, // 是否滚动条必须在顶部,才可以下拉刷新.默认false. 当您发现下拉刷新会闪白屏时,设置true即可修复.
                warpId: null, //可配置下拉刷新的布局添加到指定id的div;默认不配置,默认添加到mescrollId
                warpClass: "mescroll-downwarp", //容器,装载布局内容,参见mescroll.css
                resetClass: "mescroll-downwarp-reset", //高度重置的动画,参见mescroll.css
                textInOffset: '下拉刷新', // 下拉的距离在offset范围内的提示文本
                textOutOffset: '释放更新', // 下拉的距离大于offset范围的提示文本
                textLoading: '加载中 ...', // 加载中的提示文本
                htmlContent: '<p class="downwarp-progress"></p><p class="downwarp-tip"></p>', // 布局内容
                inited: function (mescroll, downwarp) {
                    //初始化完毕的回调,可缓存dom
                    mescroll.downTipDom = downwarp.getElementsByClassName("downwarp-tip")[0];
                    mescroll.downProgressDom = downwarp.getElementsByClassName("downwarp-progress")[0];
                },
                inOffset: function (mescroll) {
                    //进入指定距离offset范围内那一刻的回调
                    if (mescroll.downTipDom) mescroll.downTipDom.innerHTML = mescroll.optDown.textInOffset;
                    if (mescroll.downProgressDom) mescroll.downProgressDom.classList.remove("mescroll-rotate");
                },
                outOffset: function (mescroll) {
                    //下拉超过指定距离offset那一刻的回调
                    if (mescroll.downTipDom) mescroll.downTipDom.innerHTML = mescroll.optDown.textOutOffset;
                },
                onMoving: function (mescroll, rate, downHight) {
                    //下拉过程中的回调,滑动过程一直在执行; rate下拉区域当前高度与指定距离offset的比值(inOffset: rate<1; outOffset: rate>=1); downHight当前下拉区域的高度
                    //console.log("向下-->移动时 --> mescroll.optDown.offset="+mescroll.optDown.offset+", downHight="+downHight+", rate="+rate);
                    if (mescroll.downProgressDom) {
                        var progress = 360 * rate;
                        mescroll.downProgressDom.style.webkitTransform = "rotate(" + progress + "deg)";
                        mescroll.downProgressDom.style.transform = "rotate(" + progress + "deg)";
                    }
                },
                beforeLoading: function (mescroll, downwarp) {
                    //准备触发下拉刷新的回调
                    return false; //如果要完全自定义下拉刷新,那么return true,此时将不再执行showLoading(),callback();
                },
                showLoading: function (mescroll) {
                    //触发下拉刷新的回调
                    if (mescroll.downTipDom) mescroll.downTipDom.innerHTML = mescroll.optDown.textLoading;
                    if (mescroll.downProgressDom) mescroll.downProgressDom.classList.add("mescroll-rotate");
                },
                afterLoading: function (mescroll) {
                    // 结束下拉之前的回调. 返回延时执行结束下拉的时间,默认0ms; 常用于结束下拉之前再显示另外一小段动画,才去结束下拉的场景, 参考案例【dotJump】
                    return 0
                }
            },
            //上拉加载的所有配置项
            up: {
                use: true, //是否初始化上拉加载; 默认true
                auto: true, //是否在初始化时以上拉加载的方式自动加载第一页数据; 默认true
                isLock: false, //是否锁定上拉,默认false
                isBoth: false, //上拉加载时,如果滑动到列表顶部是否可以同时触发下拉刷新;默认false,两者不可同时触发; 这里为了演示改为true,不必等列表加载完毕才可下拉;
                isBounce: false, //是否允许ios的bounce回弹;默认true,允许回弹; 此处配置为false,可解决微信,QQ,Safari等等iOS浏览器列表顶部下拉和底部上拉露出浏览器灰色背景和卡顿2秒的问题
                callback: getListData, //上拉回调,此处可简写; 相当于 callback: function (page, mescroll) { getListData(page); }
                page: {
                    num: 0, //当前页 默认0,回调之前会加1; 即callback(page)会从1开始
                    size: 10, //每页数据条数
                    time: null //加载第一页数据服务器返回的时间; 防止用户翻页时,后台新增了数据从而导致下一页数据重复;
                },
                noMoreSize: 5, //如果列表已无数据,可设置列表的总数量要大于半页才显示无更多数据;避免列表数据过少(比如只有一条数据),显示无更多数据会不好看
                offset: 100, //离底部的距离
                toTop: {
                    //回到顶部按钮,需配置src才显示
                    warpId: null, //父布局的id; 默认添加在body中
                    src: "static/front/images/mescroll-totop.png", //图片路径,默认null;
                    html: null, //html标签内容,默认null; 如果同时设置了src,则优先取src
                    offset: 1000, //列表滚动多少距离才显示回到顶部按钮,默认1000
                    warpClass: "mescroll-totop", //按钮样式,参见mescroll.css
                    showClass: "mescroll-fade-in", //显示样式,参见mescroll.css
                    hideClass: "mescroll-fade-out", //隐藏样式,参见mescroll.css
                    duration: 300, //回到顶部的动画时长,默认300ms
                    supportTap: false, //默认点击事件用onclick,会有300ms的延时;如果您的运行环境支持tap,则可配置true;
                    btnClick: null // 点击按钮的回调; 小提示:如果在回调里return true,将不执行回到顶部的操作.
                },
                loadFull: {
                    use: false, //列表数据过少,不足以滑动触发上拉加载,是否自动加载下一页,直到满屏或者无更多数据为止;默认false,因为可通过调高page.size或者嵌套mescroll-bounce的div避免这个情况
                    delay: 500 //延时执行的毫秒数; 延时是为了保证列表数据或占位的图片都已初始化完成,且下拉刷新上拉加载中区域动画已执行完毕;
                },
                empty: {
                    //列表第一页无任何数据时,显示的空提示布局; 需配置warpId或clearEmptyId才生效;
                    warpId: 'mescroll', //父布局的id; 如果此项有值,将不使用clearEmptyId的值;
                    icon: "static/front/images/mescroll-empty.png", //图标,默认null
                    tip: "暂无相关数据~", //提示
                    /*btntext: "去逛逛 >", //按钮,默认""
                    btnClick: function () {//点击按钮的回调,默认null
                        // 访问首页
                        window.location.href = "front/to_index.do";
                    },*/
                    supportTap: false //默认点击事件用onclick,会有300ms的延时;如果您的运行环境支持tap,则可配置true;
                },
                clearId: null, //加载第一页时需清空数据的列表id; 如果此项有值,将不使用clearEmptyId的值;
                clearEmptyId: "dataList", //相当于同时设置了clearId和empty.warpId; 简化写法;默认null; 注意vue中不能配置此项
                hardwareClass: "mescroll-hardware", //硬件加速样式,动画更流畅,参见mescroll.css
                warpId: null, //可配置上拉加载的布局添加到指定id的div;默认不配置,默认添加到mescrollId
                warpClass: "mescroll-upwarp", //容器,装载布局内容,参见mescroll.css
                htmlLoading: '<p class="upwarp-progress mescroll-rotate"></p><p class="upwarp-tip">加载中..</p>', //上拉加载中的布局
                htmlNodata: '<p class="upwarp-nodata">-- END --</p>', //无数据的布局
                inited: function (mescroll, upwarp) {
                    //初始化完毕的回调,可缓存dom 比如 mescroll.upProgressDom = upwarp.getElementsByClassName("upwarp-progress")[0];
                },
                showLoading: function (mescroll, upwarp) {
                    //上拉加载中.. mescroll.upProgressDom.style.display = "block" 不通过此方式显示,因为ios快速滑动到底部,进度条会无法及时渲染
                    upwarp.innerHTML = mescroll.optUp.htmlLoading;
                },
                showNoMore: function (mescroll, upwarp) {
                    //无更多数据
                    upwarp.innerHTML = mescroll.optUp.htmlNodata;
                },
                onScroll: function (mescroll, y, isUp) { //列表滑动监听,默认onScroll: null;
                    //y为列表当前滚动条的位置
                },
                scrollbar: {
                    use: isPC, //默认只在PC端自定义滚动条样式
                    barClass: "mescroll-bar"
                },
                lazyLoad: {
                    use: true, // 是否开启懒加载,默认false
                    attr: 'imgurl', // html标签中,临时存放网络图片地址的属性名: <img src='占位图' imgurl='网络图'/>
                    showClass: 'mescroll-lazy-in', // 显示样式,参见mescroll.css
                    delay: 500, // 列表滚动的过程中每500ms检查一次图片是否在可视区域,如果在可视区域则加载图片
                    offset: 200 // 超出可视区域200px的图片仍可触发懒加载,目的是提前加载部分图片
                }
            }
        });

        /*联网加载列表数据  page = {num:1, size:10}; num:当前页 从1开始, size:每页数据条数 */
        function getListData(page) {
            //联网加载数据
            getListDataFromNet(page.num, page.size, function (data) {
                //联网成功的回调,隐藏下拉刷新和上拉加载的状态;
                //mescroll会根据传的参数,自动判断列表如果无任何数据,则提示空;列表无下一页数据,则提示无更多数据;
                console.log("page.num=" + page.num + ", page.size=" + page.size + ", curPageData.length=" + data.data.curPageData.length);

                //方法一(推荐): 后台接口有返回列表的总页数 totalPage
                mescroll.endByPage(data.data.curPageData.length, data.data.totalPage); // 必传参数(当前页的数据个数, 总页数)

                //设置列表数据
                setListData(data.data.curPageData);
            }, function () {
                //联网失败的回调,隐藏下拉刷新和上拉加载的状态;
                mescroll.endErr();
            });
        }

        /*设置列表数据*/
        function setListData(curPageData) {

            var listDom = document.getElementById("dataList");

            for (var i = 0; i < curPageData.length; i++) {
                var pd = curPageData[i];

                var str = '';
                // 渲染头部
                str += "<div flex=\"cross:center main:justify\" class=\"history-list-item\">" +
                    "           <div flex=\"dir:top\" class=\"left\">" +
                    "               <div flex=\"\" class=\"top\">\n" +
                    "                  <p class=\"active\">期号</p>\n" +
                    "                  <p class=\"normal\">第<span>" + pd.SCENE + "</span>期</p>\n" +
                    "               </div>\n" +
                    "               <div flex=\"\" class=\"center\">\n" +
                    "                   <p class=\"active\">開獎時間</p>\n" +
                    "                   <p class=\"normal\">" + pd.NEXT_PERIOD + "</p>\n" +
                    "                </div>" +
                    "                <div flex=\"\" class=\"bottom\">\n" +
                    "                    <p class=\"active\">中獎號碼</p>\n" +
                    "                    <ul flex=\"\" class=\"history-list lhc\">";
                // 渲染开奖号码
                for (let i = 1; i <= 6; i++) {
                    var colorKey = "COLOR" + i;
                    var zodiacKey = "ZODIAC" + i;
                    var num = "NUM" + i;
                    // 定义颜色类名称
                    var classColor = checkColor(pd[colorKey]);
                    var content = "<li flex=\"dir:top main:center cross:center\">\n" +
                        "              <span flex=\"main:center cross:center\" class=\"ball " + classColor + "\">\n" +
                        "                  " + pd[num] + "\n" +
                        "              </span>\n" +
                        "              <b class=\"sheng-xiao\"> " + pd[zodiacKey] + " </b>\n" +
                        "          </li>";
                    str += content;
                }
                // 渲染特码及尾部
                str += "            <li class=\"symbol\">+</li>\n" +
                    "               <li flex=\"dir:top main:center cross:center\">\n" +
                    "                   <span flex=\"main:center cross:center\" class=\"ball " + checkColor(pd.COLOR7) + "\">\n" +
                    "                        " + pd.NUM7 + "\n" +
                    "                   </span>\n" +
                    "                   <b class=\"sheng-xiao\"> " + pd.ZODIAC7 + " </b>\n" +
                    "                </li>\n" +
                    "            </ul>" +
                    "         </div> " +
                    "     </div>" +
                    "   </div>" +
                    "</div>";

                // 创建新节点并追加到元素上
                var liDom = document.createElement("div");
                liDom.setAttribute("class", "history-list-wrap");
                liDom.innerHTML = str;
                listDom.appendChild(liDom);
            }
        }

        /*联网加载列表数据
         * */
        function getListDataFromNet(pageNum, pageSize, successCallback, errorCallback) {

            var url = 'release/logicalPagingHistoryRecord.do?num=' + pageNum + "&size=" + pageSize;

            $.ajax({
                url: url,
                success: function (data) {
                    // 接口返回的当前页数据列表 及 总页数
                    // 回调
                    successCallback(data);
                },
                error: errorCallback
            });
        }
    });

</script>

</html>
