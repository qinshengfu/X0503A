$(function () {


});

// websocket对象
var websocket;
// 在线管理服务器IP和端口
var oladress = "";
// 当前登录用户名
var userName = "";

/*
时间倒计时插件
id：绑定页面元素
endDateStr：结束时间
n: 几小时后
*/
function TimeDown(id, endDateStr, n) {
    //结束时间
    var endDate = new Date(endDateStr);
    endDate = endDate.setHours(endDate.getHours() + n);
    //当前时间
    var nowDate = new Date();
    //相差的总秒数
    var totalSeconds = parseInt((endDate - nowDate) / 1000);
    //天数
    var days = Math.floor(totalSeconds / (60 * 60 * 24));
    //取模（余数）
    var modulo = totalSeconds % (60 * 60 * 24);
    //小时数
    var hours = Math.floor(modulo / (60 * 60));
    modulo = modulo % (60 * 60);
    //分钟
    var minutes = Math.floor(modulo / 60);
    //秒
    var seconds = modulo % 60;
    //输出到页面
    if (endDate <= nowDate) {
        document.getElementById(id).innerHTML = content(0, 0, 0);
        return;
    } else {
        document.getElementById(id).innerHTML = content(hours, minutes, seconds);
    }
    /*
        if (endDate <= nowDate) {
            document.getElementById(id).innerHTML = "时间到";
            return;
        } else {
            document.getElementById(id).innerHTML = days + "天" + hours + "小时" + minutes + "分钟" + seconds + "秒";
        }
    */
    //延迟一秒执行自己
    setTimeout(function () {
        TimeDown(id, endDateStr, n);
    }, 1000)
}

/*
时间倒计时插件
id：绑定页面元素
endDateStr：结束时间
倒计时结束 返回true 否则返回 false
*/
function countDown(id, endDateStr) {

    endDateStr = endDateStr.replace(/-/g,"/");

    //结束时间
    var endDate = new Date(endDateStr);
    //当前时间
    var nowDate = new Date();
    //相差的总秒数
    var totalSeconds = parseInt((endDate - nowDate) / 1000);
    //天数
    var days = Math.floor(totalSeconds / (60 * 60 * 24));
    //取模（余数）
    var modulo = totalSeconds % (60 * 60 * 24);
    //小时数
    var hours = Math.floor(totalSeconds / (60 * 60));
    modulo = modulo % (60 * 60);
    //分钟
    var minutes = Math.floor(modulo / 60);
    //秒
    var seconds = modulo % 60;
    //输出到页面
    if (endDate <= nowDate) {
        document.getElementById(id).innerHTML = content(0, 0, 0, 0, 0, 0);
        return true;
    } else {
        var hours1 = 0, hours2 = 0, minutes1 = 0, minutes2 = 0, seconds1 = 0, seconds2 = 0;
        if (hours < 10) {
            hours2 = hours

        } else {
            hours1 = hours.toString().charAt(0);
            hours2 = hours.toString().charAt(1);
        }
        if (minutes < 10) {
            minutes2 = minutes
        } else {
            minutes1 = minutes.toString().charAt(0);
            minutes2 = minutes.toString().charAt(1);
        }
        if (seconds < 10) {
            seconds2 = seconds;
        } else {
            seconds1 = seconds.toString().charAt(0);
            seconds2 = seconds.toString().charAt(1);
        }
        document.getElementById(id).innerHTML = content(hours1, hours2, minutes1, minutes2, seconds1, seconds2);
    }

    //延迟一秒执行自己
    setTimeout(function () {
        countDown(id, endDateStr);
    }, 1000);


}

// 倒计时的内容
function content(hours1, hours2, minutes1, minutes2, seconds1, seconds2) {
    return "" +
        "<div class=\"hour\"><span class=\"number\">" + hours1 + "</span><span class=\"number\">" + hours2 + "</span></div>\n" +
        "<div class=\"division\"><span class=\"colon\">:</span></div>\n" +
        "<div class=\"minute\"><span class=\"number\">" + minutes1 + "</span><span class=\"number\">" + minutes2 + "</span></div>\n" +
        "<div class=\"division\"><span class=\"colon\">:</span></div>\n" +
        "<div class=\"second\"><span class=\"number\">" + seconds1 + "</span><span class=\"number\">" + seconds2 + "</span></div>"
}

/*
时间进度条
返回当前进度百分比
 */
function timeProgressBar(startTime, endTime) {
    // 转时间戳 Math.round(new Date() / 1000)

    // 开始时间
    var startDate = Math.round(new Date(startTime) / 1000);
    //结束时间
    var endDate = Math.round(new Date(endTime) / 1000);
    //当前时间
    var nowDate = Math.round(new Date() / 1000);
    /*
        console.log("开始时间：" + startDate);
        console.log("结束时间：" + endDate);
        console.log("当前时间：" + nowDate);
        var seconds1 = nowDate - startDate;
        var seconds2 = endDate - startDate;
        console.log("当前时间-开始时间：" + seconds1);
        console.log("结束时间-开始时间：" + seconds2);
        var division = seconds1 / seconds2;
        console.log("相除：" + division);
        console.log("乘100：" + division * 100);
    */

    // 开始计算进度 (当前时间-开始时间)/ (结束时间-开始时间) *100%
    return ((nowDate - startDate) / (endDate - startDate) * 100).toFixed(2)
}


// 初始化信息
function initWebSocket() {
    $.ajax({
        type: "POST",
        url: 'front/getList.do?tm=' + new Date().getTime(),
        data: encodeURI(""),
        dataType: 'json',
        //beforeSend: validateData,
        cache: false,
        success: function (data) {
            // 设置当登录用户姓名
            userName = "FT-" + data.user.USER_NAME;
            // 在线管理和站内信服务器IP和端口
            oladress = data.oladress;
            // 连接在线
            online();
        }
    });
}

//加入在线列表
function online() {
    if (window.WebSocket) {
        websocket = new WebSocket(encodeURI('ws://' + oladress));
        websocket.onopen = function () {
            //连接成功
            websocket.send('[join]' + userName);
        };
        websocket.onerror = function () {
            //连接失败
        };
        websocket.onclose = function () {
            //连接断开
        };
        //消息接收
        websocket.onmessage = function (messageEvent) {
            var message = JSON.parse(messageEvent.data);
            if (message.type == 'goOut') {
                $("body").html("");
                goOutLogin("1");
            }
            if (message.type == 'thegoout') {
                $("body").html("");
                goOutLogin("2");
            }
        };
    }
}

//下线
function goOutLogin(msg) {
    mui.confirm("<spring:message code='common.elsewhere' text='您被系统管理员强制下线或您的帐号在别处登录'/>");
    window.location.href = "release/outLogin.do?msg=" + msg;
}


// 判断颜色名称 返回对应颜色的类名
function checkColor(colorName) {
    if (colorName == "红色") {
        return classColor = "redBg"
    }
    if (colorName == "绿色") {
        return classColor = "greenBg"
    }
    if (colorName == "蓝色") {
        return classColor = "blueBg"
    }
}
