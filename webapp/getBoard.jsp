<%@page contentType="text/html; charset=utf-8"%>
<%-- <%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%> --%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<c:out value="${board.regdate}"/>

<%-- rank 목록을 JSTL 배열로 정의 --%>
<c:set var="ranks">
    <c:out value="01,사원;02,대리;03,과장;04,차장;05,부장;06,이사"/>
</c:set>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>글 상세</title>
<style type="text/css">
<!--
    body, td {
        margin-left: 15px;
        margin-top: 0px;
        margin-right: 0px;
        margin-bottom: 0px;
        font-family: D2Coding, 나눔고딕코딩, 맑은 고딕, Arial,Helvetica,sans-serif;
        font-size:12px;
    }
-->
</style>

</head>
<body>
	<center>
		<h1>글 상세</h1>
		<a href="logout.do">Log-out</a>
		<hr>
		<form action="updateBoard.do" method="post">
			<input name="seq" type="hidden" value="${board.seq}" />
			<table border="1" cellpadding="0" cellspacing="0">
				<tr>
					<td bgcolor="skyblue" width="70">제목</td>
					<td align="left"><input name="title" type="text" value="${board.title}"/></td>
				</tr>
				<tr>
					<td bgcolor="skyblue">작성자</td>
					<td align="left"><input name="writer" type="text" value="${board.writer}"/></td>
				</tr>
				<tr>
					<td bgcolor="skyblue">내용</td>
					<td align="left">
                    <textarea name="content" cols="40" rows="20">${board.content}</textarea></td>
				</tr>
				<tr>
					<td bgcolor="skyblue">등록일</td>
					<td align="left">${board.regdate}</td>
				</tr>
				<tr>
					<td bgcolor="skyblue">조회수</td>
					<td align="left"><input name="cnt" type="text" value="${board.cnt}"/></td>
				</tr>
                <tr>
                    <td bgcolor="skyblue">급여</td>
                    <td align="left"><input name="pay" type="text" value="${board.pay}"/></td>
                </tr>
                <tr>
                    <td bgcolor="skyblue">직급</td>
                    <td align="left">
                    <select name="rank" id="rank">
                        <option value=""></option>
                    
                        <c:forTokens items="${ranks}" delims=";" var="rec">
                            <c:set var="code" value="${fn:split(rec, ',')[0]}" />
                            <c:set var="name" value="${fn:split(rec, ',')[1]}" />                    
                            <option value="${code}" ${board.rank == code ? 'selected' : ''}>
                                ${name}
                            </option>
                        </c:forTokens>
                    </select>

<%--                     <select name='rank' id='rank'>
                        <option value='' <c:if test="${empty board.rank}">Selected</c:if>></option>
                        <option value='01' <c:if test="${board.rank == '01'}">Selected</c:if>>사원</option>
                        <option value='02' <c:if test="${board.rank == '02'}">Selected</c:if>>대리</option>
                        <option value='03' <c:if test="${board.rank == '03'}">Selected</c:if>>과장</option>
                        <option value='04' <c:if test="${board.rank == '04'}">Selected</c:if>>차장</option>
                        <option value='05' <c:if test="${board.rank == '05'}">Selected</c:if>>부장</option>
                        <option value='06' <c:if test="${board.rank == '06'}">Selected</c:if>>이사</option>
                    </select> --%>
                    <%-- <input name="rank" type="text" value="${board.rank}"/> --%>
                    </td>
                </tr>
				<tr>
					<td colspan="2" align="center"><input type="submit" value="글 수정" /></td>
				</tr>
			</table>
		</form>
		<hr>
<!-- 		<a href="insertBoard.jsp">글등록</a>&nbsp;&nbsp;&nbsp;  -->
		<a href="deleteBoard.do?seq=${board.seq}">글삭제</a>&nbsp;&nbsp;&nbsp;
		<a href="getList.do?seq=${board.seq}">글목록</a>
	</center>
</body>
</html>
