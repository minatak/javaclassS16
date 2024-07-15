package com.spring.javaclassS16.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
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
    	String familyCode = (String) session.getAttribute("sFamCode");
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
	    PhotoVO preVo = photoService.getPreNexSearch(idx, familyCode, "preVo");
	    PhotoVO nextVo = photoService.getPreNexSearch(idx, familyCode, "nextVo");
	    model.addAttribute("preVo", preVo);
	    model.addAttribute("nextVo", nextVo);
	    
	    // 댓글(대댓글) 가져오기
	    List<PhotoReplyVO> replyVos = photoService.getPhotoReply(idx);
	    model.addAttribute("replyVos", replyVos);
	    
	    // 좋아요 누른 사람들 가져오기
	    List<MemberVO> likers = photoService.getPhotoLikers(idx);
	    model.addAttribute("likers", likers);
	    
	    return "photo/photoContent";
    }

    @ResponseBody
    @RequestMapping(value = "/photoToggleLike", method = RequestMethod.POST)
    public String photoToggleLike(@RequestParam int idx, HttpSession session) {
        return photoService.togglePhotoLike(idx, session);
    }

    
    @Transactional
    @ResponseBody
    @RequestMapping(value = "/photoReplyDelete", method = RequestMethod.POST)
    public String photoReplyDelete(@RequestParam int idx) {
    	
    	// 삭제하려는 댓글이 부모 댓글인지 대댓글인지 확인 (parentIdx가 null이면 부모댓글)
    	PhotoReplyVO vo = photoService.getPhotoReplyVo(idx);
    	
    	// 부모 댓글을 삭제할 경우
    	if(vo.getParentIdx() == 0) {
    		// 먼저 대댓글들을 삭제 
    		photoService.setPhotoReplyDeleteByParentIdx(idx);
    	}

    	// 그 다음 부모 댓글 삭제
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
    public String photoReplyInputPost(PhotoReplyVO vo, HttpSession session) {
        String name = (String) session.getAttribute("sName");
        vo.setName(name);
        vo.setParentIdx(null);  // 부모 댓글이므로 parentIdx는 null
        
        int res = photoService.setPhotoReplyInput(vo);
        
        return res + "";
    }

    // 대댓글 입력처리(부모댓글에 대한 댓글)
    @ResponseBody
    @RequestMapping(value = "/photoReplyInputRe", method = RequestMethod.POST)
    public String photoReplyInputRePost(PhotoReplyVO vo) {
        int res = photoService.setPhotoReplyInput(vo);
        
        return res + "";
    }
    
    // 사진 다운로드 
    @RequestMapping(value = "/photoTotalDown", method = RequestMethod.GET)
    public void photoTotalDown(HttpServletRequest request, HttpServletResponse response, int idx) throws IOException {
        String realPath = request.getSession().getServletContext().getRealPath("/resources/data/photo/");
        
        PhotoVO vo = photoService.getPhotoContent(idx);
        
        // content에서 이미지 경로 추출
        List<String> imagePaths = photoService.extractImagePaths(vo.getContent());
        
        String zipName = vo.getpDate().replaceAll("[-:]", "").replace(" ", "_").replaceAll("\\.0$", "") + ".zip";
        
        response.setContentType("application/zip");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + zipName + "\"");
        
        try (ZipOutputStream zos = new ZipOutputStream(response.getOutputStream())) {
            byte[] buffer = new byte[1024];
            for (String imagePath : imagePaths) {
                File imageFile = new File(realPath + imagePath);
                if (imageFile.exists()) {
                    ZipEntry zipEntry = new ZipEntry(imagePath);
                    zos.putNextEntry(zipEntry);
                    
                    try (FileInputStream fis = new FileInputStream(imageFile)) {
                        int length;
                        while ((length = fis.read(buffer)) > 0) {
                            zos.write(buffer, 0, length);
                        }
                    }
                    zos.closeEntry();
                }
            }
        } 
    }
    
    
    // 사진 삭제 처리 
    @RequestMapping(value = "/photoDelete", method = RequestMethod.GET)
    public String photoDeleteGet(int idx,
  			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
  			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
  		// 게시글에 사진이 존재한다면 서버에 저장된 사진을 삭제처리한다.
  		PhotoVO vo = photoService.getPhotoContent(idx);
  		if(vo.getContent().indexOf("src=\"/") != -1) photoService.imgDelete(vo.getContent());
  		
  	  // 먼저 연결된 댓글(reply) 삭제
      photoService.deletePhotoReply(idx);
  		
  		// 사진작업을 끝나면 DB에 저장된 실제 정보레코드를 삭제처리한다.
    	int res = photoService.setPhotoDelete(idx);
    	
    	if(res != 0) return "redirect:/message/photoDeleteOk";
    	else return "redirect:/message/photoDeleteNo?idx="+idx;
    }
    
    // 사진 수정
    @RequestMapping(value = "/photoUpdate", method = RequestMethod.GET)
  	public String photoUpdateGet(int idx, Model model,
  			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
  			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
  		// 수정화면으로 이동할시에는 기존 원본파일의 그림파일이 존재한다면, 현재폴더(photo)의 그림파일을 ckeditor폴더로 복사시켜준다.
  		PhotoVO vo = photoService.getPhotoContent(idx);
  		if(vo.getContent().indexOf("src=\"/") != -1) photoService.imgBackup(vo.getContent());
  		
  		model.addAttribute("pag", pag);
  		model.addAttribute("pageSize", pageSize);
  		model.addAttribute("vo", vo);
  		return "photo/photoUpdate";
  	}
  	
  	@RequestMapping(value = "/photoUpdate", method = RequestMethod.POST)
  	public String photoUpdatePost(PhotoVO vo, Model model,
  			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
  			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
  		// 수정된 자료가 원본자료와 완전히 동일하다면 수정할 필요가 없다. 즉, DB에 저장된 원본자료를 불러와서 현재 vo에 담긴 내용(content)과 비교해본다.
  		PhotoVO origVo = photoService.getPhotoContent(vo.getIdx());
  		
  		// content의 내용이 조금이라도 변경이 되었다면 내용을 수정한것이기에 그림파일 처리유무를 결정한다.
  		if(!origVo.getContent().equals(vo.getContent())) {
  			// 1.기존 photo폴더에 그림이 존재했다면 원본그림을 모두 삭제처리한다.(원본그림은 수정창에 들어오기전에 ckeditor폴더에 저장시켜두었다.)
  			if(origVo.getContent().indexOf("src=\"/") != -1) photoService.imgDelete(origVo.getContent());
  			
  			// 2.앞의 삭제 작업이 끝나면 'photo'폴더를 'ckeditor'로 경로 변경한다.
  			vo.setContent(vo.getContent().replace("/data/photo/", "/data/ckeditor/"));
  			
  			// 1,2, 작업을 마치면 파일을 처음 업로드한것과 같은 작업처리를 해준다.
  			// 즉, content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 '/data/photo/'폴더에 복사 저장처리한다.
  			if(vo.getContent().indexOf("src=\"/") != -1) photoService.imgCheck(vo.getContent());
  			
  			// 이미지들의 모든 복사작업을 마치면, 폴더명을 'ckeditor'에서 'photo'폴더로 변경처리한다.
  			vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/photo/"));
  			
  			// content안의 내용과 그림파일까지, 잘 정비된 vo를 DB에 Update 시켜준다.
  		}
  		int res = photoService.setPhotoUpdate(vo);
  	
  		model.addAttribute("idx", vo.getIdx());
  		model.addAttribute("pag", pag);
  		model.addAttribute("pageSize", pageSize);
  		
  		if(res != 0) return "redirect:/message/photoUpdateOk";
  		else return "redirect:/message/photoUpdateNo";
  	}
    
  
}