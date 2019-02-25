package com.hp.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hp.pojo.Community;
import com.hp.pojo.CommunityExample;
import com.hp.pojo.Controls;
import com.hp.pojo.QueryRecord;
import com.hp.pojo.Record;
import com.hp.pojo.User;
import com.hp.service.CommunityService;
import com.hp.service.ControlsService;
import com.hp.service.RecordService;
import com.hp.service.UserService;
import com.hp.utils.DateUtils;
import com.hp.utils.Page;

/**
 * @author 作者 : 王文帅
 * @version 创建时间：2017年10月22日 下午3:02:35 类说明
 */
@Controller
@SuppressWarnings({ "static-access", "rawtypes", "unchecked" })
public class RecordManagerController {
	@Autowired
	private RecordService recordService;
	@Autowired
	private ControlsService controlsService;
	@Autowired
	private CommunityService communityService;
	@Autowired
	private UserService userService;

	private DateUtils dateUtils;
	/*查询出所有小区的异常记录信息*/
	@RequestMapping("/record/list")
	public String list(String uName,QueryRecord queryRecord, Model model) {
		if(null!=uName && !"".equals(uName)){
			List<Integer> userList=null;
			List<Integer> userNull=new ArrayList<Integer>();
			userNull.add(-1);
			userList=userService.selectListByUserName(uName);
			if(userList.isEmpty()){
				queryRecord.setuId(userNull);
			}else{
				queryRecord.setuId(userList);
			}
		}
		List<Community> cmList = communityService.selectAllCommunity();
		List<Controls> controlsList = controlsService.selectAll();
		List<User> userList = userService.selectAll();
		model.addAttribute("userList", userList);
		model.addAttribute("controlsList", controlsList);
		model.addAttribute("cmList", cmList);
		model.addAttribute("starttime", queryRecord.getStarttime());
		model.addAttribute("endtime", queryRecord.getEndtime());
		Page<Record> page = recordService.selectByQueryRecord(queryRecord);
		model.addAttribute("page", page);
		model.addAttribute("uName", uName);
		model.addAttribute("cnId", queryRecord.getCnId());
		model.addAttribute("cmId", queryRecord.getCmId());
		model.addAttribute("handle", queryRecord.getHandle());
		model.addAttribute("handler", queryRecord.getHandler());
		return "recordmanager";
	}

	
	@RequestMapping("/record/selectByWeekEveryDayManager")
	public @ResponseBody Map<String, Object> selectByWeekEveryDayManager(Model model, HttpServletRequest request,
			HttpServletResponse response) throws ParseException {
		String starttime = dateUtils.getBeginDayOfWeek().toString();
		String endtime = dateUtils.getEndDayOfWeek().toString();
		List selectByWeekEveryDay = recordService.selectByWeekEveryDay(starttime, endtime, 0);
		List selectByWeekDate = recordService.selectByWeekDate(starttime, endtime, 0);
		List week = new ArrayList<>();
		// 将从数据库中的到的一周的日期转换成对应的一周中的星期几
		for (int i = 0; i < selectByWeekDate.size(); i++) {
			// 1.格式转换
			SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
			String str = selectByWeekDate.get(i).toString();
			Date date = dateFormatter.parse(str);
			// 2.得到指定日期为一周中的第几天，从0开始
			Calendar c = Calendar.getInstance();
			c.setTime(date);
			int j = c.get(Calendar.DAY_OF_WEEK) - 1;
			if (j == 0) {
				j = 7;
			}
			// 3.存入数组
			week.add(j);
		}
		// 将一周中没有异常的星期几的异常数设置为0
		List weeks = new ArrayList<>();
		for (int i = 0; i < 7; i++) {
			weeks.add(0);
		}
		int index = 0;
		for (int i = 1; i <= 7; i++) {
			if (week.contains(i) && index < 5) {
				weeks.set(i - 1, selectByWeekEveryDay.get(index));
				index++;
			}
		}
		Map<String, Object> map = new HashMap<String, Object>();
		if (weeks != null) {
			map.put("errorlist", weeks);
		}
		return map;
	}

	// 查询从系统运营到当前日期每一天的异常数
	@RequestMapping("/record/selectByEveryDayManager")
	public @ResponseBody Map<String, Object> selectByEveryDayManager(Model model, HttpServletRequest request,
			HttpServletResponse response) {

		Map<String, Object> map = new HashMap<String, Object>();
		List selectByEveryDay = recordService.selectByAllErrors(0);
		List allDate = recordService.selectAllDate(0);
		if (selectByEveryDay != null && allDate != null) {

			map.put("errorlist", selectByEveryDay);
			map.put("datelist", allDate);
		}
		return map;
	}

	// 查询本年每月的异常数
	@RequestMapping("/record/selectByMonthEveryDayMonth")
	public @ResponseBody Map<String, Object> selectByMonthEveryDayMonth(String selectYear,Model model, HttpServletRequest request,
			HttpServletResponse response) {

		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println(selectYear);
		String starttime = selectYear+"-01-01";
		String endtime = selectYear+"-12-31";
		List selectRecordByEveryMonthSuperManager = recordService.selectRecordByEveryMonthSuperManager(starttime, endtime);
		List selectMonthSuperManager = recordService.selectMonthSuperManager(starttime, endtime);
		if (selectRecordByEveryMonthSuperManager != null && selectMonthSuperManager != null) {

			map.put("errorlist", selectRecordByEveryMonthSuperManager);
			map.put("datelist", selectMonthSuperManager);
		}
		return map;
	}

	// 查询每年的异常数
	
	@RequestMapping("/record/selectByYearEveryDayManager")
	public @ResponseBody Map<String, Object> selectByYearEveryDayManager(Model model, HttpServletRequest request,
			HttpServletResponse response) {

		Map<String, Object> map = new HashMap<String, Object>();
		List selectRecordByEveryYearSuperManager = recordService.selectRecordByEveryYearSuperManager();
		List selectYearSuperManager = recordService.selectYearSuperManager();
		if (selectRecordByEveryYearSuperManager != null && selectYearSuperManager != null) {

			map.put("errorlist", selectRecordByEveryYearSuperManager);
			map.put("datelist", selectYearSuperManager);
		}
		return map;
	}

	// 查询用户指定时间段内每一天的异常数
	@RequestMapping("/record/selectByCustomEveryDayManager")
	public @ResponseBody Map<String, Object> selectByCustomEveryDayManager(String starttime, String endtime,
			Model model, HttpServletRequest request, HttpServletResponse response) {

		Map<String, Object> map = new HashMap<String, Object>();
		List selectByMonthEveryDay = null;
		List selectByMonthDate = null;
		if (starttime != null && endtime != null) {
			selectByMonthEveryDay = recordService.selectByMonthEveryDay(starttime, endtime, 0);
			selectByMonthDate = recordService.selectByMonthDate(starttime, endtime, 0);
		} else if (starttime == null && endtime == null) {
			selectByMonthEveryDay = recordService.selectByAllErrors(0);
			selectByMonthDate = recordService.selectAllDate(0);
		} else if (starttime == null && endtime != null) {
			selectByMonthEveryDay = recordService.selectByMonthEveryDay("1970-01-01", endtime, 0);
			selectByMonthDate = recordService.selectByMonthDate("1970-01-01", endtime, 0);
		} else {
			Date date = new Date();
			String end = date.toString();
			selectByMonthEveryDay = recordService.selectByMonthEveryDay(starttime, end, 0);
			selectByMonthDate = recordService.selectByMonthDate(starttime, end, 0);
		}

		if (selectByMonthEveryDay != null && selectByMonthDate != null) {

			map.put("errorlist", selectByMonthEveryDay);
			map.put("datelist", selectByMonthDate);
		}
		return map;
	}

	// 查询本年每一天的异常数
	@RequestMapping("/record/selectByCommunityManager")
	public @ResponseBody Map<String, Object> selectByCommunityManager(Model model, HttpServletRequest request,
			HttpServletResponse response) {

		Map<String, Object> map = new HashMap<String, Object>();
		List selectByCommunity = recordService.selectByCommunity();
		List selectCommName = recordService.selectCommName();
		if (selectByCommunity != null && selectCommName != null) {

			map.put("errorlist", selectByCommunity);
			map.put("datelist", selectCommName);
		}
		return map;
	}

}
