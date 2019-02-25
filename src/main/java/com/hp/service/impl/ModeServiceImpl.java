package com.hp.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hp.mapper.ModeMapper;
import com.hp.pojo.Mode;
import com.hp.service.ModeService;

/** 
* @author 作者 : 王伟
* @version 创建时间：2017年11月8日 下午5:55:53 
* 类说明 
*/
@Service("modeService")
public class ModeServiceImpl implements ModeService {
	@Autowired
	private ModeMapper modeMapper;
	
	@Override
	public int addMode(Mode mode) {
		
		return modeMapper.insert(mode);
	}

}
