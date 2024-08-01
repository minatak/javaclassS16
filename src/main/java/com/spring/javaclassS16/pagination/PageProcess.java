package com.spring.javaclassS16.pagination;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS16.dao.MeetingDAO;
import com.spring.javaclassS16.dao.NoticeDAO;
import com.spring.javaclassS16.dao.PhotoDAO;
import com.spring.javaclassS16.dao.VoteDAO;
import com.spring.javaclassS16.dao.WorkDAO;
import com.spring.javaclassS16.vo.MeetingTopicReplyVO;
import com.spring.javaclassS16.vo.PageVO;

@Service
public class PageProcess {
    @Autowired
    PhotoDAO photoDAO;
    
    @Autowired
    NoticeDAO noticeDAO;
    
    @Autowired
    WorkDAO workDAO;
    
    @Autowired
    MeetingDAO meetingDAO;
    
    @Autowired
    VoteDAO voteDAO;
    
    public PageVO totRecCnt(int pag, int pageSize, String section, String part, String searchString, HttpSession session) {
        PageVO pageVO = new PageVO();
        
        String familyCode = (String) session.getAttribute("sFamCode");
        
        int totRecCnt = 0;
        String search = "";
        
        if(section.equals("notice")) {
          if(part.equals(""))    totRecCnt = noticeDAO.totRecCnt(familyCode);
          else {
            search = part;
            totRecCnt = noticeDAO.totRecCntSearch(search, searchString);
          }
        }
        else if(section.equals("photo")) {
        	if(part.equals("")) totRecCnt = photoDAO.totRecCnt(familyCode);
        	else {
        		search = part;
        		totRecCnt = photoDAO.totRecCntSearch(search, searchString);
        	}
        }
        else if(section.equals("work")) {
	        if(part.equals("")) totRecCnt = workDAO.totRecCnt(familyCode);
	        else {
	          search = part;
	          totRecCnt = workDAO.totRecCntSearch(search, searchString);
	        }
        }
        else if(section.equals("meeting")) {
          totRecCnt = meetingDAO.totRecCnt(familyCode, searchString);
        }
        else if(section.equals("meetingTopic")) {
        	totRecCnt = meetingDAO.totTopicRecCnt(familyCode, searchString);
        }
        else if(section.equals("vote")) {
        	int memberIdx = (int) session.getAttribute("sIdx");
          totRecCnt = voteDAO.totRecCnt(familyCode, part, memberIdx);
        }
        
        int totPage = (totRecCnt % pageSize) == 0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
        int startIndexNo = (pag - 1) * pageSize;
        int curScrStartNo = totRecCnt - startIndexNo;
        
        int blockSize = 3;
        int curBlock = (pag - 1) / blockSize;
        int lastBlock = (totPage - 1) / blockSize;
        
        pageVO.setPag(pag);
        pageVO.setPageSize(pageSize);
        pageVO.setTotRecCnt(totRecCnt);
        pageVO.setTotPage(totPage);
        pageVO.setStartIndexNo(startIndexNo);
        pageVO.setCurScrStartNo(curScrStartNo);
        pageVO.setBlockSize(blockSize);
        pageVO.setCurBlock(curBlock);
        pageVO.setLastBlock(lastBlock);
        pageVO.setSearh(search);
        pageVO.setSearchString(searchString);
        pageVO.setPart(part);
                
        return pageVO;
    }
}