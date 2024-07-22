package com.spring.javaclassS16.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS16.vo.WorkProgressVO;
import com.spring.javaclassS16.vo.WorkVO;

public interface WorkDAO {

	public List<Map<String, Object>> getWorkList(@Param("familyCode") String familyCode, 
	     @Param("category") String category, @Param("status") String status, 
	     @Param("memberFilter") String memberFilter, @Param("sortBy") String sortBy, 
	     @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, 
	     @Param("memberIdx") int memberIdx);

	public Map<String, Integer> getDashboardData(@Param("familyCode") String familyCode);

	public WorkProgressVO getLatestWorkProgress(@Param("idx") int idx);

	public int calculateDaysLeft(@Param("endDate") String endDate);

	public List<Map<String, Object>> getFamilyMemberProgress(@Param("familyCode") String familyCode);

	public boolean addTask(@Param("workVO") WorkVO workVO);

	public boolean updateTaskStatus(@Param("houseworkIdx") int houseworkIdx, @Param("newStatus") String newStatus, @Param("memberIdx") int memberIdx);

	public Map<String, Object> getTaskDetails(@Param("houseworkIdx") int houseworkIdx);

	public boolean addNewTask(@Param("taskData") Map<String, Object> taskData, @Param("familyCode") String familyCode);

	public int totRecCnt(@Param("familyCode") String familyCode);

	public int totRecCntSearch(@Param("search") String search, @Param("searchString") String searchString);

	public List<Map<String, Object>> getMyWorkList(@Param("familyCode") String familyCode, @Param("memberIdx") int memberIdx, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public boolean setCompleteTask(@Param("houseworkIdx") int houseworkIdx);
}
