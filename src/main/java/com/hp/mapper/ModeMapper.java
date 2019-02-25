package com.hp.mapper;

import com.hp.pojo.Mode;

public interface ModeMapper {
    int deleteByPrimaryKey(Integer mId);

    int insert(Mode record);

    int insertSelective(Mode record);

    Mode selectByPrimaryKey(Integer mId);

    int updateByPrimaryKeySelective(Mode record);

    int updateByPrimaryKey(Mode record);
    
}