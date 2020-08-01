package com.fh.controller.front;

import cn.hutool.core.thread.ThreadUtil;
import com.fh.util.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

/**
 * 说明：系统参数配置
 * 创建人：
 * 创建时间：2020-03-25
 */
@Controller
@RequestMapping(value="/sys_config")
public class Sys_configController extends BaseFrontController {
	
	String menuUrl = "sys_config/list.do"; //菜单地址(权限用)


	/**
	 * 功能描述：清空数据,保留顶点用户
	 * @author Ajie
	 * @date 2019/12/23 0023
	 */
	@RequestMapping(value="/wipeAllData")
	@ResponseBody
	public String delete(HttpServletRequest request) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"清空数据");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();
		// 删除轮播图
		String picPath = request.getServletContext().getRealPath(Const.FILEPATHTWODIMENSIONCODE);
		DelAllFile.delAllFile(picPath);
		// 需要清空数据的表名
		pd.put("FT_SYS_NEWS", "FT_SYS_NEWS");
		pd.put("FT_RUN_SCENE", "FT_RUN_SCENE");
		pd.put("FT_COLOR_ZODIAC", "FT_COLOR_ZODIAC");
		// 调用多线程清缓存清空表
		ThreadUtil.execute(() -> {
			try {
				// 清空表
				sys_configService.deleteAllTable(pd);
				// 重置序列
				resetSeq();
			} catch (Exception e) {
				e.printStackTrace();
			}
		});
		FHLOG.save(Jurisdiction.getUsername(), "清空数据");

		// 清空Redis数据库
		redisDaoImpl.deleteAll();
		return "success";
	}

	/**
	 * 功能描述：调用存储过程重置序列
	 * @author Ajie
	 * @date 2019年12月23日11:28:14
	 */
	private void resetSeq() throws Exception {
		PageData pd = new PageData();
		pd.put("seqName", "FT_RUN_SCENE_SEQ");
		pd.put("seqStart", "1");
		sys_configService.reset_seq(pd);
	}

	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	@ResponseBody
	public String edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Sys_config");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		PageData pd;
		pd = this.getPageData();
		pd.put("GMT_MODIFIED", Tools.date2Str(new Date()));	//更新时间
		sys_configService.edit(pd);
		System.out.println("修改系统参数："+pd);
		System.out.println("系统参数长度为："+pd.size());
		ThreadUtil.execute(() -> {
			try {
				FHLOG.save(Jurisdiction.getUsername(), "修改系统参数");
			} catch (Exception e) {
				e.printStackTrace();
			}
		});
		return "success";
	}
	
	/**列表
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Sys_config");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = sys_configService.findById(pd);
		mv.setViewName("front/sys_config/sys_config_list");
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		ThreadUtil.execute(() -> {
			try {
				FHLOG.save(Jurisdiction.getUsername(), "查看系统参数");
			} catch (Exception e) {
				e.printStackTrace();
			}
		});
		return mv;
	}

}
