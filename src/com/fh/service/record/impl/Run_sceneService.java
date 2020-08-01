package com.fh.service.record.impl;

import java.util.List;
import javax.annotation.Resource;

import cn.hutool.core.convert.Convert;
import cn.hutool.core.date.DateUtil;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.record.Run_sceneManager;
import org.springframework.transaction.annotation.Transactional;

/** 
 * 说明： 开奖场次
 * 创建人：
 * 创建时间：2020-05-04
 * @version
 */
@Service("run_sceneService")
@CacheConfig(cacheNames = "X0503A_runScens")
public class Run_sceneService implements Run_sceneManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	@Override
	@CacheEvict(allEntries = true)
	// 所有异常都回滚
	@Transactional(rollbackFor = Exception.class)
	public void save(PageData pd)throws Exception{
		dao.save("Run_sceneMapper.save", pd);
		// 获取刚刚新增记录的ID
		Integer runSceneId = Convert.toInt(pd.get("RUN_SCENE_ID"));
		// 外键关联
		pd.put("SCENE_ID", runSceneId);
		//主键
		pd.put("COLOR_ZODIAC_ID", runSceneId);
		// 创建颜色和生肖记录
		dao.save("Color_zodiacMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	@CacheEvict(allEntries = true)
	public void delete(PageData pd)throws Exception{
		dao.delete("Run_sceneMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	@Override
	@CacheEvict(allEntries = true)
	@Transactional(rollbackFor = Exception.class)
	public void edit(PageData pd, PageData colorAndZodiac)throws Exception{
		// 修改场次
		dao.update("Run_sceneMapper.edit", pd);
		// 修改颜色和生肖
		dao.update("Color_zodiacMapper.edit", colorAndZodiac);

	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Cacheable
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("Run_sceneMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	@Cacheable
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("Run_sceneMapper.listAll", pd);
	}

	/**列表(今年的数据)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	@Cacheable
	public List<PageData> listByYear(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("Run_sceneMapper.listByYear", pd);
	}

	/**列表(物理分页数据)
	 * @param page
	 * @throws Exception
	 */
	@Override
	@Cacheable
	public List<PageData> todayYearData(Page page)throws Exception{
		return (List<PageData>)dao.findForList("Run_sceneMapper.todayYearlistPage", page);
	}

	/**列表(查询N条数据)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	@Cacheable
	public List<PageData> listAppointResult(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("Run_sceneMapper.listAppointResult", pd);
	}

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	@Cacheable
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("Run_sceneMapper.findById", pd);
	}

	/**获取最新一期数据
	 * @param pd
	 * @throws Exception
	 */
	@Override
	@Cacheable
	public PageData getLatest(PageData pd)throws Exception{
		return (PageData)dao.findForObject("Run_sceneMapper.getLatest", pd);
	}

	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	@CacheEvict(allEntries = true)
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("Run_sceneMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

