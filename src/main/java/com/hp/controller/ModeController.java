package com.hp.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hp.pojo.ModeRecord;
import com.hp.pojo.State;
import com.hp.pojo.User;
import com.hp.service.ModeRecordService;
import com.hp.service.StateService;
import com.hp.service.UserService;

/**
 * @author 作者 : 王伟
 * @version 创建时间：2017年10月23日 上午10:01:53 类说明
 */
@Controller
@RequestMapping("modeController")
public class ModeController {
	@Autowired
	private StateService stateService;
	@Autowired
	private UserService userService;
	@Autowired
	private ModeRecordService modeRecordService;

	/**
	 * 此方法为情景模式的controller方法,从页面传回的参数action作为是switch参数 以下为情景模式的描述
	 * 用户在家模式：开客厅空调，开热水器，开客厅，开影音。(atHome) 用户离家模式：关灯，关空调，关电视机，关音乐播放器(leave)
	 * 用户睡眠模式：关窗帘，关灯，关电视，关音乐播放器，关客厅空调(sleep) 用户起床模式：开热水器，开卧室窗帘(wakeUp)
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping("modeAction")
	public void modeAction(HttpServletRequest request, HttpServletResponse response) {
		User currentUser = (User) request.getSession().getAttribute("currentuser");
		List<Integer> arr = stateService.selectStateIdByUId(currentUser.getuId());
		int[] num = { 1, 3, 4, 6, 8, 9, 11, 12, 14, 18, 19, 21, 23, 24, 25, 26, 27, 28, 29 };
		List<ModeRecord> nums = null;
		// 所有灯光id
		int[] m = { 1, 14, 18, 19, 23, 28 };
		State state = new State();
		String action = request.getParameter("action");
		switch (action) {
		case "atHome":
			nums = modeRecordService.queryRecordsByUID(currentUser.getuId(), 1);
			if (nums.isEmpty()) {
				nums = modeRecordService.queryRecordsByUID(0, 1);
			}
			for (int i : arr) {
				for (int n : num) {
					if (i == n) {
						state = stateService.queryStateById(currentUser.getuId(), i);
						state.setOnoff(0);
						if (i == 29 || i == 4) {
							state.setTemperature("0");
						}
						if (i == 26) {
							state.setTemperature("0");
						}
						for (int j : m) {
							if (i == j) {
								state.setLight(0);
							}
						}
						// if (i == 4 || i == 29 || i == 26 || i == 3) {}
						for (ModeRecord modeRecord : nums) {
							if (modeRecord.getcnId() == i) {
								state.setOnoff(1);
								if (i == 29 || i == 4) {
									state.setTemperature("26");
								}
								if (i == 26) {
									state.setTemperature("55");
								}
								for (int j : m) {
									if (modeRecord.getcnId() == j) {
										state.setLight(1);
									}
								}
							}
						}

					}
				}
				stateService.modState(state);
			}
			currentUser.setMode(1);
			userService.updateByUser(currentUser);
			break;
		case "leave":
			nums = modeRecordService.queryRecordsByUID(currentUser.getuId(), 2);
			for (int i : arr) {
				for (int n : num) {
					if (i == n) {
						state = stateService.queryStateById(currentUser.getuId(), i);
						state.setOnoff(0);
						if (i == 29 || i == 4) {
							state.setTemperature("0");
						}
						if (i == 26) {
							state.setTemperature("0");
						}
						for (int j : m) {
							if (i == j) {
								state.setLight(0);
							}
						}
						if (!nums.isEmpty()) {
							for (ModeRecord modeRecord : nums) {
								if (modeRecord.getcnId() == i) {
									state.setOnoff(1);
									if (i == 29 || i == 4) {
										state.setTemperature("26");
									}
									if (i == 26) {
										state.setTemperature("55");
									}
									for (int j : m) {
										if (modeRecord.getcnId() == j) {
											state.setLight(1);
										}
									}
								}
								// if (i == 9 || i == 26) {
							}
						}
					}
				}
				stateService.modState(state);
			}
			currentUser.setMode(2);
			userService.updateByUser(currentUser);
			break;
		case "sleep":
			nums = modeRecordService.queryRecordsByUID(currentUser.getuId(), 3);
			// if (i == 1 || i == 3 || i == 4 || i == 9 || i == 11 || i == 14 ||
			// i == 18 || i == 19 || i == 2|| i == 23 || i == 24 || i == 26 || i
			// == 27 || i == 28) {
			for (int i : arr) {
				for (int n : num) {
					if (i == n) {
						state = stateService.queryStateById(currentUser.getuId(), i);
						state.setOnoff(0);
						if (i == 29 || i == 4) {
							state.setTemperature("0");
						}
						if (i == 26) {
							state.setTemperature("0");
						}
						for (int j : m) {
							if (i == j) {
								state.setLight(0);
							}
						}
						if (!nums.isEmpty()) {
							for (ModeRecord modeRecord : nums) {
								if (modeRecord.getcnId() == i) {
									state.setOnoff(1);
									if (i == 29 || i == 4) {
										state.setTemperature("26");
									}
									if (i == 26) {
										state.setTemperature("55");
									}
									for (int j : m) {
										if (modeRecord.getcnId() == j) {
											state.setLight(1);
										}
									}
								}
							}
						}
					}
				}
				stateService.modState(state);
			}
			currentUser.setMode(3);
			userService.updateByUser(currentUser);
			break;
		case "wakeUp":
			nums = modeRecordService.queryRecordsByUID(currentUser.getuId(), 4);
			if (nums.isEmpty()) {
				nums = modeRecordService.queryRecordsByUID(0, 4);
			}
			for (int i : arr) {
				for (int n : num) {
					if (i == n) {
						state = stateService.queryStateById(currentUser.getuId(), i);
						state.setOnoff(0);
						if (i == 29 || i == 4) {
							state.setTemperature("0");
						}
						if (i == 26) {
							state.setTemperature("0");
						}
						for (int j : m) {
							if (i == j) {
								state.setLight(0);
							}
						}
						for (ModeRecord modeRecord : nums) {
							if (modeRecord.getcnId() == i) {
								state.setOnoff(1);
								if (i == 29 || i == 4) {
									state.setTemperature("26");
								}
								if (i == 26) {
									state.setTemperature("55");
								}
								for (int j : m) {
									if (modeRecord.getcnId() == j) {
										state.setLight(1);
									}
								}
							}
							// if (i == 9 || i == 26) {
						}
					}
				}
				stateService.modState(state);
			}
			currentUser.setMode(4);
			userService.updateByUser(currentUser);
			break;
		case "diy":
			nums = modeRecordService.queryRecordsByUID(currentUser.getuId(), 5);
			for (int i : arr) {
				for (int n : num) {
					if (i == n) {
						state = stateService.queryStateById(currentUser.getuId(), i);
						state.setOnoff(0);
						if (i == 29 || i == 4) {
							state.setTemperature("0");
						}
						if (i == 26) {
							state.setTemperature("0");
						}
						for (int j : m) {
							if (i == j) {
								state.setLight(0);
							}
						}
						if (!nums.isEmpty()) {
							for (ModeRecord modeRecord : nums) {
								if (modeRecord.getcnId() == i) {
									state.setOnoff(1);
									if (i == 29 || i == 4) {
										state.setTemperature("26");
									}
									if (i == 26) {
										state.setTemperature("55");
									}
									for (int j : m) {
										if (modeRecord.getcnId() == j) {
											state.setLight(1);
										}
									}
								}
								// if (i == 9 || i == 26) {
							}
						}
					}
				}
				stateService.modState(state);
			}
			currentUser.setMode(5);
			userService.updateByUser(currentUser);
			break;
		}
		try {
			request.getRequestDispatcher("/compage/parlour.jsp").forward(request, response);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
	}

	/*
	 * @RequestMapping("/queryModeRecord") public @ResponseBody List<Controls>
	 * queryModeRecord(HttpServletRequest request) { User currentUser = (User)
	 * request.getSession().getAttribute("currentuser"); int mId = 5;
	 * List<ModeRecord> list =
	 * modeRecordService.queryRecordsByUID(currentUser.getuId(), mId);
	 * System.out.println(list); List<Controls> controls = new ArrayList(); for
	 * (ModeRecord m : list) {
	 * controls.add(controlsService.selectById(m.getcnId())); } return controls;
	 * }
	 */

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/addModeRecords")
	public @ResponseBody int addModeRecords(HttpServletRequest request) {
		User currentUser = (User) request.getSession().getAttribute("currentuser");
		String[] nums = request.getParameterValues("nums");
		int mId = Integer.parseInt(request.getParameter("mId"));
		List<Integer> list = new ArrayList<Integer>();
		List<ModeRecord> list1 = new ArrayList<ModeRecord>();
		if (nums != null) {
			for (String s : nums) {
				if (s.equals("")) {
				} else {
					list.add(Integer.parseInt(s));
				}
			}
		} else {
			modeRecordService.addModeRecord(currentUser, new ArrayList(), mId);
		}
		for (int i : list) {
			list1.add(new ModeRecord(currentUser.getuId(), i, mId));
		}
		modeRecordService.addModeRecord(currentUser, list1, mId);
		return 1;
	}

}
