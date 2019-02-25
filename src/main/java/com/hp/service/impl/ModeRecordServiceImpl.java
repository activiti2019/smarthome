package com.hp.service.impl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hp.mapper.ModeRecordMapper;
import com.hp.pojo.ModeRecord;
import com.hp.pojo.User;
import com.hp.service.ModeRecordService;

/**
 * @author 作者 : 王伟
 * @version 创建时间：2017年11月8日 下午5:56:16 类说明
 */

@Service("modeRecordService")
public class ModeRecordServiceImpl implements ModeRecordService {
	@Autowired
	private ModeRecordMapper modeRecordMapper;

	@SuppressWarnings("unused")
	@Override
	public int addModeRecord(User user, List<ModeRecord> modeRecords,Integer mId) {
		// 表里原数据
		List<ModeRecord> list = modeRecordMapper.queryRecordsByUID(user.getuId(), mId);
		List<ModeRecord> bothList = new ArrayList();
		List<ModeRecord> extraList = new ArrayList();
		if (modeRecords.size() != 0) {
			// 真实数据
			for (ModeRecord m : modeRecords) {
				// 原数据
				if (list.size() == 0) {
					if (modeRecords != null) {
						modeRecordMapper.insertModeRecords(modeRecords);
						return 1;
					}
				} else if (list.size() != 0) {
					for (ModeRecord n : list) {
						if (m.getcnId() == n.getcnId()) {
							bothList.add(m);
						}
					}
				}
			}
			if (bothList.size() == 0) {
				modeRecordMapper.deleteRecordsByUID(user.getuId(), mId);
				if (modeRecords != null) {
					modeRecordMapper.insertModeRecords(modeRecords);
				}
				return 1;
			} else {
				// 真实数据,当交集
				/*
				 * if (m.getcnId() != bList.getcnId()) { set.add(m.getcnId()); }
				 */
				/**
				 * 使用迭代器遍历删除
				 */
				Iterator<ModeRecord> it = modeRecords.iterator();
				while (it.hasNext()) {
					ModeRecord record = it.next();
					for (ModeRecord bList : bothList) {
						if (record.equals(bList)) {
							it.remove();// remove the current item
						}
					}
				}
				// 原数据

				Iterator<ModeRecord> it1 = list.iterator();
				while (it1.hasNext()) {
					ModeRecord record = it1.next();
					for (ModeRecord bList : bothList) {
						if (record.getcnId() == bList.getcnId()) {
							it1.remove();// remove the current item
						}
					}
				}
				int[] nums = new int[30];
				for (int i = 0; i < list.size(); i++) {
					nums[i]=list.get(i).getcnId();
				}
				/*
				 * for (Iterator it = set.iterator(); it.hasNext();) { int cnId
				 * = Integer.parseInt(it.next().toString()); ModeRecord
				 * modeRecord = new ModeRecord(user.getuId(), cnId,
				 * user.getMode()); extraList.add(modeRecord); }
				 */

				if (modeRecords.size() != 0) {
					modeRecordMapper.insertModeRecords(modeRecords);
				}
				if (nums[0] != 0) {
					modeRecordMapper.deleteRecordsByCnId(user.getuId(), nums, mId);
					return 1;
				}
			}
		} else {
			modeRecordMapper.deleteRecordsByUID(user.getuId(), mId);
			return 1;
		}
		return 1;
	}

	@Override
	public List<ModeRecord> queryRecordsByUID(Integer uId, Integer mId) {
		List<ModeRecord> list = modeRecordMapper.queryRecordsByUID(uId, mId);
		return list;
	}

	@Override
	public int deleteRecordByCnId(Integer uId, Integer cnId) {
		modeRecordMapper.deleteRecordByCnId(uId, cnId);
		return 0;
	}

}
