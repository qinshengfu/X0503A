package com.fh.service.record.impl;

import java.util.List;
import javax.annotation.Resource;

import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.record.ChartInfoManager;

/** 
 * 说明： 图表资料
 * 创建人：
 * 创建时间：2020-05-09
 * @version
 */
@Service("chartinfoService")
@CacheConfig(cacheNames = "X0503A_ChartInfo")
public class ChartInfoService implements ChartInfoManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	@CacheEvict(allEntries = true)
	public void save(PageData pd)throws Exception{
		dao.save("ChartInfoMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	@CacheEvict(allEntries = true)
	public void delete(PageData pd)throws Exception{
		dao.delete("ChartInfoMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	@CacheEvict(allEntries = true)
	public void edit(PageData pd)throws Exception{
		dao.update("ChartInfoMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@Cacheable
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ChartInfoMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	@Cacheable
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ChartInfoMapper.listAll", pd);
	}

	/**列表(按场次和类型)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	@Cacheable
	public List<PageData> listBySceneAndType(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ChartInfoMapper.listBySceneAndType", pd);
	}

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	@Cacheable
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ChartInfoMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	@Cacheable
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("ChartInfoMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

