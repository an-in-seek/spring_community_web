package com.ymz.qna.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ymz.qna.vo.QNA;

@Repository
public class QNADAOImpl implements QNADAO {

	private String namespace="qna.dao.QNAMapper.";
	
	@Autowired
	private SqlSessionTemplate session;
	
	//QNA게시판 글 등록
	@Override
	public int insertQNA(QNA qna) {
		return session.insert(namespace+"insertQNA", qna);
	}

	//QNA게시판 글 수정
	@Override
	public int updateQNA(QNA qna) {
		return session.update(namespace+"updateQNA", qna);
	}

	//QNA게시판 글 제거
	@Override
	public int deleteQNAByNo(int number) {
		return session.delete(namespace+"deleteQNAByNo", number);
	}

	//QNA게시판 글 전체목록 조회
	@Override
	public List<QNA> selectAllQNA() {
		return session.selectList(namespace+"selectAllQNA");
	}

	//QNA게시판 글 번호로 조회
	@Override
	public QNA selectQNAByNo(int number) {
		return session.selectOne(namespace+"selectQNAByNo", number);
	}
}
