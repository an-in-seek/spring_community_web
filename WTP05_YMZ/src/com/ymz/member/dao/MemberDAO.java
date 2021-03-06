package com.ymz.member.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ymz.member.vo.Member;

public interface MemberDAO {

	/**
	 * id로 회원 정보를 조회하여 return하는 메소드
	 * @param id 조회할 회원 ID
	 * @return 
	 */
	public abstract Member selectMemberById(String id);
	
	/**
	 * Email로 회원 정보를 조회하여 return하는 메소드
	 */
	public abstract Member selectMemberByEmail(String email);
	
	/**
	 * Nickname로 회원 정보를 조회하여 return하는 메소드
	 */
	public abstract Member selectMemberByNickname(String nickname);
	
	/**
	 * name으로 회원 정보를 조회하여 return하는 메소드
	 */
	
	public abstract Member selectMemberByName(String name);
	
	/**
	 * 전화번호로 회원 정보를 조회하여 return하는 메소드
	 */
	public abstract Member seleMemberByPhone(String phoneNo);
	
	
	/**
	 * 회원 정보를 DB에 insert하는 메소드
	 * @param member 등록할 회원 정보
	 */
	public abstract int insertMember(Member member);

	/**
	 * 회원 정보 수정 메소드
	 * 매개변수로 받은 Member객체의 id 회원의 나머지 정보를 변경한다. 단 ID와 가입일자는 변경 안한다.
	 * @param member
	 */
	public abstract int updateMember(Member member);
	
	/**
	 * 비밀번호 수정 메소드
	 * 매개변수로 받은 값을 id 회원의 비밀번호로 변경한다.
	 * @param string
	 */
	public abstract int updatePassword(Member member);

	/**
	 * 매개 변수로 받은 ID의 회원을 삭제하는 메소드
	 * @param id
	 * @throws SQLException
	 */
	public abstract int deleteMemberById(String id);

	/**
	 * Member 테이블의 전체 회원정보 조회 처리
	 * @param command 
	 * @param info 
	 * @return
	 */
	public abstract List<Member> selectAllMember(String info, String command);
	
	/**
	 * category조회
	 */
	public abstract List<Map<String, Object>> selectCategory();
	
	public abstract List selectCategoryId();

	public abstract List selectCategoryName();
	/**
	 * Member 테이블의 페이징 처리 전체 회원 조회 처리
	 * @param pageNo 조회할 페이지 번호
	 * @return
	 */
	public abstract List<Member> selectAllMemberPaging(int pageNo);

	public abstract int selectTotalMemberCount();

	public abstract List<Member> selectAllMemberByInfo(String info, String command, int pageNo);

	public abstract int selectTotalMemberCountByInfo(String info, String command);

}