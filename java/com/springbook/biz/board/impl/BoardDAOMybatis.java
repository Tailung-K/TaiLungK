package com.springbook.biz.board.impl;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.springbook.biz.board.BoardVO;

@Repository
public class BoardDAOMybatis {

	@Autowired
	private SqlSessionTemplate mybatis;
	
    private Logger logger = LoggerFactory.getLogger( this.getClass() );	

	public int insertBoard(BoardVO vo) {
	    int nRtn = mybatis.insert("BoardDAO.insertBoard", vo);
        return nRtn;	    
	}

	public int updateBoard(BoardVO vo) {
	    int nRtn = mybatis.update("BoardDAO.updateBoard", vo);
        return nRtn;	    
	}
	
    public int deleteBoard(BoardVO vo) {
        int nRtn = mybatis.delete("BoardDAO.deleteBoard", vo);
        return nRtn;
    }	
	
    public int insertForList(BoardVO vo) {
        int nRtn = mybatis.insert("BoardDAO.insertBoard", vo);
        
        return nRtn;
    }

    public int updateForList(BoardVO vo) {
        int nRtn = mybatis.update("BoardDAO.updateBoard", vo);
        
        return nRtn;
    }
    
    public int deleteForList(BoardVO vo) {
        int nRtn = mybatis.delete("BoardDAO.deleteBoard", vo);
        
        return nRtn;
    }

	public BoardVO getBoard(BoardVO vo) {
		return (BoardVO) mybatis.selectOne("BoardDAO.getBoard", vo);
	}
	
    public int countBoard(BoardVO vo) {
        int nRtn = mybatis.selectOne("BoardDAO.countBoard", vo);
        
        return nRtn;
    }	
    
	public List<BoardVO> getBoardList(BoardVO vo) {
        List<BoardVO> list = new ArrayList<BoardVO>();
        
		System.out.println("DAO VO :: " + vo);
		
//		if (vo.getSearchCondition().equals("TITLE")) {
//		    list = mybatis.selectList("BoardDAO.getBoardList_T", vo);
//	        System.out.println("DAO list1 :: " + list);
//		} else if (vo.getSearchCondition().equals("CONTENT")) {
//		    list = mybatis.selectList("BoardDAO.getBoardList_C", vo);
//            System.out.println("DAO list2 :: " + list);
//		} else {
//            list = mybatis.selectList("BoardDAO.getBoardList_C", vo);
//            System.out.println("DAO list3 :: " + list);
//		}

        list = mybatis.selectList("BoardDAO.getBoardList", vo);
        System.out.println("DAO list :: " + list);
		
		return list;
	}
}