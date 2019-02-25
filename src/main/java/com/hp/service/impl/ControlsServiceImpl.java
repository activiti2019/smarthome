package com.hp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hp.mapper.ControlsMapper;
import com.hp.pojo.Controls;
import com.hp.pojo.ControlsExample;
import com.hp.pojo.QueryControls;
import com.hp.service.ControlsService;
import com.hp.utils.Page;

/** 
* @author 作者 : 王伟
* @version 创建时间：2017年10月16日 上午9:47:02 
* 类说明 
*/
@Service("ControlsService")
public class ControlsServiceImpl implements ControlsService {
	@Autowired
	private ControlsMapper controlsMapper;
	
	/*
	 * 通过用户id查询控件信息
	 */
	@Override
	public List<Integer> selectControlsById(int userid) {
		return controlsMapper.selectControlsById(userid);
	}
	
	/*
	 * 通过QueryControls查询信息条数 
	 */
	@Override
	public int countByQueryControls(QueryControls queryControls) {
		return controlsMapper.countByQueryControls(queryControls);
	}

	/*
	 *  通过queryControls查询所有符合条件的用户
	 */
	@Override
	public Page<Controls> selectByQueryControls(QueryControls queryControls) {
		Page<Controls> page=new Page<Controls>();
		if (null != queryControls) {
			if (null != queryControls.getCnName() && !"".equals(queryControls.getCnName().trim())){
				queryControls.setCnName(queryControls.getCnName().trim());
			}
			page.setTotal(controlsMapper.countByQueryControls(queryControls));
			if (null != queryControls.getPage()) {
				int x=controlsMapper.countByQueryControls(queryControls);
				int y=(int)Math.ceil((double)x/queryControls.getSize());
				if(queryControls.getPage().intValue()>y && 0!=y){
					queryControls.setPage(y);
				}
				page.setPage(queryControls.getPage().intValue());
				queryControls.setStartRow(Integer.valueOf((page.getPage() - 1) * page.getSize()));
			}
			page.setRows(controlsMapper.selectByQueryControls(queryControls));
		}
		return page;
	}
	
	/*
	 * 通过controls修改控件
	 */
	@Override
	public int updateByControls(Controls controls) {
		return controlsMapper.updateByPrimaryKeySelective(controls);
	}

	/*
	 *  通过id删除控件
	 */
	@Override
	public int deleteById(Integer integer) {
		return controlsMapper.deleteByPrimaryKey(integer);
	}

	/*
	 *  添加控件
	 */
	@Override
	public int addControls(Controls controls) {
		if(null!=controls){
			if(null!=controls.getCnName()&&!"".equals(controls.getCnName().trim())){
				controls.setCnName(controls.getCnName().trim());
			}
			if(null==controlsMapper.selectByControls(controls)){
				return controlsMapper.insertSelective(controls);
			}
		}
		return 0;
	}
	
	/*
	 *  通过id查询控件
	 */
	@Override
	public Controls selectById(Integer cnId) {
		return controlsMapper.selectById(cnId);
	}
	
	/*
	 *  查询所有控件信息
	 */
	@Override
	public List<Controls> selectAll() {
		ControlsExample example=new ControlsExample();
		return controlsMapper.selectByExample(example);
	}
	
	

}
