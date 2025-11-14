package com.springbook.biz.board;

import java.util.List;

public interface BoardService {
	// CRUD 기능의 메소드 구현
	// 글 등록
	int insertBoard(BoardVO vo);

	// 글 수정
	int updateBoard(BoardVO vo);
	
    // 글 삭제
    int deleteBoard(BoardVO vo);
	
    // 다건글 등록
    int insertForList(BoardVO vo);

    // 다건글 수정
    int updateForList(BoardVO vo);
    
    // 다건글 삭제
    int deleteForList(BoardVO vo);

	// 글 상세 조회
	BoardVO getBoard(BoardVO vo);

	// 글 목록 조회
	List<BoardVO> getBoardList(BoardVO vo);
	
    int countBoard(BoardVO vo);
    
}
