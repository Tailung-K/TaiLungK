<%@page contentType="text/html; charset=utf-8"%>
<%-- <%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%> --%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:out value="${param.seq}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>글 목록</title>

<style>
<!--
body {
    margin-left: 15px;
    margin-top: 0px;
    margin-right: 0px;
    margin-bottom: 0px;
    font-family: D2Coding, 나눔고딕코딩, 맑은 고딕, Arial, Helvetica, sans-serif;
    font-size:12px;
}

th {
    font-family     : D2Coding, 나눔고딕코딩, 맑은 고딕, Arial, Helvetica, sans-serif;
    font-size       : 12px;
}

td {
    font-family     : D2Coding, 나눔고딕코딩, 맑은 고딕, Arial, Helvetica, sans-serif;
    font-size       : 12px;
}
-->
</style>

<script type="text/javascript" src="/js/jquery-3.7.1.js"></script>
<script type="text/javascript" src="/js/xlsx.full.min.js"></script>
<script type="text/javascript" src="/js/FileSaver.min.js"></script>

<script>
var gbChange = false;

$(document).ready(function() {
    console.log("ajax ready~!!!");
    
    var gnSeq = "${param.seq}";
    
    console.log("gnSeq :: " + gnSeq);

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

    $("#searchKeyword").focus();
    
    $("input, select").change(function() {
        gbChange = true;
    });
    
    $("#btnExcel").click(function() {
        fnExportExcel();
    });
    
    
    if (!fnIsEmpty(gnSeq)) {
        fnRetrieve();
    }
    
//     $("#all_chk").click(function() {
//         if ($("#all_chk").is(":checked")) {
//             $("input[type=checkbox]").prop("checked", true);
//         } else {
//             $("input[type=checkbox]").prop("checked", false);
//         }
//     });
  
    
});

function fnS2ab(s) {
    var buf = new ArrayBuffer(s.length); //convert s to arrayBuffer
    var view = new Uint8Array(buf);  //create uint8array as viewer
    
    for (var i=0; i<s.length; i++) {
        view[i] = s.charCodeAt(i) & 0xFF; //convert to octet
    }
    
    return buf;
}

var excelHandler = {
   getExcelFileName : function() {
     return 'test_data.xlsx';   //파일명
   }
,  getSheetName : function() {
     return 'Sheet1';  //시트명
   }
,  getExcelData : function() {
     return document.getElementById('grd_list');   //TABLE id
   }
 , getWorksheet : function(){
     return XLSX.utils.table_to_sheet(this.getExcelData());
   }
}

function fnExportExcel() { 
    // step 1. workbook 생성
    var wb = XLSX.utils.book_new();

    // step 2. 시트 만들기
    var newWorksheet = excelHandler.getWorksheet();

    // step 3. workbook에 새로만든 워크시트에 이름을 주고 붙인다.
    XLSX.utils.book_append_sheet(wb, newWorksheet, excelHandler.getSheetName());

    // step 4. 엑셀 파일 만들기
//     var wbout = XLSX.write(wb, {bookType:'xlsx',  type: 'binary'});
    var wbout = XLSX.write(wb, {bookType:'xlsx',  type: 'binary'});    

    // step 5. 엑셀 파일 내보내기
    saveAs(new Blob([fnS2ab(wbout)],{type:"application/octet-stream"}), excelHandler.getExcelFileName());
}

function fnIsEmpty( agParam ) {
    console.log("agParam :: " + agParam);

    if  (
        typeof agParam == undefined     ||
        typeof agParam == "undefined"   ||
        agParam == undefined            ||
        agParam == "undefined"          ||
        agParam == null                 ||
        agParam == "null"               ||
        agParam == ""
        )
    {
        return true;
    } else {
        return false;
    }
}

function fnNvl( agParam, agDef ) {
    var sRtn = "";
    
    console.log("agParam :: " + agParam);
    console.log("agDef :: " + agDef);

    if  (
        typeof agParam == undefined     ||
        typeof agParam == "undefined"   ||
        agParam == undefined            ||
        agParam == "undefined"          ||
        agParam == null                 ||
        agParam == "null"               ||
        agParam == ""
        )
    {
        sRtn = agDef;
    } else {
        sRtn = agParam;        
    }

    return sRtn;
}

function fnWork() {
    var arrTmp  = new Array(1, "", 1, "", 1, 1, undefined, 1, "", "");
    var nSum    = 0;

    for (var nRow = 0;nRow < arrTmp.length;nRow++) {
        console.log("fnIsEmpty :: " + fnIsEmpty(arrTmp[nRow]));
        
        nSum = nSum + Number( fnNvl(arrTmp[nRow],0) );
        console.log("nSum :: " + typeof nSum, nSum);
    }

    console.log("totSum :: " + nSum);
}

function fnAllCheck( pObj ) {
    if ($("#all_chk").is(":checked")) {
        $("input[type=checkbox]").prop("checked", true);
    } else {
        $("input[type=checkbox]").prop("checked", false);
    }
}

function fnRetrieve() {
    var objDiv  = document.getElementById("div_grid");
    var data    = "";
    var sStx    = "";

    $.ajax({
        url      :   'getBoardList.do'
    ,   type     :   'post'
    ,   async    :   false
    ,   data     :   $("#myForm").serialize()
    ,   dataType :   "json"
    ,   beforeSend: function() {
        
        }
    ,   complete: function() {
        
        }
    ,   success  :   function(rtnData) {
           console.log(rtnData);
           fnCallBack(rtnData);
        }
    ,   error: function (request, status, error) {
           var msg = "Error :: <br><br>";
           msg += request.status + "<br>" + request.responseText + "<br>" + error;
           console.log(msg);
        }
    });
}

function fnCallBack(rtnData) {
    var jsonObj = "";
    var sStx    = "";
    var sSelAll, sSel01, sSel02, sSel03, sSel04, sSel05, sSel06;
    
    sSelAll = sSel01 = sSel02 = sSel03 = sSel04 = sSel05 = sSel06 = "";
    

    jsonObj = eval(rtnData);
    
    console.log("callback :: " + jsonObj);
    
//     $("#div_grid").innerHTML = "";
    document.all["div_grid"].innerHTML = "";
    
    if (jsonObj.length > 0) {
        
        for (var nRow = 0, nTotCnt = jsonObj.length; nRow < nTotCnt; nRow++) {
            result = jsonObj[nRow];
            
            sSelAll = sSel01 = sSel02 = sSel03 = sSel04 = sSel05 = sSel06 = "";            
            
            if (result.rank == null || result.rank == "" || result.rank == undefined || result.rank == "undefined") {
                sSelAll = "Selected";
            } else if (result.rank == "01") {
                sSel01 = "Selected";
            } else if (result.rank == "02") {
                sSel02 = "Selected";
            } else if (result.rank == "03") {
                sSel03 = "Selected";
            } else if (result.rank == "04") {
                sSel04 = "Selected";
            } else if (result.rank == "05") {
                sSel05 = "Selected";
            } else if (result.rank == "06") {
                sSel06 = "Selected";
            }
            
            if (nRow == 0) {
                sStx  = "<table id='grd_list' border='1' cellpadding='0' cellspacing='0' width='750'>\n";
                sStx += "    <tr>\n";
                sStx += "        <th bgcolor='skyblue' width='50'><input id='all_chk' name='all_chk' type='checkbox' onclick='javascript:fnAllCheck(this);'></th>\n";
                sStx += "        <th bgcolor='skyblue' width='100'>순번</th>\n";
                sStx += "        <th bgcolor='skyblue' width='100'>제목</th>\n";
                sStx += "        <th bgcolor='skyblue' width='150'>등록자</th>\n";
                sStx += "        <th bgcolor='skyblue' width='150'>등록일자</th>\n";
                sStx += "        <th bgcolor='skyblue' width='100'>조회건수</th>\n";
                sStx += "        <th bgcolor='skyblue' width='100'>직급</th>\n";
                sStx += "        <th bgcolor='skyblue' width='100'>급여</th>\n";
                sStx += "    </tr>\n";                
            }
            
            sStx += "    <tr>\n";
            sStx += "        <td width='50'  align='center'><input name='chk_seq' type='checkbox' value='" + result.seq + "'></td>\n";
            sStx += "        <td width='50'  align='center'><a href='getBoard.do?seq=" + result.seq + "'>" + (nRow + 1) + "</a></td>\n";
            sStx += "        <td width='100' align='center'><input name='title' size='10' type='text' value='" + result.title + "' style='border: 1px solid blue;border-style:dotted;text-align:center;'></td>\n";
            
//             sStx += "        <td width='150' align='center'><input name='writer' size='10' type='text' value='" + result.writer + "' style='border: 1px solid blue;border-style:dotted;text-align:center;'></td>\n";
//             sStx += "        <td width='150' align='center'><input name='regdate' size='20' type='text' value='" + result.regdate + "' style='border: 1px solid blue;border-style:dotted;text-align:center;'></td>\n";
//             sStx += "        <td width='100' align='center'><input name='cnt' size='5'  type='text' value='" + result.cnt + "' style='border: 1px solid blue;border-style:dotted;text-align:center;'></td>\n";
            
            sStx += "        <td width='150' align='center'>" + result.writer + "</td>\n";
            sStx += "        <td width='150' align='center'>" + result.regdate + "</td>\n";
            sStx += "        <td width='100' align='center'>" + result.cnt + "</td>\n";            
            
            sStx += "        <td width='100' align='center'>\n";
            sStx += "        <select name='rank' id='rank'>\n";
            sStx += "            <option value=''   " + sSelAll + "></option>\n";
            sStx += "            <option value='01' " + sSel01  + ">사원</option>\n";
            sStx += "            <option value='02' " + sSel02  + ">대리</option>\n";
            sStx += "            <option value='03' " + sSel03  + ">과장</option>\n";
            sStx += "            <option value='04' " + sSel04  + ">차장</option>\n";
            sStx += "            <option value='05' " + sSel05  + ">부장</option>\n";
            sStx += "            <option value='06' " + sSel06  + ">이사</option>\n";
            sStx += "        </select>\n";
            sStx += "        </td>\n";
            sStx += "        <td width='100' align='center'><input name='pay' size='10' type='text' value='" + result.pay + "' style='border: 1px solid blue;border-style:dotted;text-align:center;'></td>\n";
            sStx += "    </tr>\n";
            
            sSelAll = sSel01 = sSel02 = sSel03 = sSel04 = sSel05 = "";     
        }
        
        sStx += "</table>\n";
    }
    
    console.log("sStx :: " + sStx);
    
//     $("#div_grid").innerHTML = sStx;
//     document.all["#div_grid"].innerHTML = sStx;

    $("#div_grid").append(sStx);
}
</script>
</head>

<%-- <c:if test="${not empty param.seq}"> --%>
<!--   document.write("&lt;script&gt;"); -->
<!--   document.write("document.myForm.action = 'javascript:fnRetrieve();';"); -->
<!--   document.write("document.myForm.submit();"); -->
<!--   document.write("&lt\/script&gt;"); -->
<%-- </c:if> --%>

<body>
	<center>
		<h1></h1>
		<p>${userName} - [ <a href="logout.do">Logout</a> ] </p>
    
		<!-- 검색 시작 -->
		<form id="myForm" name="myForm" action="javascript:fnRetrieve();" method="post">
			<table border="0" cellpadding="1" cellspacing="0" width="700">
				<tr>
					<td align="center">
					<select id="searchCondition" name="searchCondition">
                      <option value="TITLE">제목     
                      <option value="CONTENT">내용
					</select>
					<input id="searchKeyword" name="searchKeyword" type="text" size="50"/>
					<input type="submit" value="조회"/>
<!--                     <input id="btnWrite" name="btnWrite" type="button" value="등록" onclick="javascript:location.href='insertBoard.jsp'"/> -->
                    <input id="btnSave" name="btnSave" type="button" value="저장"/>
                    <input id="btnExcel" name="btnExcel" type="button" value="엑셀"/>
					</td>
				</tr>
			</table>

		</form>
		<!-- 검색 종료 -->
        
        <!-- 저장 시작 -->
        <form id="mySaveForm" name="mySaveForm" action="" method="post">
        <div id="div_grid"></div>
        </form>
        <!-- 저장 종료 -->
        
	</center>
 
</body>
</html>