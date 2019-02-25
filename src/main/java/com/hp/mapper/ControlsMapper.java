package com.hp.mapper;

import com.hp.pojo.Controls;
import com.hp.pojo.ControlsExample;
import com.hp.pojo.QueryControls;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ControlsMapper {
    int countByExample(ControlsExample example);
    
    //通过QueryControls查询信息条数 
    int countByQueryControls(QueryControls queryControls);

    int deleteByExample(ControlsExample example);

    int deleteByPrimaryKey(Integer cnId);

    int insert(Controls record);

    int insertSelective(Controls record);

    List<Controls> selectByExample(ControlsExample example);
    
    //通过queryControls查询所有符合条件的用户
    List<Controls> selectByQueryControls(QueryControls queryController);
    
    //通过controls进行管理员查询
    Controls selectByControls(Controls controls);

    Controls selectByPrimaryKey(Integer cnId);

    int updateByExampleSelective(@Param("record") Controls record, @Param("example") ControlsExample example);

    int updateByExample(@Param("record") Controls record, @Param("example") ControlsExample example);

    int updateByPrimaryKeySelective(Controls record);

    int updateByPrimaryKey(Controls record);
    
    List<Integer> selectControlsById(int userid);

	Controls selectById(Integer cnId);
}