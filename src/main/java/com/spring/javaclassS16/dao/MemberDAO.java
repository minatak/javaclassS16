package com.spring.javaclassS16.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS16.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getMemberIdCheck(@Param("mid") String mid);

	public MemberVO getMemberNameCheck(@Param("name") String name);

	public int setMemberJoinOk(@Param("vo") MemberVO vo);

	public void setKakaoMemberInput(@Param("vo") MemberVO vo);
	
	public void setPasswordUpdate(@Param("mid") String mid, @Param("pwd") String pwd);

	public int setPwdChangeOk(@Param("mid") String mid, @Param("pwd") String pwd);

	public int setMemberUpdateOk(@Param("vo") MemberVO vo);

	public int setUserDel(@Param("mid") String mid);

	public MemberVO getMemberNameEmailCheck(@Param("name") String name, @Param("email") String email);

	public MemberVO getMemberEmailCheck(@Param("email") String email);

	public boolean familyCodeExists(@Param("code") String code);

	public void createFamily(@Param("code") String code);

	public void updateMemberFamilyCode(@Param("mid") String mid, @Param("familyCode") String familyCode);

	public List<MemberVO> getFamilyMembersByFamCode(@Param("familyCode") String familyCode);

	public String getMemberNameByIdx(@Param("idx") int idx);

	public int updateMemberField(@Param("field") String field, @Param("value") String value, @Param("mid") String mid);

	public void setMemberDel(@Param("mid") String mid);

	public int updateMemberPhoto(@Param("newFileName") String newFileName, @Param("mid") String mid);


}
