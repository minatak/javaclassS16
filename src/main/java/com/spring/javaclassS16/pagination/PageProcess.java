package com.spring.javaclassS16.pagination;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS16.dao.NoticeDAO;
import com.spring.javaclassS16.dao.PhotoDAO;
import com.spring.javaclassS16.vo.PageVO;

@Service
public class PageProcess {

	@Autowired
	PhotoDAO photoDAO;
	
	@Autowired
	NoticeDAO noticeDAO;

	public PageVO totRecCnt(int pag, int pageSize, String section, String part, String searchString, HttpSession session) {
		PageVO pageVO = new PageVO();
		
		String familyCode = (String) session.getAttribute("sFamCode");
		
		int totRecCnt = 0;
		String search = "";
		
		if(section.equals("notice")) {
			if(part.equals(""))	totRecCnt = noticeDAO.totRecCnt(familyCode);
			else {
				search = part;
				totRecCnt = noticeDAO.totRecCntSearch(search, searchString);
			}
		}
		else if(section.equals("photo")) totRecCnt = photoDAO.totRecCnt(part);
		
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
