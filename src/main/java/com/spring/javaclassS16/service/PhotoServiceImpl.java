package com.spring.javaclassS16.service;

import com.spring.javaclassS16.common.JavaclassProvide;
import com.spring.javaclassS16.dao.PhotoDAO;
import com.spring.javaclassS16.vo.PhotoVO;

import net.coobird.thumbnailator.Thumbnailator;

import com.spring.javaclassS16.vo.MemberVO;
import com.spring.javaclassS16.vo.PhotoReplyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.UUID;

@Service
public class PhotoServiceImpl implements PhotoService {
	
  @Autowired
  PhotoDAO photoDAO;
  
  @Autowired
	JavaclassProvide javaclassProvide;

  public ArrayList<PhotoVO> getPhotoList(int pag, int pageSize, String familyCode, String part, String choice) {
    int startIndexNo = Math.max(0, (pag - 1) * pageSize);
    return photoDAO.getPhotoList(startIndexNo, pageSize, familyCode, part, choice);
  }
  
  @Override
  public int setPhotoInput(PhotoVO vo) {
      String content = vo.getContent();
      
      // 썸네일 설정
      String thumbnail = extractThumbnail(content);
      vo.setThumbnail(thumbnail);
      
      // 사진 수량 계산
      int photoCount = countPhotos(content);
      vo.setPhotoCount(photoCount);
      
      System.out.println("Content: " + content);
      System.out.println("Extracted thumbnail: " + thumbnail);
      System.out.println("Photo count: " + photoCount);
      System.out.println("VO after setting: " + vo);
      
      return photoDAO.setPhotoInput(vo);
  }

  private String extractThumbnail(String content) {
      int position = content.indexOf("<img");
      if(position != -1) {
          int srcPosition = content.indexOf("src=\"", position);
          if(srcPosition != -1) {
              String thumbnail = content.substring(srcPosition + 5);
              thumbnail = thumbnail.substring(0, thumbnail.indexOf("\""));
              // /photo/ 경로에서 파일명만 추출
              String fileName = thumbnail.substring(thumbnail.lastIndexOf("/") + 1);
              return setThumbnailCreate(fileName);
          }
      }
      return "";
  }


  private int countPhotos(String content) {
      int photoCount = 0;
      int index = 0;
      while ((index = content.indexOf("src=\"", index)) != -1) {
          photoCount++;
          index += 5;
      }
      return photoCount;
  }

  private String setThumbnailCreate(String fileName) {
    String res = "";
    try {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
        
        // 원본 파일 경로
        String originalPath = request.getSession().getServletContext().getRealPath("/resources/data/photo/");
        File originalFile = new File(originalPath + fileName);
        
        if (!originalFile.exists()) {
            System.out.println("Original file does not exist: " + originalFile.getAbsolutePath());
            return "";
        }
        
        // 새 파일명 생성
        String sFileName = "s_" + fileName;
        
        // 썸네일 저장 경로
        String thumbnailPath = request.getSession().getServletContext().getRealPath("/resources/data/thumbnail/");
        
        // 썸네일 파일 생성
        File thumbnailFile = new File(thumbnailPath + sFileName);
        
        int width = 200;  // 원하는 썸네일 너비
        int height = 150; // 원하는 썸네일 높이
        Thumbnailator.createThumbnail(originalFile, thumbnailFile, width, height);
        
        // 썸네일 파일명만 반환
        res = sFileName;
        
        System.out.println("Thumbnail created: " + thumbnailFile.getAbsolutePath());
    } catch (IOException e) {
        e.printStackTrace();
        System.out.println("Error creating thumbnail: " + e.getMessage());
    }
    
    return res;
  }
  
  @Override
  public MemberVO getMemberVoByMid(String mid) {
      return photoDAO.getMemberIdxByMid(mid);
  }

  @Override
  public PhotoVO getPhotoContent(int idx) {
    try {
        PhotoVO vo = photoDAO.getPhotoContent(idx);
        if (vo != null) {
            photoDAO.setPhotoReadNumPlus(idx);
        }
        return vo;
    } catch (Exception e) {
        System.out.println("Error in getPhotoContent: " + e.getMessage());
        e.printStackTrace();
        return null;
    }
}

  @Override
  public ArrayList<PhotoReplyVO> getPhotoReply(int idx) {
    return photoDAO.getPhotoReply(idx);
  }

  @Override
  public String setPhotoGoodCheck(int idx, HttpSession session) {
    @SuppressWarnings("unchecked")
    ArrayList<String> contentGood = (ArrayList<String>) session.getAttribute("sContentGood");
    if (contentGood == null) contentGood = new ArrayList<>();
    String imsiContentGood = "photoGood" + idx;
    if (!contentGood.contains(imsiContentGood)) {
      photoDAO.setPhotoGoodCheck(idx);
      contentGood.add(imsiContentGood);
      session.setAttribute("sContentGood", contentGood);
      return "1";
    }
    return "0";
  }

  @Override
  public String setPhotoReplyInput(PhotoReplyVO vo) {
    return photoDAO.setPhotoReplyInput(vo) == 1 ? "1" : "0";
  }

  @Override
  public String setPhotoReplyDelete(int idx) {
    return photoDAO.setPhotoReplyDelete(idx) == 1 ? "1" : "0";
  }

  @Override
  public void imageUpload(HttpServletRequest request, HttpServletResponse response, MultipartFile upload) throws Exception {
    response.setCharacterEncoding("utf-8");
    response.setContentType("text/html; charset=utf-8");
    
    String fileName = upload.getOriginalFilename();
    
    Date date = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
    fileName = sdf.format(date) + "_" + fileName;
    
    String realPath = request.getSession().getServletContext().getRealPath("/resources/data/photo/");
    
    File uploadFile = new File(realPath + fileName);
    upload.transferTo(uploadFile);
    
    PrintWriter out = response.getWriter();
    String fileUrl = request.getContextPath() + "/photo/" + fileName;
    out.println("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl+"\"}");
    
    out.flush();
  }

	@Override
	public MemberVO getWriterPhoto(int idx) {
		return photoDAO.getWriterPhoto(idx);
	}

}