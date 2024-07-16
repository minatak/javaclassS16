package com.spring.javaclassS16.service;

import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS16.common.JavaclassProvide;
import com.spring.javaclassS16.dao.MemberDAO;
import com.spring.javaclassS16.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	JavaclassProvide javaclassProvide;

	@Override
	public MemberVO getMemberIdCheck(String mid) {
		return memberDAO.getMemberIdCheck(mid);
	}

	@Override
	public MemberVO getMemberNameCheck(String name) {
		return memberDAO.getMemberNameCheck(name);
	}

	@Override
	public int setMemberJoinOk(MemberVO vo) {
		return memberDAO.setMemberJoinOk(vo);
	}

	@Override
	public void setPasswordUpdate(String mid, String pwd) {
		memberDAO.setPasswordUpdate(mid, pwd);
	}

	@Override
	public int setPwdChangeOk(String mid, String pwd) {
		return memberDAO.setPwdChangeOk(mid, pwd);
	}

	@Override
	public String fileUpload(MultipartFile fName, String mid, String photo) {
		// 파일이름 중복처리를 위해 UUID객체 활용
		UUID uid = UUID.randomUUID();
		String oFileName = fName.getOriginalFilename();
		String sFileName = mid + "_" + uid.toString().substring(0,8) + "_" + oFileName;
		
		try {
			// 서버에 파일 올리기
			javaclassProvide.writeFile(fName, sFileName, "member");
			
			// 기존 사진파일이 noimage.png가 아니라면 서버에서 삭제시킨다.
			if(!photo.equals("noimage.png")) javaclassProvide.deleteFile(photo, "member");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sFileName;
	}

	@Override
	public int setMemberUpdateOk(MemberVO vo) {
		return memberDAO.setMemberUpdateOk(vo);
	}

	@Override
	public int setUserDel(String mid) {
		return memberDAO.setUserDel(mid);
	}

	@Override
	public MemberVO getMemberNameEmailCheck(String name, String email) {
		return memberDAO.getMemberNameEmailCheck(name, email);
	}

	@Override
	public void setKakaoMemberInput(MemberVO vo) {
		memberDAO.setKakaoMemberInput(vo);
	}

	@Override
	public MemberVO getMemberEmailCheck(String email) {
		return memberDAO.getMemberEmailCheck(email);
	}

	@Override
	public String createFamilyCode() {
		String code;
	    do {
	        code = RandomStringUtils.randomAlphanumeric(8).toUpperCase();
	    } while (memberDAO.familyCodeExists(code));
	    
	    memberDAO.createFamily(code);
	    return code;
	}

	@Override
	public void updateMemberFamilyCode(String mid, String familyCode) {
		memberDAO.updateMemberFamilyCode(mid, familyCode);
	}

	@Override
	public boolean connectToFamily(String mid, String familyCode) {
		if (memberDAO.familyCodeExists(familyCode)) {
            memberDAO.updateMemberFamilyCode(mid, familyCode);
            return true;
        }
        return false;
	}
	
	// 나이 구하는 메소드
	@Override
  public int calculateAge(String birthday) {
		System.out.println("birthday : " + birthday);
		
	  int birthYear = Integer.parseInt(birthday.substring(0, 4));
	  int birthMonth = Integer.parseInt(birthday.substring(5, 7));
	  int birthDay = Integer.parseInt(birthday.substring(8, 10));
	
	  Calendar current = Calendar.getInstance();
	  int currentYear = current.get(Calendar.YEAR);
	  int currentMonth = current.get(Calendar.MONTH) + 1;
	  int currentDay = current.get(Calendar.DAY_OF_MONTH);
	
	  int age = currentYear - birthYear;
	
	  if (birthMonth * 100 + birthDay > currentMonth * 100 + currentDay) {
	      age--;
	  }
	
	  return age;
  }

	@Override
	public List<MemberVO> getFamilyMembersByFamCode(String familyCode) {
		return memberDAO.getFamilyMembersByFamCode(familyCode);
	}
  
	
}
