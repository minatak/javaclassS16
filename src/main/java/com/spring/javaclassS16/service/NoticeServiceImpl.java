package com.spring.javaclassS16.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javaclassS16.dao.NoticeDAO;
import com.spring.javaclassS16.vo.MemberVO;
import com.spring.javaclassS16.vo.NoticeReadStatusVO;
import com.spring.javaclassS16.vo.NoticeReplyVO;
import com.spring.javaclassS16.vo.NoticeVO;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	NoticeDAO noticeDAO;

	@Override
	public int setNoticeInput(NoticeVO vo) {
		return noticeDAO.setNoticeInput(vo);
	}

	@Override
	public NoticeVO getNoticeContent(int idx) {
		return noticeDAO.getNoticeContent(idx);
	}

	@Override
	public ArrayList<NoticeVO> getNoticeList(String familyCode, int memberIdx, int startIndexNo, int pageSize) {
		return noticeDAO.getNoticeList(familyCode, memberIdx, startIndexNo, pageSize);
	}

	@Override
	public void setReadNumPlus(int idx) {
		noticeDAO.setReadNumPlus(idx);
	}

	@Override
	public NoticeVO getPreNexSearch(int idx, String str, String familyCode) {
		return noticeDAO.getPreNexSearch(idx, str, familyCode);
	}

	// content에 이미지가 있다면 이미지를 'ckeditor'폴더에서 'notice'폴더로 복사처리한다.
	@Override
	public void imgCheck(String content) {
		//                0         1         2         3
		//                01234567890123456789012345678901234567890
		// <p><img alt="" src="/javaclassS/data/ckeditor/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		// <p><img alt="" src="/javaclassS/data/notice/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 32;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "ckeditor/" + imgFile;
			String copyFilePath = realPath + "notice/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);	// ckeditor폴더의 그림파일을 notice폴더위치로 복사처리하는 메소드.
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	// 파일 복사처리
	private void fileCopyCheck(String origFilePath, String copyFilePath) {
		try {
			FileInputStream fis = new FileInputStream(new File(origFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] b = new byte[2048];
			int cnt = 0;
			while((cnt = fis.read(b)) != -1) {
				fos.write(b, 0, cnt);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void imgBackup(String content) {
		//                0         1         2         3
		//                01234567890123456789012345678901234567890
		// <p><img alt="" src="/javaclassS/data/notice/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		// <p><img alt="" src="/javaclassS/data/ckeditor/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 28;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "notice/" + imgFile;
			String copyFilePath = realPath + "ckeditor/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);	// ckeditor 폴더의 그림파일을 notice 폴더위치로 복사처리하는 메소드.
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	@Override
	public void imgDelete(String content) {
		//                0         1         2         3
		//                01234567890123456789012345678901234567890
		// <p><img alt="" src="/javaclassS/data/notice/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		// <p><img alt="" src="/javaclassS/data/ckeditor/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 28;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "notice/" + imgFile;
			
			fileDelete(origFilePath);	// notice폴더의 그림파일 삭제한다.
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	// 서버에 존재하는 파일 삭제처리
	private void fileDelete(String origFilePath) {
		File delFile = new File(origFilePath);
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public int setNoticeUpdate(NoticeVO vo) {
		return noticeDAO.setNoticeUpdate(vo);
	}

	@Override
	public int setNoticeDelete(int idx) {
		return noticeDAO.setNoticeDelete(idx);
	}

	@Override
	public int setNoticeReplyInput(NoticeReplyVO replyVO) {
		return noticeDAO.setNoticeReplyInput(replyVO);
	}

	@Override
	public List<NoticeReplyVO> getNoticeReply(int idx) {
		return noticeDAO.getNoticeReply(idx);
	}

	@Override
	public List<NoticeVO> getNoticeSearchList(int startIndexNo, int pageSize, String search, String searchString) {
		return noticeDAO.getNoticeSearchList(startIndexNo, pageSize, search, searchString);
	}

	@Override
	public void setNoticeRead(int idx, int memberIdx) {
		noticeDAO.setNoticeRead(idx, memberIdx);
	}

	@Override
	public NoticeReadStatusVO getReadStatus(int idx, int memberIdx) {
		return noticeDAO.getReadStatus(idx, memberIdx);
	}

	@Override
	public boolean getNoticeLike(int idx, int memberIdx) {
		return noticeDAO.getNoticeLike(idx, memberIdx);
	}

	@Override
	public NoticeReplyVO getNoticeReplyVo(int idx) {
		return noticeDAO.getNoticeReplyVo(idx);
	}

	@Override
	public void setNoticeReplyDeleteByParentIdx(int idx) {
		noticeDAO.setNoticeReplyDeleteByParentIdx(idx);
	}

	@Override
	public String toggleNoticeLike(int idx, int memberIdx) {
		 boolean liked = noticeDAO.getNoticeLike(idx, memberIdx);
     if (liked) {
    	 noticeDAO.removeNoticeLike(idx, memberIdx);
    	 noticeDAO.decreaseNoticeLikeCount(idx);
       return "unliked";
     } else {
    	 noticeDAO.addNoticeLike(idx, memberIdx);
    	 noticeDAO.increaseNoticeLikeCount(idx);
       return "liked";
     }
	}

	@Override
	public String setNoticeReplyDelete(int idx) {
		return noticeDAO.setNoticeReplyDelete(idx);
	}

	@Override
	public List<MemberVO> getNoticeLikers(int idx) {
		return noticeDAO.getNoticeLikers(idx);
	}

	@Override
	public List<NoticeVO> getRecentNotices(String familyCode) {
		return noticeDAO.getRecentNotices(familyCode);
	}
	
}
