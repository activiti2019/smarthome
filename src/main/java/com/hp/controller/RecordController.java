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

//import com.google.gson.Gson;
import com.hp.pojo.User;
import com.hp.service.RecordService;
import com.hp.utils.DateUtils;

/**
 * @author 作者 : 陈燕君
 * @version 创建时间：2017年10月18日 上午9:55:38
 * @description
 */
@Controller
@SuppressWarnings({ "static-access", "rawtypes", "unchecked" })
@RequestMapping("/record")
public class RecordController {

	@Autowired
	private RecordService recordService;
	private DateUtils dateUtils;
	
	@RequestMapping("/selectByWeekEveryDay")
	public @ResponseBody Map<String, Object> selectByWeekEveryDay(Model model, HttpServletRequest request,
			HttpServletResponse response) throws ParseException {
		User user = (User) request.getSession().getAttribute("currentuser");
		int uId = user.getuId();
		String starttime = dateUtils.getBeginDayOfWeek().toString();
		String endtime = dateUtils.getEndDayOfWeek().toString();
		List selectByWeekEveryDay = recordService.selectByWeekEveryDay(starttime, endtime, uId);
		List selectByWeekDate = recordService.selectByWeekDate(starttime, endtime, uId);
		System.out.println(selectByWeekEveryDay);
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
		List weeks = new ArrayList<>();
		for (int i = 0; i < 7; i++) {
			weeks.add(0);
		}
		System.out.println(weeks);
		int index = 0;
		// 将一周中没有异常的星期几的异常数设置为0
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

	// 查询用户从注册到当前日期每一天的异常数
	@RequestMapping("/selectByEveryDay")
	public @ResponseBody Map<String, Object> selectByEveryDay(Model model, HttpServletRequest request,
			HttpServletResponse response) {
		User user = (User) request.getSession().getAttribute("currentuser");
		int uId = user.getuId();
		Map<String, Object> map = new HashMap<String, Object>();
		List selectByEveryDay = recordService.selectByAllErrors(uId);
		List allDate = recordService.selectAllDate(uId);
		if (selectByEveryDay != null && allDate != null) {

			map.put("errorlist", selectByEveryDay);
			map.put("datelist", allDate);
		}
		return map;
	}

	// 查询用户本月每一天的异常数
	@RequestMapping("/selectByMonthEveryDay")
	public @ResponseBody Map<String, Object> selectByMonthEveryDay(Model model, HttpServletRequest request,
			HttpServletResponse response) {
		User user = (User) request.getSession().getAttribute("currentuser");
		int uId = user.getuId();
		Map<String, Object> map = new HashMap<String, Object>();
		String starttime = dateUtils.getBeginDayOfMonth().toString();
		String endtime = dateUtils.getEndDayOfMonth().toString();
		List selectByMonthEveryDay = recordService.selectByMonthEveryDay(starttime, endtime, uId);
		List selectByMonthDate = recordService.selectByMonthDate(starttime, endtime, uId);
		if (selectByMonthEveryDay != null && selectByMonthDate != null) {

			map.put("errorlist", selectByMonthEveryDay);
			map.put("datelist", selectByMonthDate);
		}
		return map;
	}

	// 查询用户本年每一天的异常数
	@RequestMapping("/selectByYearEveryDay")
	public @ResponseBody Map<String, Object> selectByYearEveryDay(Model model, HttpServletRequest request,
			HttpServletResponse response) {
		User user = (User) request.getSession().getAttribute("currentuser");
		int uId = user.getuId();
		Map<String, Object> map = new HashMap<String, Object>();
		String starttime = dateUtils.getBeginDayOfYear().toString();
		String endtime = dateUtils.getEndDayOfYear().toString();
		List selectByMonthEveryDay = recordService.selectByMonthEveryDay(starttime, endtime, uId);
		List selectByMonthDate = recordService.selectByMonthDate(starttime, endtime, uId);
		if (selectByMonthEveryDay != null && selectByMonthDate != null) {

			map.put("errorlist", selectByMonthEveryDay);
			map.put("datelist", selectByMonthDate);
		}
		return map;
	}

	// 查询用户指定时间段内每一天的异常数
	@RequestMapping("/selectByCustomEveryDay")
	public @ResponseBody Map<String, Object> selectByCustomEveryDay(String starttime, String endtime, Model model,
			HttpServletRequest request, HttpServletResponse response) {
		User user = (User) request.getSession().getAttribute("currentuser");
		int uId = user.getuId();
		Map<String, Object> map = new HashMap<String, Object>();
		List selectByMonthEveryDay = null;
		List selectByMonthDate = null;
		if (starttime != null && endtime != null) {
			selectByMonthEveryDay = recordService.selectByMonthEveryDay(starttime, endtime, uId);
			selectByMonthDate = recordService.selectByMonthDate(starttime, endtime, uId);
		} else if (starttime == null && endtime == null) {
			selectByMonthEveryDay = recordService.selectByAllErrors(uId);
			selectByMonthDate = recordService.selectAllDate(uId);
		} else if (starttime == null && endtime != null) {
			selectByMonthEveryDay = recordService.selectByMonthEveryDay("1970-01-01", endtime, uId);
			selectByMonthDate = recordService.selectByMonthDate("1970-01-01", endtime, uId);
		} else {
			Date date = new Date();
			String end = date.toString();
			selectByMonthEveryDay = recordService.selectByMonthEveryDay(starttime, end, uId);
			selectByMonthDate = recordService.selectByMonthDate(starttime, end, uId);
		}

		if (selectByMonthEveryDay != null && selectByMonthDate != null) {

			map.put("errorlist", selectByMonthEveryDay);
			map.put("datelist", selectByMonthDate);
		}
		return map;
	}
	
	// 查询用户本年每一天的异常数
		@RequestMapping("/selectByScene")
		public @ResponseBody Map<String, Object> selectByScene(int sceneid,Model model, HttpServletRequest request,
				HttpServletResponse response) {
			System.out.println(sceneid);
			User user = (User) request.getSession().getAttribute("currentuser");
			int uId = user.getuId();
			Map<String, Object> map = new HashMap<String, Object>();
			List selectBySceneId = recordService.selectBySceneId(sceneid, uId);
			List selectConNameBySceneId = recordService.selectConNameBySceneId(sceneid, uId);
			if (selectBySceneId != null && selectConNameBySceneId != null) {

				map.put("errorlist", selectBySceneId);
				map.put("connamelist", selectConNameBySceneId);
			}
			return map;
		}
}
