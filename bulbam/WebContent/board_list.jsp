<%@page import="kr.hs.dgsw.web.domain.BoardList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="kr.hs.dgsw.web.service.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String sCurrentPage = request.getParameter("page");
int currentPage = 0;

try
{
	currentPage = Integer.parseInt(sCurrentPage);
}
catch (NumberFormatException e) 
{
	currentPage = 1;
}
if (currentPage <= 0)
{
	currentPage = 1;
}

UserService service = UserService.getInstance();

int countOfArticles = service.getCountOfArticles(); //총 게시물 개수
int countOfPages = ((countOfArticles-1)/10)+1; //총 페이지 개수
int firstPage = (currentPage/10)*10+1;
int lastPage = (currentPage/10)*10+10;

if(countOfPages<lastPage){
	lastPage = countOfPages;
}

List<BoardList> list = service.BoardList();

System.out.println(firstPage);
System.out.println(lastPage);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta charset="utf-8">
    <meta name="apple-mobile-wep-app-capable" content="yes" />
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>Boad List</title>
    <!--[if lt IE 9]>
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <script src="include/js/jquery-3.0.0.min.js"></script>
    <link rel='stylesheet' href="include/css/bootstrap.css" />
</head>


<!-- body 시작 -->
<body>



<div class="container">

	<header>
	<ul class="nav nav-tabs">
     	 <div style="margin-bottom:10px">
      		<a class="navbar-brand navbar-left" href="#">
                <img alt="brand" src="include/img/dgsw_logo.png" style="margin-bottom:30px">
            </a>
         </div>
           <li><a href="./home.jsp">홈</a></li>
           <li><a href="./request.jsp">심야자습 신청</a></li>
           <li><a href="./list.jsp">신청목록</a></li>
           <li><a href="./list_private.jsp">개인별 신청이력</a></li>
           <li class="active"><a href="./board_list.jsp">자유 게시판</a></li>
           <li><a href="./members.jsp">회원관리</a></li>
      </ul>
    </header>
    
    <div class="jumbotron" style="margin-top:30px">
        <h2>자유 익명 게시판</h2>
        <p class="lead">누구나 자유롭게 익명으로 글을 남기고<br>웹페이지의 기능에 관해 건의할 수 있습니다<br></p>

        <p><a class="btn btn-md btn-success" href="/bulbam/write.jsp" role="button" style="float:right">글쓰기</a></p>
        
        
      </div>

	<table class="table table-striped">
	  <thead>
		   <tr>
		     <th>번 호 </th>
		     <th>제 목</th>
		     <th>글쓴이</th>
		     <th>작성날짜</th>
		   </tr>
	   </thead>
	  <tbody>
	            <%
	            	for(int i=0; i<list.size(); i++)
	            	{
	            		BoardList nt = list.get(i);
	            		
	            %>
	            <tr>
	            	<td><%= nt.getId() %></td>
	            	<td><a href="board_view.jsp?id=<%= nt.getId() %>"><%= nt.getTitle() %></a></td>
	            	<td><%= nt.getWriterV() %></td>
	            	<td><%= nt.getDate() %></td>
	            </tr>
				<%
	            	}
				%>
				
	   </tbody>
	
	</table>
	
	<div>
	<%
	
	%>
		<span>[이전]</span>
	<%
	
	%>

<%
	for (int i = firstPage ; i <= lastPage ; i++)
	{
%>
		<span><%= i %></span>
<% 
	}
%>
		<span>[다음]</span>
	</div>
</div>

</body>
<!-- body 끝 -->

</html>