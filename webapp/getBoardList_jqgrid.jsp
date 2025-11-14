<%@page contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>글 목록</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<style type="text/css">
<!--
    body {
        margin-left: 15px;
        margin-top: 0px;
        margin-right: 0px;
        margin-bottom: 0px;
        font-family: D2Coding, 나눔고딕코딩, 맑은 고딕, Arial,Helvetica,sans-serif;
        font-size:12px;
    }
-->
</style>

<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
<link rel="stylesheet" href="/css/jquery-ui.css">
<link rel="stylesheet" href="/css/ui.jqgrid.css">
<script type="text/javascript" src="/js/jquery-ui.js"></script>
<script type="text/javascript" src="/js/jqgrid/jquery.jqGrid.js"></script>
<script type="text/javascript" src="/js/jqgrid/i18n/grid.locale-kr.js"></script>

<!-- <script type="text/javascript" src="/js/jquery.table2excel.js"></script> -->
<!-- <script type="text/javascript" src="/js/xlsx.full.min.js"></script> -->
<!-- <script type="text/javascript" src="/js/FileSaver.min.js"></script> -->
<!-- <script type="text/javascript" src="/js/html2canvas.min.js"></script> -->
<!-- <script type="text/javascript" src="/js/xlsx.core.min.js"></script> -->
<!-- <script type="text/javascript" src="/js/tableExport.js"></script> -->
<!-- <script type="text/javascript" src="/js/jquery.base64.js"></script> -->
<!-- <script type="text/javascript" src="/js/jszip.min.js"></script> -->
<!-- <script src="https://rawgit.com/free-jqgrid/jqGrid/master/js/jquery.jqgrid.src.js"></script> -->
<!-- <script type="text/javascript" src="/js/i18n/grid.locale-en.js"></script> -->
<!-- <script type="text/javascript" src="/js/jquery-3.5.1.min.js"></script> -->
<!-- <script type="text/javascript" src="/js/jquery.jqgrid.min.js"></script> -->
<!-- <link rel="stylesheet" href="https://rawgit.com/free-jqgrid/jqGrid/master/css/ui.jqgrid.css"> -->
<!-- <script src="https://rawgit.com/free-jqgrid/jqGrid/master/js/jquery.jqgrid.src.js"></script> -->

<script>
$(document).ready(function() {
    console.log("ajax ready...");
    
//     $("#btnExcel").on("click", function() {
//         $("#tb_grid").table2excel({
//             exclude: ".excludeThisClass"
//           , name: "Worksheet Name"
//           , filename: "list.xls" // do include extension
//           , preserveColors: false // set to true if you want background colors and font colors preserved

//         });
//     });
    
//     $("#btnExcel").on("click", function() {
//         $("#tb_grid").table2excel({
//             exclude: ".excludeThisClass"
//           , name: "엑셀"
//           , filename: "엑셀"
//           , fileext: ".xls"
//           , exclude_img: true
//           , exclude_links: true
//           , exclude_inputs: true
//           , preserveColors: false
//         });
//     });
    
});


function fnRetrieve() {
    var objFrmData = $("#myForm").serialize();
    
    console.log("form data :: " + $("#myForm").serialize());
//     alert("form searchCondition :: " +  $("#searchCondition").val() + " searchKeyword :: " + $("#searchKeyword").val());
    
    // Grid 초기화
    $("#tb_grid").jqGrid("GridUnload")
    
    // Grid 조회
    $("#tb_grid").jqGrid({
        url         :   'getBoardList.do'
      , mtype       :   'POST'
      , datatype    :   'json'
//       , datatype    :   "local"
//       , postData    :   $("#myForm").serialize()
      , postData    :   { "searchCondition" : $("#searchCondition").val(), "searchKeyword" : $("#searchKeyword").val() }
//         postData    :   { "param1": $("#param1").val(),"param2" : $("#param2").val() }
      , colNames    :   [ '번호', '제목', '등록자', '등록일자', '조회건수', '급여' ]
      , colModel    : 
        [
            {
              name     : 'seq'
            , index    : 'seq'
            , label    : '번호'
            , align    : 'center'
            , width    : '100px'
            , key      : true
            , editable : true
            , hidden   : true
            }
          , {
              name  : 'title'
            , index : 'title'
            , label : '제목'
            , align : 'center'
            , width : '100px'
            }
          , {
              name  : 'writer'  
            , index : 'writer'  
            , label : '등록자'    
            , align : 'center'
            , width : '150px'
            }
          , {
              name  : 'regdate' 
            , index : 'regdate' 
            , label : '등록일자'  
            , align : 'center'
            , width : '110px'
            , sorttype : 'date'
            }
          , {
              name  : 'cnt'     
            , index : 'cnt'     
            , label : '조회건수'  
            , align : 'center'
            , width : '100px'
            }
          , {
              name  : 'pay'     
            , index : 'pay'     
            , label : '급여'  
            , align : 'center'
            , width : '140px'
            }
        ]
      , multiselect : true
      , multikey    : "ctrlKey"

      , pager       : ""
      , rowNum      : 0
//       , page        : 1
//       , pgbuttons   : true
//       , rowList     : [10,20,30,40,50,100]
//       , jsonReader : {
//            root         : "rows"
//          , page         : "page"
//          , total        : "total"
//          , records      : "records"
//          , repeatitems  : false
//        }
//           , rownumbers  : true

      , headertitles: true
      , toppager    : false
      , viewrecord  : true
      , gridview    : true
      , loadonce    : false
      , loadui      : "enable"
      , loadtext    : '데이터 조회중...'
//           , autowidth   : true
//       , height      : 'auto'

      , editurl     : 'clientArray'
      , height      : 400
      , width       : 700
      , shrinkToFit : false
      , refresh     : true
      , ignoreCase  : false
      , loadComplete : function(data) {
          var jsonObj = {};

//           alert("success :: " + data);

          jsonObj = data;
//           jsonObj = eval(data);          
          console.log("jsonObj :: " + typeof jsonObj, jsonObj);
//           fnCallBack(data);
        }
      , loadError   : function(xhr, status, error) {
          alert("xhr :: " + xhr + " status :: " + status + " error :: " + error);
        }
      , beforeRequest : function () {
//           alert("form data :: " + $("#myForm").serialize());
        }
//       , onPaging : function () {
//           alert("page :: " + $("#tb_grid").getGridParam("page") + " / " + $("#tb_grid").getGridParam("total") + " / " + $("#tb_grid").getGridParam("records"));
//       }      

//       , iconSet     : "fontAwesome"

      , sortname    : "regdate"
      , sortorder   : "desc"
      , caption     : ""
    });
    
    // Grid 파라미터 저장 및 재조회
    $("#tb_grid").setGridParam({
        datatype        : "json"
      , postData        : { "searchCondition" : $("#searchCondition").val(), "searchKeyword" : $("#searchKeyword").val() }
      , loadComplete    : function(data) {
        }
      , gridComplete    : function() {
        }
    }).trigger("reloadGrid");
    
//     $("#tb_grid").jqGrid('navGrid', '#div_page', {
//         add: false,
//         edit: false,
//         del: false,
//         search: false,
//         refresh: false
//     });
    
//     $("#tb_grid").jqGrid( 'navButtonAdd', "#div_page", {
//         caption : "Export to CSV",
//         buttonicon : "ui-icon-arrowthickstop-1-s",
//         onClickButton : function() {
//             $("#tb_grid").jqGrid('excelExport',{"url":"./excel.do"});
//         },
//         position : "first",
//         title : "Export to CSV",
//     });

//  var options = {
//  includeLabels : true,
//  includeGroupHeader : true,
//  includeHeader: true,
//  fileName : "list.xlsx",
//  mimetype : "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
//  maxlength : 40,
//  onBeforeExport : null,
//  replaceStr : null,
//  loadIndicator : true,
//  treeindent : ' '
//}

//$("#btnExcel").on("click", function() {
//$("#tb_grid").jqGrid('exportToExcel', options);
//});

//$("#tb_grid").jqGrid('navGrid','#div_page',{add:true,edit:true,del:true});

// $("#tb_grid").jqGrid('navButtonAdd','#div_page',{
//     caption:"", 
//     onClickButton : function () {
//         $("#tb_grid").excelExport();
//     } 
// });

// $("#tb_grid").jqGrid('navButtonAdd','#div_page',{
//     caption:"Export", 
//     onClickButton : function () { 
//     exportExcel();
//     }
// }); 
    
//     $("#btnExcel").on("click", function() {
//         var exp = $("#tb_grid").jqGrid("jqGridExport", {
//          exptype : 'xmlstring',
//          root : 'grid',
//          ident: '\t'
//         });
        
//         alert("export :: " + exp);
//     });

//     $("#btnExcel").on("click", function() {
//         $("#tb_grid").table2excel({
//             exclude: ".excludeThisClass",
//             name: "Worksheet Name",
//             filename: "sample.xls", // do include extension
//             preserveColors: false // set to true if you want background colors and font colors preserved
//         });
//     });
//}


// function fnRetrieve() {
//     var objDiv  = document.getElementById("div_grid");
//     var data    = "";
//     var sStx    = "";

//     $.ajax({
//         url      :   'getBoardList.do'
//     ,   type     :   'post'
//     ,   async    :   false
//     ,   data     :   $("#myForm").serialize()
//     ,   dataType :   "json"
//     ,   beforeSend: function() {
        
//         }
//     ,   complete: function() {
        
//         }
//     ,   success  :   function(rtnData) {
//            console.log(rtnData);
//            fnCallBack(rtnData);
//         }
//     ,   error: function (request, status, error) {
//            var msg = "ERROR<br><br>";
//            msg += request.status + "<br>" + request.responseText + "<br>" + error;
//            console.log(msg);
//         }
//     });
// }

// function fnCallBack(rtnData) {
//     var jsonObj = "";
//     var sStx    = "";

//     jsonObj = eval(rtnData);
    
//     console.log("callback :: " + jsonObj);    
    
//     sStx += "<table id='grd_list' border='1' cellpadding='0' cellspacing='0' width='700'>\n";
//     sStx += "    <tr>\n";
//     sStx += "        <th bgcolor='orange' width='100'>번호</th>\n";
//     sStx += "        <th bgcolor='orange' width='200'>제목</th>\n";
//     sStx += "        <th bgcolor='orange' width='150'>등록자</th>\n";
//     sStx += "        <th bgcolor='orange' width='150'>등록일자</th>\n";
//     sStx += "        <th bgcolor='orange' width='100'>조회건수</th>\n";
//     sStx += "        <th bgcolor='orange' width='100'>급여</th>\n";
//     sStx += "    </tr>\n";
    
//     for (var nRow = 0, nCnt = jsonObj.length; nRow < nCnt; nRow++) {
//         result = jsonObj[nRow];
        
//         sStx += "    <tr>\n";
//         sStx += "        <td>" + result.seq + "</td>\n";
//         sStx += "        <td align='left'><a href='getBoard.do?seq=" + result.seq + "'>" + result.title + "</a></td>\n";
//         sStx += "        <td>" + result.writer + "</td>\n";
//         sStx += "        <td>" + result.regdate + "</td>\n";
//         sStx += "        <td>" + result.cnt + "</td>\n";
//         sStx += "        <td>" + result.pay + "</td>\n";
//         sStx += "    </tr>\n";
//     }
    
//     sStx += "</table>\n";
    
//     console.log("sStx :: " + sStx);
    
//     $("#div_grid").append(sStx);
// }

</script>
</head>


<!-- conditionMap.put("제목", "TITLE"); -->
<!-- conditionMap.put("내용", "CONTENT"); -->

<body>
	<center>
		<h1></h1>
		<h3>${userName}&nbsp;&nbsp; - <a href="logout.do">[ Logout ]</a></h3>  
		<!-- 검색 시작 -->
		<form id="myForm" name="myForm" action="javascript:fnRetrieve();" method="post">
			<table border="1" cellpadding="1" cellspacing="0" width="700">
				<tr>
					<td align="center">
					<select id="searchCondition" name="searchCondition">
                      <option value="CONTENT">내용
					  <option value="TITLE">제목
					</select>
					<input id="searchKeyword" name="searchKeyword" type="text" size="50"/>
					<input type="submit" value="조회"/>
                    <input id="btnWrite" name="btnWrite" type="button" value="등록" onclick="javascript:location.href='insertBoard.jsp'"/>
                    <input id="btnExcel" name="btnExcel" type="button" value="엑셀"/>
					</td>
				</tr>
			</table>
		</form>
        
		<!-- 검색 종료 -->
  
<!--         검색 시작 -->
<!--         <form name="myForm" action="javascript:fnRetrieve();" method="post"> -->
<!--             <table border="1" cellpadding="0" cellspacing="0" width="700"> -->
<!--                 <tr> -->
<!--                     <td align="right"> -->
<!--                     <select id="searchCondition" name="searchCondition"> -->
<%--                         <c:forEach items="${conditionMap}" var="option"> --%>
<%--                             <option value="${option.value}">${option.key} --%>
<%--                         </c:forEach>                             --%>
<!--                     </select>  -->
<!--                     <input id="searchKeyword" name="searchKeyword" type="text" />  -->
<%--                     <input type="submit" value="<spring:message code="message.board.list.search.condition.btn"/>"/> --%>
<!--                     </td> -->
<!--                 </tr> -->
<!--             </table> -->
<!--         </form> -->
<!--         검색 종료   -->


        <br/>
        <table id="tb_grid"></table>
        <div id="div_page"></div>
        
<!-- 		<a href="insertBoard.jsp" title="글 등록하기"></a> -->
<!-- 		<table id="tb_grid" border="1" cellpadding="0" cellspacing="0" width="700"> -->
<!-- 			<tr> -->
<!-- 				<th bgcolor="orange" width="100"> -->
<%-- 				<spring:message	code="message.board.list.table.head.seq" /></th> --%>
<!-- 				<th bgcolor="orange" width="200"> -->
<%-- 				<spring:message code="message.board.list.table.head.title" /></th> --%>
<!-- 				<th bgcolor="orange" width="150"> -->
<%-- 				<spring:message code="message.board.list.table.head.writer" /></th> --%>
<!-- 				<th bgcolor="orange" width="150"> -->
<%-- 				<spring:message code="message.board.list.table.head.regDate" /></th> --%>
<!-- 				<th bgcolor="orange" width="100"> -->
<%-- 				<spring:message code="message.board.list.table.head.cnt" /></th> --%>
<!-- 			</tr> -->
<%-- 			<c:forEach items="${boardList}" var="board"> --%>
<!-- 				<tr> -->
<%-- 					<td>${board.seq}</td> --%>
<%-- 					<td align="left"><a href="getBoard.do?seq=${board.seq}"> --%>
<%-- 							${board.title}</a></td> --%>
<%-- 					<td>${board.writer}</td> --%>
<%-- 					<td><fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd"/></td> --%>
<%-- 					<td>${board.cnt}</td> --%>
<!-- 				</tr> -->
<%-- 			</c:forEach> --%>
<!-- 		</table> -->

<!-- 		<a href="insertBoard.jsp" title="글 등록하기"></a> -->
	</center>
</body>
</html>