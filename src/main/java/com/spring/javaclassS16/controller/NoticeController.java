package com.spring.javaclassS16.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS16.pagination.PageProcess;
import com.spring.javaclassS16.service.NoticeService;
import com.spring.javaclassS16.vo.MemberVO;
import com.spring.javaclassS16.vo.NoticeReadStatusVO;
import com.spring.javaclassS16.vo.NoticeReplyVO;
import com.spring.javaclassS16.vo.NoticeVO;
import com.spring.javaclassS16.vo.PageVO;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value = "/noticeList", method = RequestMethod.GET)
	public String noticeListGet(Model model, HttpSession session,
        @RequestParam(name="pag", defaultValue = "1", required = false) int pag,
        @RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
        @RequestParam(name="choice", defaultValue = "최신순", required = false) String choice) {
    PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "notice", "", "", session);
    String familyCode = (String) session.getAttribute("sFamCode");
    int memberIdx = (int) session.getAttribute("sIdx");

    ArrayList<NoticeVO> vos = noticeService.getNoticeList(familyCode, memberIdx, pageVO.getStartIndexNo(), pageSize, choice);

    model.addAttribute("vos", vos);
    model.addAttribute("pageVO", pageVO);
    model.addAttribute("choice", choice);

    return "notice/noticeList";
	}
	
	@RequestMapping(value = "/noticeInput", method = RequestMethod.GET)
	public String noticeInputGet(Model model) {
		return "notice/noticeInput";
	}
	
	@RequestMapping(value = "/noticeInput", method = RequestMethod.POST)
	public String noticeInputPost(NoticeVO vo) {
		if(vo.getContent().indexOf("src=\"/") != -1) noticeService.imgCheck(vo.getContent());
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/notice/"));
		int res = noticeService.setNoticeInput(vo);
		
		if(res != 0) return "redirect:/message/noticeInputOk";
		else return "redirect:/message/noticeInputNo";
	}
	
	@RequestMapping(value = "/noticeContent", method = RequestMethod.GET)
	public String noticeContentPost(int idx, Model model, HttpSession session,
	        @RequestParam(name="flag", defaultValue = "", required = false) String flag,
	        @RequestParam(name="search", defaultValue = "", required = false) String search,
	        @RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
	        @RequestParam(name="pag", defaultValue = "1", required = false) int pag,
	        @RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
	    
	    String familyCode = (String) session.getAttribute("sFamCode");
	    int memberIdx = (int) session.getAttribute("sIdx");

	    ArrayList<String> contentReadNum = (ArrayList<String>) session.getAttribute("sContentIdx");
	    if(contentReadNum == null) contentReadNum = new ArrayList<String>();
	    String imsiContentReadNum = "notice" + idx;
	    if(!contentReadNum.contains(imsiContentReadNum)) {
	        noticeService.setReadNumPlus(idx);
	        contentReadNum.add(imsiContentReadNum);
	    }
	    session.setAttribute("sContentIdx", contentReadNum);

	    NoticeVO vo = noticeService.getNoticeContent(idx);
	    
	    NoticeReadStatusVO nRSVo = noticeService.getReadStatus(idx, memberIdx);
	    if(nRSVo == null) noticeService.setNoticeRead(idx, memberIdx);

	    boolean isLiked = noticeService.getNoticeLike(idx, memberIdx);
	    
	    List<NoticeReplyVO> replyVos = noticeService.getNoticeReply(idx);
	    
	    NoticeVO preVo = noticeService.getPreNexSearch(idx, "preVo", familyCode);
	    NoticeVO nextVo = noticeService.getPreNexSearch(idx, "nextVo", familyCode);
	    
	    List<MemberVO> likers = noticeService.getNoticeLikers(idx);

	    model.addAttribute("vo", vo);
	    model.addAttribute("isLiked", isLiked);
	    model.addAttribute("replyVos", replyVos);
	    model.addAttribute("preVo", preVo);
	    model.addAttribute("nextVo", nextVo);
	    model.addAttribute("likers", likers);
	    model.addAttribute("flag", flag);
	    model.addAttribute("search", search);
	    model.addAttribute("searchString", searchString);
	    model.addAttribute("pag", pag);
	    model.addAttribute("pageSize", pageSize);

	    return "notice/noticeContent";
	}
	
	@RequestMapping(value = "/noticeUpdate", method = RequestMethod.GET)
	public String noticeUpdateGet(int idx, Model model, HttpSession session,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		NoticeVO vo = noticeService.getNoticeContent(idx);
		
		if(vo.getContent().indexOf("src=\"/") != -1) noticeService.imgBackup(vo.getContent());
		
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("vo", vo);
		return "notice/noticeUpdate";
	}
	
	@RequestMapping(value = "/noticeUpdate", method = RequestMethod.POST)
	public String noticeUpdatePost(NoticeVO vo, Model model, HttpSession session,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		String familyCode = (String) session.getAttribute("sFamCode");
		vo.setFamilyCode(familyCode);
		
		NoticeVO origVo = noticeService.getNoticeContent(vo.getIdx());
		
		if(!origVo.getContent().equals(vo.getContent())) {
			if(origVo.getContent().indexOf("src=\"/") != -1) noticeService.imgDelete(origVo.getContent());
			vo.setContent(vo.getContent().replace("/data/notice/", "/data/ckeditor/"));
			if(vo.getContent().indexOf("src=\"/") != -1) noticeService.imgCheck(vo.getContent());
			vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/notice/"));
		}
		int res = noticeService.setNoticeUpdate(vo);
	
		model.addAttribute("idx", vo.getIdx());
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		if(res != 0) return "redirect:/message/noticeUpdateOk";
		else return "redirect:/message/noticeUpdateNo?idx=" + vo.getIdx();
	}
	
	@Transactional
	@RequestMapping(value = "/noticeDelete", method = RequestMethod.GET)
	public String noticeDeleteGet(int idx, HttpSession session,
    @RequestParam(name="pag", defaultValue = "1", required = false) int pag,
    @RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
    
		// 1. 게시글에 사진이 존재한다면 서버에 저장된 사진을 삭제처리한다.
		NoticeVO vo = noticeService.getNoticeContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) noticeService.imgDelete(vo.getContent());
		 
		// 2. 관련된 읽음 상태 삭제
	  noticeService.deleteNoticeReadStatus(idx);
	 
	  // 3. 관련된 좋아요 삭제
	  noticeService.deleteNoticeLikes(idx);
	 
	  // 4. 관련된 댓글 삭제
	  noticeService.deleteNoticeReplies(idx);
	 
	  // 5. 공지사항 삭제
		int res = noticeService.setNoticeDelete(idx);
		
		if(res != 0) {
		   return "redirect:/message/noticeDeleteOk?pag="+pag+"&pageSize="+pageSize;
		} else {
		   return "redirect:/message/noticeDeleteNo?idx="+idx+"&pag="+pag+"&pageSize="+pageSize;
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/noticeReplyInput", method = RequestMethod.POST)
	public String noticeReplyInputPost(NoticeReplyVO replyVO, HttpSession session) {
    String name = (String) session.getAttribute("sName");
    replyVO.setName(name);
    
    //replyVO.setParentIdx(0);  // 부모 댓글이므로 parentIdx는 0
    
    int res = noticeService.setNoticeReplyInput(replyVO);
    
    return res+"";
	}
	
	@Transactional
	@ResponseBody
	@RequestMapping(value = "/noticeReplyDelete", method = RequestMethod.POST)
	public String noticeReplyDelete(@RequestParam int idx) {
    NoticeReplyVO vo = noticeService.getNoticeReplyVo(idx);
    
    // 부모 댓글인 경우 (parentIdx가 null 또는 0)
    if(vo.getParentIdx() == null || vo.getParentIdx() == 0) {
      // 먼저 대댓글들을 삭제
      noticeService.setNoticeReplyDeleteByParentIdx(idx);
    }
    
    // 그 다음 해당 댓글 삭제 (부모 댓글이든 대댓글이든)
    return noticeService.setNoticeReplyDelete(idx);
	}
	
  @ResponseBody
  @RequestMapping(value = "/noticeToggleLike", method = RequestMethod.POST)
  public String noticeToggleLike(@RequestParam int idx, HttpSession session) {
    int memberIdx = (int) session.getAttribute("sIdx");
    
    return noticeService.toggleNoticeLike(idx, memberIdx);
  }
	
  
  @RequestMapping(value = "/noticeSearch")
  public String noticeSearchPost(Model model, HttpSession session, 
      @RequestParam(name="search", defaultValue = "title", required = false) String search,
      @RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
      @RequestParam(name="pag", defaultValue = "1", required = false) int pag,
      @RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
      @RequestParam(name="choice", defaultValue = "최신순", required = false) String choice) {
    String familyCode = (String) session.getAttribute("sFamCode");
    int memberIdx = (int) session.getAttribute("sIdx");
    
    // 페이지네이션을 위한 PageVO 객체 생성
    PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "notice", search, searchString, session);
    
    // 검색 결과의 총 개수를 가져오는 로직  
    int totalSearchCount = noticeService.getTotalSearchCount(familyCode, search, searchString);
    
    List<NoticeVO> vos = noticeService.getNoticeSearchList(familyCode, memberIdx, pageVO.getStartIndexNo(), pageSize, search, searchString, choice);
    
    String searchTitle = "";
    if(search.equals("title")) searchTitle = "글제목";
    else if(search.equals("memberName")) searchTitle = "글쓴이";
    else searchTitle = "글내용";
    
    model.addAttribute("vos", vos);
    model.addAttribute("pageVO", pageVO);
    model.addAttribute("searchTitle", searchTitle);
    model.addAttribute("search", search);
    model.addAttribute("searchString", searchString);
    model.addAttribute("searchCount", totalSearchCount);
    model.addAttribute("choice", choice);
    
    return "notice/noticeSearchList";
  }

}