package com.hp.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hp.pojo.Controls;
import com.hp.pojo.ModeRecord;
import com.hp.pojo.Record;
import com.hp.pojo.State;
import com.hp.pojo.User;
import com.hp.service.ControlsService;
import com.hp.service.ModeRecordService;
import com.hp.service.RecordService;
import com.hp.service.StateService;

/**
 * @author 作者 : 王伟
 * @version 创建时间：2017年10月16日 上午11:14:19 类说明
 */
@Controller
@RequestMapping("/state")
public class StateController {
	@Autowired
	private StateService stateService;
	@Autowired
	private RecordService recordService;
	@Autowired
	private ControlsService controlsService;
	@Autowired
	private ModeRecordService modeRecordService;

	private Record record;

	private static User currentUser;


	Random random = new Random();

	// 查询当前用户所拥有的控件状态
	@RequestMapping("/queryState")
	public @ResponseBody List<State> queryState(HttpServletRequest request, HttpSession session) {
		currentUser = (User) request.getSession().getAttribute("currentuser");
		List<State> stateList = stateService.selectStateByUId(currentUser.getuId());
		List<Controls> list = new ArrayList<Controls>();
		for (State state : stateList) {
			Controls control = controlsService.selectById(state.getCnId());
			list.add(control);
		}
		session.setAttribute("stateList", list);
		return stateList;
	}

	// 查询当前用户所拥有的控件状态
	@SuppressWarnings("rawtypes")
	@RequestMapping("/queryStateNameN")
	public @ResponseBody Map<String,List> queryStateNameN(HttpServletRequest request, HttpSession session) {
		currentUser = (User) request.getSession().getAttribute("currentuser");
		List<State> stateList = stateService.selectStateByUId(currentUser.getuId());
		List<Controls> list = new ArrayList<Controls>();
		List<ModeRecord> list2 = new ArrayList<ModeRecord>();
		Map<String,List> map = new HashMap<String,List>();
		List<Controls> controls = new ArrayList<Controls>();
		for (State state : stateList) {
			Controls control = controlsService.selectById(state.getCnId());
			list.add(control);
		}
		map.put("info", list);
		int mId = Integer.parseInt(request.getParameter("mId"));
		list2 = modeRecordService.queryRecordsByUID(currentUser.getuId(), mId);
		if (list2.size() == 0) {
			if (mId == 1 || mId == 4) {
				list2 = modeRecordService.queryRecordsByUID(0, mId);
			}
		}
		for (ModeRecord m : list2) {
			controls.add(controlsService.selectById(m.getcnId()));
		}
		map.put("con", controls);
		return map;
	}

	// 根据控件id查询出控件名称
	@RequestMapping("/queryStateName")
	public @ResponseBody List<String> queryStateName(HttpServletRequest request, HttpSession session) {
		currentUser = (User) request.getSession().getAttribute("currentuser");
		List<State> list = queryState(request, session);
		List<String> names = new ArrayList<String>();
		for (State s : list) {
			if (s.getState() == 1) {
				names.add(stateService.queryStateName(s));
			}
		}
		return names;
	}

	// 增加控件
	@RequestMapping("/addState")
	public @ResponseBody State addState(HttpServletRequest request) {
		currentUser = (User) request.getSession().getAttribute("currentuser");
		Integer cnId = Integer.parseInt(request.getParameter("cnId"));
		Record record = recordService.queryRecordByInfo(currentUser.getuId(), cnId, currentUser.getCmId());
		State state1 = new State();
		state1.setuId(currentUser.getuId());
		state1.setCnId(cnId);
		state1.setOnoff(1);
		if(cnId==4||cnId==29){
			state1.setTemperature("26");
		}
		if(cnId==26){
			state1.setTemperature("55");
		}
		if(cnId==1||cnId==14||cnId==18||cnId==19||cnId==23||cnId==28){
			state1.setLight(1);
		}
		if(record!=null){
			state1.setState(1);
		}else{
			state1.setState(0);
		}
		stateService.addStateById(state1);
		return stateService.queryStateById(currentUser.getuId(), cnId);
	}

	// 删除控件
	@RequestMapping("/delState")
	public @ResponseBody int delState(HttpServletRequest request) {
		currentUser = (User) request.getSession().getAttribute("currentuser");
		Integer cnId = Integer.parseInt(request.getParameter("cnId"));
		modeRecordService.deleteRecordByCnId(currentUser.getuId(),cnId);
		stateService.delStateById(currentUser.getuId(), cnId);
		return 1;
	}

	/**
	 * 此部分为修改模块代码,根据页面传回的数据,以action为switch的参数
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/modState")
	public @ResponseBody State modState(HttpServletRequest request) {
		currentUser = (User) request.getSession().getAttribute("currentuser");
		String action = request.getParameter("action");
		Integer cnId = Integer.parseInt(request.getParameter("cnId"));
		State state2 = stateService.queryStateById(currentUser.getuId(), cnId);
		String onoff1 = request.getParameter("onoff");
		int dg[] = { 1, 14, 18, 19, 23, 28 };
		int kt[] = { 4, 29 };
		int rsq[] = { 26 };
		switch (action) {
		case "modState":
			int onoff = 2;
			if (onoff1.equals("开启")) {
				onoff = 0;
			} else if (onoff1.equals("关闭")) {
				onoff = 1;
			}
			Integer light = Integer.parseInt(request.getParameter("light"));
			String tem = request.getParameter("tem");
			state2.setOnoff(onoff);
			state2.setLight(light);
			state2.setTemperature(tem);
			stateService.modState(state2);
			break;
		case "modAction":
			int onoff2 = 2;
			if (onoff1.equals("开启")) {
				onoff2 = 1;
				for (int i : dg) {
					if (cnId == i) {
						state2.setLight(1);
					}
				}
				for (int i : kt) {
					if (cnId == i) {
						state2.setTemperature("26");
					}
				}
				for (int i : rsq) {
					if (cnId == i) {
						state2.setTemperature("55");
					}
				}
			} else if (onoff1.equals("关闭")) {
				onoff2 = 0;
				for (int i : dg) {
					if (cnId == i) {
						state2.setLight(0);
					}
				}
				for (int i : kt) {
					if (cnId == i) {
						state2.setTemperature("0");
					}
				}
				for (int i : rsq) {
					if (cnId == i) {
						state2.setTemperature("0");
					}
				}
			}
			state2.setOnoff(onoff2);
			stateService.modState(state2);
			break;
		case "handleException":
			currentUser = (User) request.getSession().getAttribute("currentuser");
			Record record = recordService.queryRecordByInfo(currentUser.getuId(), cnId, currentUser.getCmId());
			record.setHandle(1);
			record.setHandler("用户");
			record.setHandletime(new Date());
			recordService.modRecordByUser(record);
			state2.setState(0);
			stateService.modState(state2);
			break;
		}
		return stateService.queryStateById(currentUser.getuId(), cnId);
	}

	/**
	 * 以下六个方法为各个场景的数据库回传方法,较为雷同,故不一一赘述 在底层以场景为单位进行分别传回数据,在页面以ajax的方式取到数据
	 * 方法中,当取到传回数据,判断state属性是否为1为指标来判断控件是否异常,如异常,则录入异常记录表
	 * 在录入异常记录表时,先查询异常记录表是否有已存在的记录,以uid\cnid\handle三个数据辨别出唯一确定记录
	 * 如记录已存在,则此异常不做录入,如不存在,则录入异常记录表
	 * 
	 * @param request
	 * @return
	 */
	// 分场景查询状态：客厅状态查询
	@RequestMapping("queryParState")
	public @ResponseBody List<State> queryParState(HttpServletRequest request) {
		currentUser = (User) request.getSession().getAttribute("currentuser");
		List<State> list = stateService.queryParState(currentUser.getuId());
		for (State s : list) {
			if (s.getState() == 1) {
				record = recordService.queryRecordByInfo(currentUser.getuId(), s.getCnId(), currentUser.getCmId());
				if (record == null) {
					record = new Record();
					record.setuId(currentUser.getuId());
					record.setCnId(s.getCnId());
					record.setCmId(currentUser.getCmId());
					record.setCreatetime(new Date());
					record.setHandle(0);
					recordService.addRecord(record);
				}

			}
		}
		return stateService.queryParState(currentUser.getuId());
	}

	// 分场景查询状态：卧室状态查询
	@RequestMapping("queryBedState")
	public @ResponseBody List<State> queryBedState(HttpServletRequest request) {
		currentUser = (User) request.getSession().getAttribute("currentuser");
		List<State> list = stateService.queryBedState(currentUser.getuId());
		for (State s : list) {
			if (s.getState() == 1) {
				record = recordService.queryRecordByInfo(currentUser.getuId(), s.getCnId(), currentUser.getCmId());
				if (record == null) {
					record = new Record();
					record.setuId(currentUser.getuId());
					record.setCnId(s.getCnId());
					record.setCmId(currentUser.getCmId());
					record.setCreatetime(new Date());
					record.setHandle(0);
					recordService.addRecord(record);
				}

			}
		}
		return stateService.queryBedState(currentUser.getuId());
	}

	// 分场景查询状态：厨房状态查询
	@RequestMapping("queryKitState")
	public @ResponseBody List<State> queryKitState(HttpServletRequest request) {
		currentUser = (User) request.getSession().getAttribute("currentuser");
		List<State> list = stateService.queryKitState(currentUser.getuId());
		for (State s : list) {
			if (s.getState() == 1) {
				record = recordService.queryRecordByInfo(currentUser.getuId(), s.getCnId(), currentUser.getCmId());
				if (record == null) {
					record = new Record();
					record.setuId(currentUser.getuId());
					record.setCnId(s.getCnId());
					record.setCmId(currentUser.getCmId());
					record.setCreatetime(new Date());
					record.setHandle(0);
					recordService.addRecord(record);
				}
			}
		}
		return stateService.queryKitState(currentUser.getuId());
	}

	// 分场景查询状态：餐厅状态查询
	@RequestMapping("queryDinState")
	public @ResponseBody List<State> queryDinState(HttpServletRequest request) {
		currentUser = (User) request.getSession().getAttribute("currentuser");
		List<State> list = stateService.queryDinState(currentUser.getuId());
		for (State s : list) {
			if (s.getState() == 1) {
				record = recordService.queryRecordByInfo(currentUser.getuId(), s.getCnId(), currentUser.getCmId());
				if (record == null) {
					record = new Record();
					record.setuId(currentUser.getuId());
					record.setCnId(s.getCnId());
					record.setCmId(currentUser.getCmId());
					record.setCreatetime(new Date());
					record.setHandle(0);
					recordService.addRecord(record);
				}
			}
		}
		return stateService.queryDinState(currentUser.getuId());
	}

	// 分场景查询状态：阳台状态查询
	@RequestMapping("queryBalState")
	public @ResponseBody List<State> queryBalState(HttpServletRequest request) {
		currentUser = (User) request.getSession().getAttribute("currentuser");
		List<State> list = stateService.queryBalState(currentUser.getuId());
		for (State s : list) {
			if (s.getState() == 1) {
				record = recordService.queryRecordByInfo(currentUser.getuId(), s.getCnId(), currentUser.getCmId());
				if (record == null) {
					record = new Record();
					record.setuId(currentUser.getuId());
					record.setCnId(s.getCnId());
					record.setCmId(currentUser.getCmId());
					record.setCreatetime(new Date());
					record.setHandle(0);
					recordService.addRecord(record);
				}

			}
		}
		return stateService.queryBalState(currentUser.getuId());
	}

	// 分场景查询状态：浴室状态查询
	@RequestMapping("queryBathState")
	public @ResponseBody List<State> queryBathState(HttpServletRequest request) {
		currentUser = (User) request.getSession().getAttribute("currentuser");
		List<State> list = stateService.queryBathState(currentUser.getuId());
		for (State s : list) {
			if (s.getState() == 1) {
				record = recordService.queryRecordByInfo(currentUser.getuId(), s.getCnId(), currentUser.getCmId());
				if (record == null) {
					record = new Record();
					record.setuId(currentUser.getuId());
					record.setCnId(s.getCnId());
					record.setCmId(currentUser.getCmId());
					record.setCreatetime(new Date());
					record.setHandle(0);
					recordService.addRecord(record);
				}
			}
		}
		return stateService.queryBathState(currentUser.getuId());
	}

}
