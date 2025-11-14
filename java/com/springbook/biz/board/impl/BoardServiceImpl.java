package com.springbook.biz.board.impl;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springbook.biz.board.BoardService;
import com.springbook.biz.board.BoardVO;

/**
 * 
 * 1. ClassName : 
 * 2. FileName  : BoardServiceImpl.java
 * 3. Package   : com.springbook.biz.board.impl
 * 4. Commnet   : 
 * 5. 작성자    : TaiLung-K
 * 6. 작성일    : 2025. 11. 13. 오후 5:56:19
 */
@Service("boardService")
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardDAOMybatis boardDAO;
	
    private Logger logger = LoggerFactory.getLogger( this.getClass() );	

	public int insertBoard(BoardVO vo) {
	    int nRtn = 0;
	    
//		if (vo.getSeq() == 0) {
//			throw new IllegalArgumentException("0번 글은 등록할 수 없습니다.");
//		}
	    
	    nRtn = boardDAO.insertBoard(vo);
	    
        return nRtn;
	}

	public int updateBoard(BoardVO vo) {
	    int nRtn = boardDAO.updateBoard(vo);
	    
        return nRtn;
	}
	
    public int deleteBoard(BoardVO vo) {
        int nRtn = boardDAO.deleteBoard(vo);
        
        return nRtn;
    }
	
    public int insertForList(BoardVO vo) {
        int nRtn = boardDAO.insertForList( vo );
        
        return nRtn;
    }

    public int updateForList(BoardVO vo) {
        int nRtn = boardDAO.updateForList( vo );
        
        return nRtn;
    }
    
    public int deleteForList(BoardVO vo) {
        int nRtn = boardDAO.deleteForList( vo );
        
        return nRtn;
    }

	public BoardVO getBoard(BoardVO vo) {
	    BoardVO brdVo;
	    
        System.out.println("Service VO :: " + vo);        
		brdVo = boardDAO.getBoard(vo);
        System.out.println("Service brdVo :: " + brdVo);        
		
        return brdVo;
	}

	public List<BoardVO> getBoardList(BoardVO vo) {
	    List<BoardVO> list = new ArrayList<BoardVO>();
	    
        System.out.println("Service VO :: " + vo);
        list = boardDAO.getBoardList(vo);
        System.out.println("Service list :: " + list);        
        
		return list;
	}
	
    public int countBoard(BoardVO vo) {
        int nRtn = boardDAO.countBoard(vo);
        return nRtn;       
    }
    

}