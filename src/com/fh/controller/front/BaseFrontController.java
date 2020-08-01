package com.fh.controller.front;

import cn.hutool.core.util.StrUtil;
import com.fh.controller.base.BaseController;
import com.fh.dao.RedisDao;
import com.fh.service.front.Sys_configManager;
import com.fh.service.record.*;
import com.fh.service.system.FHlogManager;
import com.fh.util.PageData;
import com.fh.util.Tools;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;

/**
 * 说明：前台基础控制器
 * 创建人：Ajie
 * 创建时间：2020年4月1日17:34:45
 */
public class BaseFrontController extends BaseController {

    // 系统参数
    @Resource(name = "sys_configService")
    protected Sys_configManager sys_configService;
    // 新闻公告
    @Resource(name = "sys_newsService")
    protected Sys_newsManager sys_newsService;
    // 轮播图
    @Resource(name = "sys_chartService")
    protected Sys_chartManager sys_chartService;
    // 日志管理
    @Resource(name="fhlogService")
    protected FHlogManager FHLOG;
    // Redis
    @Resource(name = "redisDaoImpl")
    protected RedisDao redisDaoImpl;
    // 关于我们
    @Resource(name="aboutService")
    protected AboutManager aboutService;
    // 色号
    @Resource(name="colorService")
    protected ColorManager colorService;
    // 场次
    @Resource(name="run_sceneService")
    protected Run_sceneManager run_sceneService;
    // 十二生肖
    @Resource(name="zodiacService")
    protected ZodiacManager zodiacService;
    // 常见问题
    @Resource(name="faqService")
    protected FaqManager faqService;
    // 技术支持
    @Resource(name="technicalsupportService")
    protected TechnicalSupportManager technicalsupportService;
    // 图表资料
    @Resource(name="chartinfoService")
    protected ChartInfoManager chartinfoService;

    /**
     * 功能描述：给一组数字添加对应的颜色和生肖
     *
     * @param data 需要添加颜色和生肖的数据
     * @author Ajie
     * @date 2020/5/5 0005
     */
    public PageData addColorAndZodiac(PageData data) throws Exception {
        PageData pd = new PageData();
        // 初始化 数字、颜色、生肖
        String num, color, zodiac;
        int i = 1;
        while (i <= 7) {
            String key = "NUM" + i;
            num = data.getString(key);
            if (Tools.notEmpty(num)) {
                // 判断颜色和生肖
                color = judgeColor(num);
                zodiac = judgeZodiac(num);
                // 写入map
                pd.put("COLOR"+i, color);
                pd.put("ZODIAC"+i, zodiac);
            }
            i++;
        }
        return pd;
    }

    /**
     * 功能描述：传入一个数字判断属于什么颜色
     *
     * @param num 数字
     * @return 颜色标识
     * @author Ajie
     * @date 2020/5/4 0004
     */
    private String judgeColor(String num) throws Exception {
        PageData pd = new PageData();
        // 查询所有颜色
        List<PageData> colorList = colorService.listAll(pd);
        for (PageData map : colorList) {
            String color = map.getString("NUMBER_LIST");
            // 判断是否 包含数字
            if (StrUtil.equalsAny(num, StrUtil.split(color, "|"))) {
                return map.getString("COLOR_NAME");
            }
        }
        return null;
    }

    /**
     * 功能描述：传入一个数字判断属于什么生肖
     *
     * @param num 数字
     * @return 生肖
     * @author Ajie
     * @date 2020年5月5日10:25:26
     */
    private String judgeZodiac(String num) throws Exception {
        PageData pd = new PageData();
        // 查询所有生肖
        List<PageData> zodiacList = zodiacService.listAll(pd);
        for (PageData map : zodiacList) {
            String zodiac = map.getString("NUMBER_LIST");
            // 判断是否 包含数字
            if (StrUtil.equalsAny(num, StrUtil.split(zodiac, "|"))) {
                return map.getString("NAME");
            }
        }
        return null;
    }

}
