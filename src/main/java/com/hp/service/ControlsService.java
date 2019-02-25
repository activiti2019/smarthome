package com.hp.service;

import java.util.List;


import com.hp.pojo.Controls;
import com.hp.pojo.QueryControls;
import com.hp.utils.Page;

/** 
* @author 作者 : 王伟
* @version 创建时间：2017年10月16日 上午9:46:07 
* 类说明 
*/
public interface ControlsService {

	/**
	 * 查询当前用户所拥有的id
	 * @param userid
	 * @return
	 */
    List<Integer> selectControlsById(int userid);
    
    /**
     * 通过QueryControls查询信息条数 
     * @param queryControls
     * @return
     */
    int countByQueryControls(QueryControls queryControls);
    
    /**
     * 通过queryControls查询所有符合条件的控件
     * @param queryControls
     * @return
     */
    Page<Controls> selectByQueryControls(QueryControls queryControls);
    
    /**
     * 查询所有控件信息
     * @return
     */
    List<Controls> selectAll();
    
    /**
     * 通过controls修改控件
     * @param controls
     * @return
     */
  	int updateByControls(Controls controls);
  	
  	/**
  	 * 通过id删除控件
  	 * @param integer
  	 * @return
  	 */
  	int deleteById(Integer integer);
  	
  	/**
  	 * 添加控件
  	 * @param controls
  	 * @return
  	 */
  	int addControls(Controls controls);
  	
  	/**
  	 * 通过id查询控件
  	 * @param integer
  	 * @return
  	 */
  	Controls selectById(Integer integer);
}
