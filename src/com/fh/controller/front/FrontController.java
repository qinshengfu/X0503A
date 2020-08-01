package com.fh.controller.front;


import com.alibaba.fastjson.JSON;
import com.fh.annotation.Limit;
import com.fh.entity.Page;
import com.fh.entity.result.R;
import com.fh.util.DateUtil;
import com.fh.util.PageData;
import com.fh.util.Pager;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

/**
 * 功能描述：前台页面 关于我们、开奖公告等
 *
 * @author Ajie
 * @date 2020年5月4日17:40:18
 */
@Controller
@RequestMapping(value = "/release")
@Slf4j
@Api(tags = "关于我们、开奖公告等")
public class FrontController extends BaseFrontController {


    /**
     * 功能描述：访问前台【开奖公告页】页面
     *
     * @author Ajie
     * @date 2020年5月5日09:23:43
     */
    @RequestMapping(value = "to_news")
    public ModelAndView toNews() throws Exception {
        ModelAndView mv = getModelAndView();
        PageData pd = new PageData();
        // 获取系统参数
        PageData par = sys_configService.findById(pd);
        // 查询最新一条新闻公告
        pd.put("count", 1);
        List<PageData> newsList = sys_newsService.listAppointResult(pd);
        PageData news = null;
        if (!newsList.isEmpty()) {
            news = newsList.get(0);
        }
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
        // 验证最新一期开奖没有
        String openBonusTime = latest.getString("NEXT_PERIOD");
        if (DateUtil.isEqualDate(openBonusTime)) {
            // 最新一期开奖了 把上一期替换为最新一期
            last = latest;
        }
        mv.setViewName("front/drawNotice");
        mv.addObject("news", news);
        mv.addObject("latest", JSON.toJSON(latest));
        mv.addObject("last", JSON.toJSON(last));
        mv.addObject("par", par);
        mv.addObject("flag", "news");
        return mv;
    }

    /**
     * 功能描述：逻辑分页 历史开奖记录查询
     *
     * @author Ajie
     * @date 2020/5/5 0005
     */
    @GetMapping(value = "logicalPagingHistoryRecord")
    @ResponseBody
    @ApiOperation("逻辑分页 历史开奖记录查询")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "num", value = "页码", example = "1", required = true, dataType = "Integer"),
            @ApiImplicitParam(name = "size", value = "页长", example = "10", required = true, dataType = "Integer")
    })
    public R logicalPagingHistoryRecord() throws Exception {
        PageData pd = this.getPageData();
        // 查询全部记录
        List<PageData> listAll = run_sceneService.listAll(pd);
        String orderTime = listAll.get(0).getString("NEXT_PERIOD");
        boolean isOut = DateUtil.isEqualDate(orderTime);
        if (!isOut) {
            // 去掉最新的一期
            listAll.remove(0);
        }
        // 执行分页
        Pager<PageData> pager = new Pager<>();
        // 页码
        int num = Integer.parseInt(pd.get("num").toString());
        // 每页数据条数
        int pageSize = Integer.parseInt(pd.get("size").toString());
        // 第 N 页
        pager.setCurentPageIndex(num);
        // 每页 N 条
        pager.setCountPerpage(pageSize);
        // 查询到的大集合
        pager.setBigList(listAll);
        // 得到总页数
        int totalPage = pager.getPageCount();
        // 得到小的集合(分页的当前页的记录)
        List<PageData> curPageData = pager.getSmallList();

        pd.put("curPageData", curPageData);
        pd.put("totalPage", totalPage);
        return R.ok().data(pd);
    }

    /**
     * 功能描述：物理分页 历史开奖记录查询
     *
     * @author Ajie
     * @date 2020/5/5 0005
     */
    @GetMapping(value = "physicalPagingHistoryRecord")
    @ResponseBody
    @ApiOperation("物理分页 历史开奖记录查询")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "currentPage", value = "页码", example = "1", required = true, dataType = "Integer"),
            @ApiImplicitParam(name = "showCount", value = "页长", example = "10", required = true, dataType = "Integer")
    })
    public R physicalPagingHistoryRecord(Page page) throws Exception {
        PageData pd = new PageData();
        // 查询记录
        List<PageData> listPage = run_sceneService.todayYearData(page);
        String orderTime = listPage.get(0).getString("NEXT_PERIOD");
        boolean isOut = DateUtil.isEqualDate(orderTime);
        if (!isOut) {
            // 去掉最新的一期
            listPage.remove(0);
        }
        // 去掉最新的一期
        listPage.remove(0);
        // 得到总页数
        int totalPage = page.getTotalPage();
        pd.put("curPageData", listPage);
        pd.put("totalPage", totalPage);
        return R.ok().data(pd);
    }

    /**
     * 功能描述：访问前台【帮助】页面
     *
     * @author Ajie
     * @date 2020年5月5日09:23:43
     */
    @RequestMapping(value = "to_faq")
    public ModelAndView toFaq() throws Exception {
        ModelAndView mv = getModelAndView();
        // 查詢所有常见问题列表
        List<PageData> listAll = faqService.listAll(new PageData());
        // 获取最新的一条技术支持说明记录
        PageData technical = technicalsupportService.getLatest();

        mv.setViewName("front/FAQ");
        mv.addObject("flag", "faq");
        mv.addObject("data", listAll);
        mv.addObject("technical", technical);
        return mv;
    }

    /**
     * 功能描述：访问前台【关于我们】页面
     *
     * @author Ajie
     * @date 2020年5月5日09:23:43
     */
    @RequestMapping(value = "to_about")
    public ModelAndView toAbout() throws Exception {
        ModelAndView mv = getModelAndView();
        // 查询所有 关于我们列表
        List<PageData> aboutList = aboutService.listAll(new PageData());

        mv.setViewName("front/aboutUs");
        mv.addObject("dataList", aboutList);
        mv.addObject("flag", "about");
        return mv;
    }

    /**
     * 功能描述：访问前台【图表资料】页面
     *
     * @author Ajie
     * @date 2020/5/11 0011
     */
    @RequestMapping({"to_chartInfo"})
    public ModelAndView toChartInfo() {
        final ModelAndView mv = this.getModelAndView();
        mv.setViewName("front/chartInfo");
        mv.addObject("flag", "chart");
        return mv;
    }

    /**
     * 功能描述：最新一期图表资料
     * @author Ajie
     * @date 2020/5/11 0011
     */
    @ApiOperation("最新一期图表资料")
    @GetMapping({"chartInfo"})
    @ResponseBody
    @Limit(prefix = "X0503A", period = 10, count = 7)
    public R chartInfoData() throws Exception {
        PageData pd = new PageData();
        // 查询最新一期数据
        PageData latest = run_sceneService.getLatest(pd);
        // 根据期号查询最新图表资料
        List<PageData> chartList = chartinfoService.listBySceneAndType(latest);
        return R.ok().message("最新一期图表资料").data("dataList", chartList);
    }


}


