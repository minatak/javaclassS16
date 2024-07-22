package com.spring.javaclassS16.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS16.dao.WorkDAO;
import com.spring.javaclassS16.vo.WorkProgressVO;
import com.spring.javaclassS16.vo.WorkVO;

@Service
public class WorkServiceImpl implements WorkService {

	@Autowired
	WorkDAO workDAO;

//	@Override
//	public List<Map<String, Object>> getWorkList(String familyCode, String choice, int startIndexNo, int pageSize) {
//		return workDAO.getWorkList(familyCode, choice, startIndexNo, pageSize);
//	}
//	@Override
//	public List<Map<String, Object>> getWorkList(Map<String, Object> params) {
//		return workDAO.getWorkList(params);
//	}
	@Override
	public List<Map<String, Object>> getWorkList(String familyCode, String category, String status, 
	    String memberFilter, String sortBy, int startIndexNo, int pageSize, int memberIdx) {
		return workDAO.getWorkList(familyCode, category, status, memberFilter, sortBy, startIndexNo, pageSize, memberIdx);
	}
	

	@Override
	public Map<String, Integer> getDashboardData(String familyCode) {
		return workDAO.getDashboardData(familyCode);
	}

	@Override
	public WorkProgressVO getLatestWorkProgress(int idx) {
		return workDAO.getLatestWorkProgress(idx);
	}

	@Override
	public int calculateDaysLeft(String endDate) {
		return workDAO.calculateDaysLeft(endDate);
	}

	@Override
	public List<Map<String, Object>> getFamilyMemberProgress(String familyCode) {
		return workDAO.getFamilyMemberProgress(familyCode);
	}

	@Override
	public boolean addTask(WorkVO workVO) {
		return workDAO.addTask(workVO);
	}

	@Override
	public boolean updateTaskStatus(int houseworkIdx, String newStatus, int memberIdx) {
		return workDAO.updateTaskStatus(houseworkIdx, newStatus, memberIdx);
	}

	@Override
	public Map<String, Object> getTaskDetails(int houseworkIdx) {
		return workDAO.getTaskDetails(houseworkIdx);
	}

	@Override
	public boolean addNewTask(Map<String, Object> taskData, String familyCode) {
		return workDAO.addNewTask(taskData, familyCode);
	}


	@Override
	public List<Map<String, Object>> getMyWorkList(String familyCode, int memberIdx, int startIndexNo, int pageSize) {
		return workDAO.getMyWorkList(familyCode, memberIdx, startIndexNo, pageSize);
	}


	@Override
	public boolean setCompleteTask(int houseworkIdx) {
		return workDAO.setCompleteTask(houseworkIdx);
	}



	
}
