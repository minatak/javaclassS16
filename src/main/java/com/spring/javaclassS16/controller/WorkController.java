package com.spring.javaclassS16.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS16.pagination.PageProcess;
import com.spring.javaclassS16.service.MemberService;
import com.spring.javaclassS16.service.WorkService;
import com.spring.javaclassS16.vo.MemberVO;
import com.spring.javaclassS16.vo.PageVO;
import com.spring.javaclassS16.vo.WorkVO;

@Controller
@RequestMapping("/housework")
public class WorkController {
  
  @Autowired
  WorkService workService;
  
  @Autowired
  MemberService membreService;
  
  @Autowired
  PageProcess pageProcess;
  
  @RequestMapping(value = "/workMain", method = RequestMethod.GET)
  public String workMainGet(Model model, HttpSession session,
    @RequestParam(name="pag", defaultValue = "1", required = false) int pag,
    @RequestParam(name="pageSize", defaultValue = "12", required = false) int pageSize,
    @RequestParam(name="flag", required = false) String flag,
    @RequestParam(name="category", required = false) String category,
    @RequestParam(name="status", required = false) String status,
    @RequestParam(name="memberFilter", required = false) String memberFilter,
    @RequestParam(name="sortBy", defaultValue = "dueDate", required = false) String sortBy) {
    
    PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "work", "", "", session);
    String familyCode = (String) session.getAttribute("sFamCode");
    int memberIdx = (int) session.getAttribute("sIdx");
    
    // 'undefined' 값 처리
    category = "undefined".equals(category) ? null : category;
    status = "undefined".equals(status) ? null : status;
    memberFilter = "undefined".equals(memberFilter) ? null : memberFilter;
    List<Map<String, Object>> vos = new ArrayList<>();
    
    if (flag != null && flag.equals("mine") && !flag.equals("")) {
      vos = workService.getMyWorkList(familyCode, memberIdx, pageVO.getStartIndexNo(), pageSize);
    }
    else {
      vos = workService.getWorkList(familyCode, category, status, memberFilter, sortBy, pageVO.getStartIndexNo(), pageSize, memberIdx);
    }
    List<Map<String, Object>> familyMembers = workService.getFamilyMemberProgress(familyCode);
    
    Map<String, Integer> dashboardData = workService.getDashboardData(familyCode);
    
    // 중복 제거된 카테고리 목록 생성
    Set<String> uniqueCategories = new HashSet<>();
    for (Map<String, Object> vo : vos) {
      String taskCategory = (String) vo.get("category");
      if (taskCategory != null && !taskCategory.isEmpty()) {
        uniqueCategories.add(taskCategory);
      }
    }
    List<String> categories = new ArrayList<>(uniqueCategories);
    Collections.sort(categories);  // 카테고리 알파벳 순으로 정렬  
    
    model.addAttribute("vos", vos);
    model.addAttribute("pageVO", pageVO);
    model.addAttribute("category", category);
    model.addAttribute("status", status);
    model.addAttribute("memberFilter", memberFilter);
    model.addAttribute("sortBy", sortBy);
    model.addAttribute("familyMembers", familyMembers);
    model.addAttribute("dashboardData", dashboardData);
    model.addAttribute("categories", categories);  // 중복 제거된 카테고리 목록 추가
    
    return "housework/workMain";
  }
  
  @RequestMapping(value = "/workInput", method = RequestMethod.POST)
  public String workInputPost(WorkVO vo) {
	  String memberName = membreService.getMemberNameByIdx(vo.getMemberIdx());
  	vo.setMemberName(memberName);
  	
  	if(vo.getEndDate().trim().length() < 10) vo.setEndDate(null); 
  	
  	int res = workService.setWorkInput(vo);
		
		if(res != 0) return "redirect:/message/workInputOk";
		else return "redirect:/message/workInputNo";
  }
  
  @ResponseBody
  @RequestMapping(value = "/getTaskDetails", method = RequestMethod.GET)
  public WorkVO getTaskDetails(@RequestParam int idx) {
  	return workService.getTaskDetails(idx);
  }
  
  @RequestMapping(value = "/workUpdate", method = RequestMethod.POST)
  public String workUpdatePost(WorkVO vo) {
      String memberName = membreService.getMemberNameByIdx(vo.getMemberIdx());
      vo.setMemberName(memberName);
      
      if(vo.getEndDate().trim().length() < 10) vo.setEndDate(null); 

      int res = workService.setWorkUpdate(vo);
      
      if(res != 0) return "redirect:/message/workUpdateOk";
      else return "redirect:/message/workUpdateNo";
  }
  

	@RequestMapping(value = "/workDelete", method = RequestMethod.GET)
	public String noticeDeleteGet(int idx, HttpSession session,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {

		int res = workService.setWorkDelete(idx);

		if(res != 0) return "redirect:/message/workDeleteOk";
    else return "redirect:/message/workDeleteNo";
	}
  
  @ResponseBody
  @RequestMapping(value = "/complete", method = RequestMethod.POST)
  public Map<String, Object> completeTask(@RequestParam int houseworkIdx) {
    boolean success = workService.setCompleteTask(houseworkIdx);
    Map<String, Object> response = new HashMap<>();
    response.put("success", success);
    return response;
  }


  
  
}
