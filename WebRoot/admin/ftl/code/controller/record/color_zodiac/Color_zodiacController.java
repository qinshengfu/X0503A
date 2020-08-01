package com.fh.controller.record;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Jurisdiction;
import com.fh.util.Tools;
import com.fh.service.record.Color_zodiacManager;

/** 
 * 说明：开奖颜色和生肖
 * 创建人：
 * 创建时间：2020-05-18
 */
@Controller
@RequestMapping(value="/color_zodiac")
public class Color_zodiacController extends BaseController {
	
	String menuUrl = "color_zodiac/list.do"; //菜单地址(权限用)
	@Resource(name="color_zodiacService")
	private Color_zodiacManager color_zodiacService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Color_zodiac");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("COLOR_ZODIAC_ID", this.get32UUID());	//主键
		pd.put("GMT_CREATE", Tools.date2Str(new Date()));	//创建时间
		pd.put("GMT_MODIFIED", Tools.date2Str(new Date()));	//更新时间
		pd.put("SCENE_ID", "");	//第几场的ID
		pd.put("COLOR1", "");	//颜色1
		pd.put("ZODIAC1", "");	//生肖1
		pd.put("COLOR2", "");	//颜色2
		pd.put("ZODIAC2", "");	//生肖2
		pd.put("COLOR3", "");	//颜色3
		pd.put("ZODIAC3", "");	//生肖3
		pd.put("COLOR4", "");	//颜色4
		pd.put("ZODIAC4", "");	//生肖4
		pd.put("COLOR5", "");	//颜色5
		pd.put("ZODIAC5", "");	//生肖5
		pd.put("COLOR6", "");	//颜色6
		pd.put("ZODIAC6", "");	//生肖6
		pd.put("COLOR7", "");	//颜色7
		pd.put("ZODIAC7", "");	//生肖7
		color_zodiacService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Color_zodiac");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		color_zodiacService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Color_zodiac");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		color_zodiacService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Color_zodiac");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = color_zodiacService.list(page);	//列出Color_zodiac列表
		mv.setViewName("record/color_zodiac/color_zodiac_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("record/color_zodiac/color_zodiac_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = color_zodiacService.findById(pd);	//根据ID读取
		mv.setViewName("record/color_zodiac/color_zodiac_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Color_zodiac");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			color_zodiacService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出Color_zodiac到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("创建时间");	//1
		titles.add("更新时间");	//2
		titles.add("第几场的ID");	//3
		titles.add("颜色1");	//4
		titles.add("生肖1");	//5
		titles.add("颜色2");	//6
		titles.add("生肖2");	//7
		titles.add("颜色3");	//8
		titles.add("生肖3");	//9
		titles.add("颜色4");	//10
		titles.add("生肖4");	//11
		titles.add("颜色5");	//12
		titles.add("生肖5");	//13
		titles.add("颜色6");	//14
		titles.add("生肖6");	//15
		titles.add("颜色7");	//16
		titles.add("生肖7");	//17
		dataMap.put("titles", titles);
		List<PageData> varOList = color_zodiacService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("GMT_CREATE"));	    //1
			vpd.put("var2", varOList.get(i).getString("GMT_MODIFIED"));	    //2
			vpd.put("var3", varOList.get(i).getString("SCENE_ID"));	    //3
			vpd.put("var4", varOList.get(i).getString("COLOR1"));	    //4
			vpd.put("var5", varOList.get(i).getString("ZODIAC1"));	    //5
			vpd.put("var6", varOList.get(i).getString("COLOR2"));	    //6
			vpd.put("var7", varOList.get(i).getString("ZODIAC2"));	    //7
			vpd.put("var8", varOList.get(i).getString("COLOR3"));	    //8
			vpd.put("var9", varOList.get(i).getString("ZODIAC3"));	    //9
			vpd.put("var10", varOList.get(i).getString("COLOR4"));	    //10
			vpd.put("var11", varOList.get(i).getString("ZODIAC4"));	    //11
			vpd.put("var12", varOList.get(i).getString("COLOR5"));	    //12
			vpd.put("var13", varOList.get(i).getString("ZODIAC5"));	    //13
			vpd.put("var14", varOList.get(i).getString("COLOR6"));	    //14
			vpd.put("var15", varOList.get(i).getString("ZODIAC6"));	    //15
			vpd.put("var16", varOList.get(i).getString("COLOR7"));	    //16
			vpd.put("var17", varOList.get(i).getString("ZODIAC7"));	    //17
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
