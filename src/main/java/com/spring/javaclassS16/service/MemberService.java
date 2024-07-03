package com.spring.javaclassS16.service;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS16.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public MemberVO getMemberNameCheck(String name);

	public int setMemberJoinOk(MemberVO vo);

	public void setPasswordUpdate(String mid, String pwd);

	public int setPwdChangeOk(String mid, String pwd);

	public String fileUpload(MultipartFile fName, String mid, String photo);

	public int setMemberUpdateOk(MemberVO vo);

	public int setUserDel(String mid);

	public MemberVO getMemberNameEmailCheck(String nickName, String email);

	public void setKakaoMemberInput(MemberVO vo);

}
