package com.ymz.member.service;

import java.util.List;
import java.util.Map;

import com.ymz.member.exception.DuplicatedIdException;
import com.ymz.member.exception.DuplicatedNameException;
import com.ymz.member.exception.DuplicatedNickException;
import com.ymz.member.exception.DuplicatedPhoneException;
import com.ymz.member.vo.Member;

public interface MemberService {

	/**
	 * 가입 처리 메소드
	 * @param member 가입 정보
	 * @throws DuplicatedIdException 중복된 아이디일 경우 발생
	 * @throws DuplicatedNameException 
	 * @throws DuplicatedNickException 
	 * @throws DuplicatedPhoneException 
	 */
	public abstract void joinMember(Member member) throws DuplicatedIdException, DuplicatedNameException, DuplicatedNickException, DuplicatedPhoneException;

	/**
	 * 전체 회원 목록 조회 처리
	 * @param command 
	 * @param info 
	 * @return List<Member>
	 */
	public abstract List<Member> getMemberList(String info, String command);

	/* **********************************************
	 * 페이징 처리 service 메소드
	 * **********************************************/
	/**
	 * 전체 회원 목록 조회 처리 - Paging 처리
	 *  - 목록에 뿌려줄 회원리스트(List<Member>)와 페이징 처리를 PagingBean 객체를 생성해 Map에 넣어 리턴
	 * @param page : 조회할 page 번호
	 * @return Map
	 */
	public abstract Map getMemberListPaging(int pageNo);

	/**
	 * ID로 회원 조회 메소드
	 * @param id : 조회할 회원 ID
	 * @return
	 */
	public abstract Member getMemberById(String id);
	
	/**
	 * Email로 회원 조회 메소드
	 */
	public abstract Member getMemberByEmail(String email);
	
	/**
	 * Nickname로 회원 조회 메소드
	 */
	public abstract Member getMemberByNickname(String nickname);
	
	/**
	 * name으로 회원 조회 메소드
	 */
	
	public abstract Member getMemberByName(String name);
	
	/**
	 * 전화번호로 회원 조회 메소드
	 */
	public abstract Member getMemberByPhone(String phoneNo);
	
	/**
	 * category 조회하기
	 */
	public abstract Map<String,Object> getCategory();
	
//	public abstract Map getCategoryName();
	
	/**
	 * 회원 정보 수정 처리 메소드
	 * @param member 수정할 회원 전보
	 */
	public abstract void modifyMember(Member member);
	
	/**
	 * 비밀번호 수정 메소드
	 */
	public abstract void modifyPassword(Member member);
	
	/**
	 * 마일리지 수정 메소드 
	 */
	public abstract void modifyMileage(Member member);
	
	/**
	 * 회원 탈퇴 메소드
	 * @param id 탈퇴할 회원 ID
	 */
	public abstract void removeMemberById(String id);

	public abstract void transactionTest(Member m1, Member m2) throws Exception;

	public abstract Map getMemberByInfo(String info, String command, int pageNo);
}