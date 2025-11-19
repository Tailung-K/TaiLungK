package com.springbook.view.board;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.springbook.biz.board.BoardService;
import com.springbook.biz.board.BoardVO;

@Controller
@SessionAttributes("board")
public class BoardController {
    @Autowired
    private BoardService boardService;

    private Logger logger = LoggerFactory.getLogger( this.getClass() );

    /**
     * 
     * 1. MethodName        : dataTransform
     * 2. ClassName         : BoardController
     * 3. Commnet           : 
     * 4. 작성자            : TaiLung-K
     * 5. 작성일            : 2022. 4. 11. 오전 12:25:48
     * @return                List<BoardVO>
     * @param boardVo
     * @return
     */
    @RequestMapping("/dataTransform.do")
    @ResponseBody
    public List<BoardVO> dataTransform( BoardVO boardVo ) {
//      boardVo.setSearchCondition("TITLE");
//      boardVo.setSearchKeyword("");
//      List<BoardVO> boardList = boardService.getBoardList(boardVo);
//      BoardListVO boardListVO = new BoardListVO();
//      boardListVO.setBoardList(boardList);
//      return boardListVO;

        boardVo.setSearchCondition( "TITLE" );
        boardVo.setSearchKeyword( "" );
        
        List<BoardVO> boardList = boardService.getBoardList( boardVo );

        return boardList;
    }

    
    /**
     * 
     * 1. MethodName        : insertBoard
     * 2. ClassName         : BoardController
     * 3. Commnet           : 글 등록
     * 4. 작성자            : TaiLung-K
     * 5. 작성일            : 2022. 4. 11. 오전 12:25:55
     * @return                String
     * @param boardVo
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/insertBoard.do")
    public String insertBoard( BoardVO boardVo ) throws IOException {

        // 파일 업로드 처리
        MultipartFile uploadFile = boardVo.getUploadFile();
        if ( !uploadFile.isEmpty() ) {
            String fileName = uploadFile.getOriginalFilename();
            uploadFile.transferTo( new File( "D:/" + fileName ) );
        }

        boardService.insertBoard( boardVo );

//        return "getBoardList.do";
        return "getBoardList.jsp"; // View 이름 리턴        
    }

    /**
     * 
     * 1. MethodName        : updateBoard
     * 2. ClassName         : BoardController
     * 3. Commnet           : 글 수정
     * 4. 작성자            : TaiLung-K
     * 5. 작성일            : 2022. 4. 11. 오전 12:26:37
     * @return                String
     * @param boardVo
     * @return
     */
    @RequestMapping("/updateBoard.do")
    public String updateBoard( @ModelAttribute("board") BoardVO boardVo ) {
        boardService.updateBoard( boardVo );

//        return "getBoardList.do";
        return "getBoardList.jsp"; // View 이름 리턴        
    }
    
    /**
     * 
     * 1. MethodName        : deleteBoard
     * 2. ClassName         : BoardController
     * 3. Commnet           : 
     * 4. 작성자            : TaiLung-K
     * 5. 작성일            : 2025. 11. 13. 오후 5:48:50
     * @return                String
     * @param boardVo
     * @return
     */
    // 글 삭제
    @RequestMapping("/deleteBoard.do")
    public String deleteBoard( BoardVO boardVo ) {
        boardService.deleteBoard( boardVo );

//        return "getBoardList.do";
        return "getBoardList.jsp"; // View 이름 리턴        
    }    
    
    
    /**
     * 
     * 1. MethodName        : insertForList
     * 2. ClassName         : BoardController
     * 3. Commnet           : 
     * 4. 작성자            : TaiLung-K
     * 5. 작성일            : 2025. 11. 13. 오후 5:54:21
     * @return                String
     * @param boardVo
     * @param req
     * @param res
     * @return
     * @throws IOException
     */
    // 다건 글 등록
    @RequestMapping(value = "/insertForList.do")
    public String insertForList( BoardVO boardVo, HttpServletRequest req, HttpServletResponse res ) throws IOException {
        boardService.insertBoard( boardVo );

//        return "getBoardList.do";
        return "getBoardList.jsp"; // View 이름 리턴        
    }


    /**
     * 
     * 1. MethodName        : updateForList
     * 2. ClassName         : BoardController
     * 3. Commnet           : 
     * 4. 작성자            : TaiLung-K
     * 5. 작성일            : 2022. 4. 11. 오전 12:27:51
     * @return                String
     * @param boardVo
     * @return
     */
    // 다건 글 수정
    @RequestMapping("/updateForList.do")
    public String updateForList( @ModelAttribute("board") BoardVO boardVo, HttpServletRequest req, HttpServletResponse res ) {
        boardService.updateBoard( boardVo );

//        return "getBoardList.do";
        return "getBoardList.jsp"; // View 이름 리턴        
    }
    
    /**
     * 
     * 1. MethodName        : deleteForList
     * 2. ClassName         : BoardController
     * 3. Commnet           : 
     * 4. 작성자            : TaiLung-K
     * 5. 작성일            : 2022. 4. 11. 오전 12:28:08
     * @return                String
     * @param boardVo
     * @return
     */
    // 다건 글 삭제
    @RequestMapping("/deleteForList.do")
    public String deleteForList( BoardVO boardVo, HttpServletRequest req, HttpServletResponse res ) {
        boardService.deleteBoard( boardVo );

//        return "getBoardList.do";
        return "getBoardList.jsp"; // View 이름 리턴        
    }


    /**
     * 
     * 1. MethodName        : getBoard
     * 2. ClassName         : BoardController
     * 3. Commnet           : 
     * 4. 작성자            : TaiLung-K
     * 5. 작성일            : 2022. 4. 11. 오전 12:28:19
     * @return                String
     * @param boardVo
     * @param model
     * @return
     */
    // 글 상세 조회
    @RequestMapping("/getBoard.do")
    public String getBoard( BoardVO boardVo, Model model ) {
        model.addAttribute( "board", boardService.getBoard( boardVo ) ); // Model 정보 저장

        return "getBoard.jsp"; // View 이름 리턴
    }
    

    /**
     * 
     * 1. MethodName        : searchConditionMap
     * 2. ClassName         : BoardController
     * 3. Commnet           : 
     * 4. 작성자            : TaiLung-K
     * 5. 작성일            : 2022. 4. 11. 오전 12:28:25
     * @return                Map<String,String>
     * @return
     */
    // 검색 조건 목록 설정
    @ModelAttribute("conditionMap")
    public Map<String, String> searchConditionMap() {
        Map<String, String> conditionMap = new HashMap<String, String>();
        conditionMap.put( "제목", "TITLE" );
        conditionMap.put( "내용", "CONTENT" );

        return conditionMap;
    }


    /**
     * 
     * 1. MethodName        : getBoardList
     * 2. ClassName         : BoardController
     * 3. Commnet           : 
     * 4. 작성자            : TaiLung-K
     * 5. 작성일            : 2022. 4. 11. 오전 12:28:41
     * @return                String
     * @param boardVo
     * @param req
     * @param res
     * @return
     * @throws Exception
     */
    // 글 목록 검색
    @RequestMapping(value = "/getBoardList.do", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getBoardList( BoardVO boardVo, HttpServletRequest req, HttpServletResponse res ) throws Exception {
//    public String getBoardList(
//            @RequestParam(value="searchCondition", defaultValue="TITLE", required=false)    String sCond,
//            @RequestParam(value="searchKeyword", defaultValue="", required=false)           String sKeyWord,
//            BoardVO boardVo, HttpServletRequest req, HttpServletResponse res) throws Exception {
//    public List<BoardVO> getBoardList(BoardVO boardVo, HttpServletRequest req, HttpServletResponse res) throws Exception {

//        int nCurPage     = Integer.parseInt(StringUtils.defaultString( req.getParameter("page"), "0" )); // 현재 페이지
//        int nLimit       = Integer.parseInt(StringUtils.defaultString( req.getParameter("rows"), "0" )); // PageSize
//        int nTotPage     = Integer.parseInt(StringUtils.defaultString( req.getParameter("total"), "0" )); // Page 전체 건수
//        int nTotRow      = Integer.parseInt(StringUtils.defaultString( req.getParameter("records"), "0")); // Row 전체 건수

//        int nStartRows      = 0;
//        int nEndRows        = 0;
//        int nOffset         = 0;
//        int nRowCnt         = 0;

//        logger.debug( "nCurPage :: " + nCurPage);
//        logger.debug( "nLimit   :: " + nLimit  );
//        logger.debug( "nTotPage :: " + nTotPage);
//        logger.debug( "nTotRow  :: " + nTotRow );
        
        logger.debug( "boardVo before  :: " + boardVo.toString() );


        if ( StringUtils.isEmpty(boardVo.getSearchCondition()) ) {
            boardVo.setSearchCondition( "TITLE" );
        }

        if ( StringUtils.isEmpty(boardVo.getSearchKeyword()) ) {
            boardVo.setSearchKeyword( "%" );
        } else {
            boardVo.setSearchKeyword( "%" + boardVo.getSearchKeyword() + "%" );            
        }

        logger.debug( "boardVo after :: " + boardVo.toString() );

//        // Model 정보 저장
//        model.addAttribute("boardList", boardService.getBoardList(boardVo));
//        return "getBoardList.jsp"; // View 이름 리턴


        // Paging 처리
//        nRowCnt = boardService.countBoard(boardVo);
//        
//        if ( nRowCnt > 0 ) {
//            nTotPage = ( int ) Math.ceil(nRowCnt / nLimit);
//        } else {
//            nTotPage = 0;
//        }
//        
//        nStartRows  = nLimit * nCurPage - nLimit;
//        
//        boardVo.setLimit( nStartRows );
//        boardVo.setOffset( nLimit );
//        
//        if ( nCurPage > nTotPage ) {
//            nCurPage = nTotPage;
//        }
//        
//        boardVo.setPage( nCurPage );
//        
//        logger.debug("nRowCnt :: " + nRowCnt); 
//        logger.debug("nTotPage :: " + nTotPage);
//        logger.debug("nStartRows :: " + nStartRows);
//        logger.debug("nLimit  :: " + nLimit );
//        logger.debug("nCurPage  :: " + nCurPage );
        

//        nStartRows = (boardVo.getPage() - 1) * boardVo.getPageSize();
//
//        logger.debug("nStartRows :: " + nStartRows);
//
//        if ( nRowCnt > boardVo.getPage() * boardVo.getPageSize() ) {
//            nEndRows = boardVo.getPage() * boardVo.getPageSize();
//        } else {
//            nEndRows = nRowCnt;
//        }
        
//        logger.debug("nEndRows :: " + nEndRows);


        List<BoardVO> boardList = boardService.getBoardList(boardVo);
        logger.debug("boardList :: " + boardList.size());
        
//        List<BoardVO> rows = boardList.subList(nStartRows, nEndRows);
//        logger.debug("rows :: " + rows);
        
//        <result property="title" column="TITLE" />
//        <result property="writer" column="WRITER" />
//        <result property="content" column="CONTENT" />
//        <result property="regdate" column="REG_DATE" />
//        <result property="cnt" column="CNT" />
//        <result property="pay" column="PAY" />
//        <result property="rank" column="RANK" />

        res.setContentType("application/json;charset=utf-8");

        JSONObject  jsObjPage   = new JSONObject();
        JSONArray   jsArray     = new JSONArray();

        if (boardList.size() > 0) {
            for (int nRow = 0;nRow < boardList.size();nRow++) {
                JSONObject jsObj = new JSONObject();

                jsObj.put("seq"       , boardList.get(nRow).getSeq());
                jsObj.put("title"     , boardList.get(nRow).getTitle());
                jsObj.put("writer"    , boardList.get(nRow).getWriter());
                jsObj.put("content"   , boardList.get(nRow).getContent());
                jsObj.put("regdate"   , boardList.get(nRow).getRegdate());
                jsObj.put("cnt"       , boardList.get(nRow).getCnt());
                jsObj.put("pay"       , boardList.get(nRow).getPay());
                jsObj.put("rank"      , boardList.get(nRow).getRank());                

                jsArray.put( jsObj );
            }
            
//            jsObjPage.put("rows"    , jsArray.toString());
//            jsObjPage.put("page"    , nCurPage);
//            jsObjPage.put("total"   , nTotPage);
//            jsObjPage.put("records" , nRowCnt);
//
//            // Paging
//            jsArray.put( jsObjPage );
        }

//        logger.debug("currPage :: " + boardVo.getPage());
//        logger.debug("totPage :: " + (int) Math.ceil(boardList.size() / boardVo.getPageSize()) + 1);

        logger.debug("jsObjPage :: " + jsObjPage);
//        logger.debug("jsonData :: " + jsArray);
        logger.debug("jsonData :: " + jsArray.toString());

        return jsArray.toString();
    }
    

    /**
     * 
     * 1. MethodName        : getList
     * 2. ClassName         : BoardController
     * 3. Commnet           : 
     * 4. 작성자            : TaiLung-K
     * 5. 작성일            : 2022. 4. 11. 오전 12:28:52
     * @return                String
     * @return
     */
    // 글 목록
    @RequestMapping("/getList.do")
    public String getList() {
        return "getBoardList.jsp"; // View 이름 리턴
    }


    /**
     * 
     * 1. MethodName        : index
     * 2. ClassName         : BoardController
     * 3. Commnet           : 
     * 4. 작성자            : TaiLung-K
     * 5. 작성일            : 2022. 4. 11. 오전 12:29:07
     * @return                String
     * @return
     */
    // index
    @RequestMapping("/index.do")
    public String index() {
        return "index.jsp"; // View 이름 리턴
    }

//  @RequestMapping("/getBoardList.do")
//  public String getBoardList(BoardVO boardVo, Model model) {
//      // Null Check
//      if (boardVo.getSearchCondition() == null)
//          boardVo.setSearchCondition("TITLE");
//      if (boardVo.getSearchKeyword() == null)
//          boardVo.setSearchKeyword("");
//
//      // Model 정보 저장
//      model.addAttribute("boardList", boardService.getBoardList(boardVo));
//      return "getBoardList.jsp"; // View 이름 리턴
//  }
    

}
