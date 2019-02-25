package com.hp.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hp.pojo.QueryUserRecord;
import com.hp.pojo.User;
import com.hp.service.RecordService;
import com.hp.utils.Page;

/**
 * @author 作者 : 姚云鹏
 * @version 创建时间：2017年10月24日09:19:11 类说明：用户异常记录查询
 */
@Controller
public class UserRecordManagerController {
	@Autowired
	private RecordService recordService;

	@RequestMapping("user/recordlist")
	public @ResponseBody Map<String, Object> list(QueryUserRecord queryUserRecord, Model model,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 从session中获取到当前用户的id
		User user = (User) request.getSession().getAttribute("currentuser");
		queryUserRecord.setuId(user.getuId());
		// 打印一下从前台获得的对象
		// System.out.println(queryUserRecord);

		Page<QueryUserRecord> page = recordService.selectByQueryUserRecord(queryUserRecord);
		if (page != null) {
			// 计算一共有多少页
			int total = page.getTotal() / page.getSize() + 1;
			map.put("msg", page);
			map.put("total", total);
		} else {
			map.put("msg", "error");
		}
		return map;
	}

}
