package com.spring.javaclassS16.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS16.service.PhotoService;
import com.spring.javaclassS16.vo.MemberVO;
import com.spring.javaclassS16.vo.PhotoReplyVO;
import com.spring.javaclassS16.vo.PhotoVO;

@Controller
@RequestMapping("/photo")
public class PhotoController {

    @Autowired
    private PhotoService photoService;

    @RequestMapping(value = "/photoList", method = RequestMethod.GET)
    public String photoList(Model model,
                            HttpSession session,
                            @RequestParam(defaultValue = "1") int pag,
                            @RequestParam(defaultValue = "16") int pageSize,
                            @RequestParam(defaultValue = "최신순") String choice) {
        String familyCode = (String) session.getAttribute("sFamCode");
        int startIndexNo = (pag - 1) * pageSize;
        
        ArrayList<PhotoVO> vos = photoService.getPhotoList(startIndexNo, pageSize, familyCode, choice);
        
        model.addAttribute("vos", vos);
        model.addAttribute("choice", choice);
        return "photo/photoList";
    }
    
    // 사진 업로드 폼보기
    @RequestMapping(value = "/photoInput", method = RequestMethod.GET)
    public String photoInputForm() {
        return "photo/photoInput";
    }

    // 사진 업로드
    @RequestMapping(value = "/photoInput", method = RequestMethod.POST)
    public String photoInputProcess(PhotoVO vo, HttpServletRequest request, HttpSession session) {
        String mid = (String) session.getAttribute("sMid");
        String familyCode = (String) session.getAttribute("sFamCode");
        
        MemberVO mVo = photoService.getMemberVoByMid(mid);
        
        vo.setMemberIdx(mVo.getIdx());
        vo.setName(mVo.getName());
        vo.setFamilyCode(familyCode);
        
        int res = photoService.setPhotoInput(vo);
        
        if(res != 0) return "redirect:/message/photoInputOk";
        else return "redirect:/message/photoInputNo";
    }

    // 사진 보기 처리
    @RequestMapping(value = "/photoContent", method = RequestMethod.GET)
    public String photoContent(@RequestParam int idx, Model model, HttpSession session,
    		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
  			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
    	PhotoVO vo = photoService.getPhotoContent(idx);
      
      MemberVO mVo = photoService.getWriterPhoto(vo.getMemberIdx());
      String photo = mVo.getPhoto();
      int memberIdx = (int) session.getAttribute("sIdx");
      boolean isLiked = photoService.getPhotoLike(idx, memberIdx);
      
      int replyCnt = photoService.getPhotoReplyCount(idx);
      
      PhotoReplyVO latestReply = photoService.getLatestReply(idx);

      vo.setMid(mVo.getMid());
      
      model.addAttribute("isLiked", isLiked);
      
      model.addAttribute("vo", vo);
      model.addAttribute("photo", photo);
      model.addAttribute("replyCnt", replyCnt);
      model.addAttribute("latestReply", latestReply);
      
      model.addAttribute("pag", pag);
  		model.addAttribute("pageSize", pageSize);
      
      // 이전글/다음글 가져오기
  		PhotoVO preVo = photoService.getPreNexSearch(idx, "preVo");
  		PhotoVO nextVo = photoService.getPreNexSearch(idx, "nextVo");
  		model.addAttribute("preVo", preVo);
  		model.addAttribute("nextVo", nextVo);
  		
  		// 댓글(대댓글) 추가 입력처리
  		List<PhotoReplyVO> replyVos = photoService.getPhotoReply(idx);
  		model.addAttribute("replyVos", replyVos);
  		
      return "photo/photoContent";
    }

    @ResponseBody
    @RequestMapping(value = "/photoToggleLike", method = RequestMethod.POST)
    public String photoToggleLike(@RequestParam int idx, HttpSession session) {
        return photoService.togglePhotoLike(idx, session);
    }

    @ResponseBody
    @RequestMapping(value = "/photoReplyDelete", method = RequestMethod.POST)
    public String photoReplyDelete(@RequestParam int idx) {
    	return photoService.setPhotoReplyDelete(idx);
    }

    @ResponseBody
    @RequestMapping("/imageUpload")
    public void imageUpload(HttpServletRequest request, HttpServletResponse response, MultipartFile upload) throws Exception {
        photoService.imageUpload(request, response, upload);
    }
    
    // 페이징 처리 (무한스크롤)
    @RequestMapping(value = "/photoPaging", method = RequestMethod.POST)
    public String photoPaging(Model model,
                              HttpSession session,
                              @RequestParam(defaultValue = "1") int pag,
                              @RequestParam(defaultValue = "16") int pageSize,
                              @RequestParam(defaultValue = "최신순") String choice) {
        String familyCode = (String) session.getAttribute("sFamCode");
        int startIndexNo = (pag - 1) * pageSize;
        
        ArrayList<PhotoVO> vos = photoService.getPhotoList(startIndexNo, pageSize, familyCode, choice);
        
        model.addAttribute("vos", vos);
        model.addAttribute("hasMore", vos.size() == pageSize);  // 더 로드할 항목이 있는지 확인
        
        return "photo/photoPaging";
    }
    
  	// 부모댓글 입력처리(원본글에 대한 댓글)
  	@ResponseBody
  	@RequestMapping(value = "/photoReplyInput", method = RequestMethod.POST)
  	public String photoReplyInputPost(PhotoReplyVO replyVO) {
  		// 부모댓글의 경우는 re_step=0, re_order=1로 처리.(단, 원본글의 첫번째 부모댓글은 re_order=1이지만, 2번이상은 마지막부모댓글의 re_order보다 +1처리 시켜준다.
  		PhotoReplyVO replyParentVO = photoService.getPhotoParentReplyCheck(replyVO.getPhotoIdx());
  		
  		if(replyParentVO == null) {
  			replyVO.setRe_order(1);
  		}
  		else {
  			replyVO.setRe_order(replyParentVO.getRe_order() + 1);
  		}
  		replyVO.setRe_step(0);
  		
  		int res = photoService.setPhotoReplyInput(replyVO);
  		
  		return res + "";
  	}
    
    // 대댓글 입력처리(부모댓글에 대한 댓글)
  	@ResponseBody
  	@RequestMapping(value = "/photoReplyInputRe", method = RequestMethod.POST)
  	public String boardReplyInputRePost(PhotoReplyVO replyVO) {
  		// 대댓글(답변글)의 1.re_step은 부모댓글의 re_step+1, 2.re_order는 부모의 re_order보다 큰 댓글은 모두 +1처리후, 3.자신의 re_order+1시켜준다.
  		
  		replyVO.setRe_step(replyVO.getRe_step() + 1);		// 1번처리
  		
  		photoService.setReplyOrderUpdate(replyVO.getPhotoIdx(), replyVO.getRe_order());  // 2번 처리
  		
  		replyVO.setRe_order(replyVO.getRe_order() + 1);
  		
  		int res = photoService.setPhotoReplyInput(replyVO);
  		
  		return res + "";
  	}
    
  
}