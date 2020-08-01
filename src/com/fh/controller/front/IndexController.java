package com.fh.controller.front;


import com.alibaba.fastjson.JSON;
import com.fh.annotation.Limit;
import com.fh.entity.result.R;
import com.fh.util.DateUtil;
import com.fh.util.PageData;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

/**
 * 说明：前台首页控制器
 * 创建人：Ajie
 * 创建时间：2020年5月4日17:37:37
 */
@Controller
@RequestMapping("/release")
@Api(tags = "首页操作相关")
public class IndexController extends BaseFrontController {

    /**
     * 功能描述：访问前台【首页】页面
     *
     * @author Ajie
     * @date 2020年5月4日17:41:27
     */
    @RequestMapping(value = "to_index")
    public ModelAndView toIndex() throws Exception {
        ModelAndView mv = getModelAndView();
        PageData pd = new PageData();
        // 查询所有轮播图
        List<PageData> chartAll = sys_chartService.listAll(pd);
        // 查询最新的2期场次
        pd.put("count", 2);
        List<PageData> resultList = run_sceneService.listAppointResult(pd);
        PageData latest = null;
        PageData last = null;
        if (!resultList.isEmpty()) {
            // 最新一期和上一期
            latest = resultList.get(0);
            last = resultList.get(1);
        }
        // 查询系统参数
        PageData par = sys_configService.findById(new PageData());

        mv.setViewName("front/index");
        mv.addObject("flag", "index");
        mv.addObject("latest", JSON.toJSON(latest) );
        mv.addObject("last", JSON.toJSON(last));
        mv.addObject("chart", chartAll);
        mv.addObject("par", par);
        return mv;
    }

    /**
     * 功能描述：查询最新五期数据
     *
     * @author Ajie
     * @date 2020/5/5 0005
     */
    @GetMapping(value = "latestFiveIssues")
    @ResponseBody
    @ApiOperation(value = "查询最新五期数据")
    public R latestFiveIssues() throws Exception {
        PageData pd = new PageData();
        // 查询N条数据
        pd.put("count", 5);
        List<PageData> fiveResult = run_sceneService.listAppointResult(pd);
        boolean isOut = DateUtil.isEqualDate(fiveResult.get(0).getString("NEXT_PERIOD"));
        if (!isOut) {
            // 去掉未开奖的一期
            fiveResult.remove(0);
        }
        return R.ok().data("pd", fiveResult);
    }

    /**
     * 功能描述：检查最新一期倒计时是否结束
     *
     * @author Ajie
     * @date 2020/5/5 0005
     */
    @GetMapping(value = "checkIsOver")
    @ResponseBody
    @Limit(name = "检查是否到期", prefix = "X0503A", period = 10, count = 6)
    @ApiOperation(value = "检查是否到开奖时间")
    public R checkIsOver() throws Exception {
        // 获取最新一期记录
        PageData latest = run_sceneService.getLatest(new PageData());
        String endTime = latest.getString("NEXT_PERIOD");
        if (!DateUtil.isEqualDate(endTime)) {
            return R.error().message("未到开奖时间");
        }
        return R.ok().data(latest);
    }


}

