package com.fh.service.record;

import java.util.List;
import com.fh.entity.Page;
import com.fh.util.PageData;
import org.springframework.cache.annotation.CacheConfig;

/** 
 * 说明： 开奖场次接口
 * 创建人：
 * 创建时间：2020-05-04
 * @version
 */
public interface Run_sceneManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	void save(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	void edit(PageData pd, PageData colorAndZodiac)throws Exception;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	List<PageData> listAll(PageData pd)throws Exception;

	/**列表(今年的数据)
	 * @param pd
	 * @throws Exception
	 */
	List<PageData> listByYear(PageData pd)throws Exception;

	/**列表(物理分页数据)
	 * @param page
	 * @throws Exception
	 */
	List<PageData> todayYearData(Page page)throws Exception;

	/**列表(查询N条数据)
	 * @param pd
	 * @throws Exception
	 */
	List<PageData> listAppointResult(PageData pd)throws Exception;

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	PageData findById(PageData pd)throws Exception;

	/**获取最新一期数据
	 * @param pd
	 * @throws Exception
	 */
	PageData getLatest (PageData pd)throws Exception;

	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	
}

