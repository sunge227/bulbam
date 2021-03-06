<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="kr.hs.dgsw.web.domain.NightStudyRequest"%>
<%@page import="java.util.List"%>
<%@page import="kr.hs.dgsw.web.service.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String sTime = request.getParameter("time");
	SimpleDateFormat date_format = new SimpleDateFormat("yyyy-MM-dd");


	Date time = null;
	if (sTime == null)
	{
		time = new Date();
	}
	else
	{
		try
		{
			time = date_format.parse(sTime);
		}
		catch (ParseException e)
		{
			time = new Date();
		}
		
	}

	UserService service = UserService.getInstance();
	List<NightStudyRequest> list = service.listNightStudy(time);

%>
<!DOCTYPE html>
<html lang="kr">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>request</title>
  <link href="include/css/bootstrap.min.css" rel="stylesheet">
  <style type="text/css">
    .margin_top{
      margin-top: 50px;
    }
  </style>
  
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
  <script type="text/javascript">
  	
  	$(document).ready(function() {
  		$("#txt_date").val("<%= date_format.format(time) %>");
  		//$("#txt_date").datepicker();
  	});
  
  	function setDate()
  	{
  		var time = $("#txt_date").val();
  		location.href="list.jsp?time=" + time;
  	}
  </script>
</head>
<body>
    <!-- <header>
    <ul class="nav nav-tabs">
     	 <div style="margin-bottom:10px">
      		<a class="navbar-brand navbar-left" href="#">
                <img alt="brand" src="include/img/dgsw_logo.png" style="margin-bottom:30px">
            </a>
         </div>
           <li><a href="./home.jsp">홈</a></li>
           <li><a href="./request.jsp">심야자습 신청</a></li>
           <li class="active"><a href="./list.jsp">신청목록</a></li>
           <li><a href="./list_private.jsp">개인별 신청이력</a></li>
           <li><a href="./board_list.jsp">자유 게시판</a></li>
           <li><a href="./members.jsp">회원관리</a></li>
      </ul>
    </header> -->
    
    <div class="container">
    
    <jsp:include page="navbar_Include.jsp"></jsp:include>
    
    <p class="margin_top" style="margin-bottom:50px; text-align: center;">
	<img src="include/img/NQlist.png" class="img-rounded" style="position:relative; width:1000px; height:400px">
	</p>
    
    <div class="alert alert-info" style="text-align: right" role="alert"> <span>날짜 : <!-- </span><span><%= date_format.format(time) %> --><input type="text" id="txt_date" size="12"><input type="button" value="보기" onclick="setDate();"></span> </div>
	
	<p>
<%
if (list.size() == 0)
{
	
%>
	<span>신청한 학생이 없습니다.</span>
<%
}
else
{
%>
    <table cellspacing="0" cellpadding="0" class="table table-hover text-center">
        <thead>
        <tr class="success">
            <th scope="col" class="text-center">이름</th>
            <th scope="col" class="text-center">학년::반::번호</th>
            <th scope="col" class="text-center">날짜</th>
        </tr>
        </thead>
        <tbody>
<%
	for (NightStudyRequest item : list)
	{
%>            
            <tr>
                <td><%= item.getUserName() %></td>
                <td><%= item.getGrade() %>학년 <%= item.getClazz() %>반 <%= item.getNumber() %>번</td>
                <td><%= item.getTime() %></td>
            </tr>
<%
	}
%>

        </tbody>
    </table>



<%
}
%>

     <footer class="text-center margin_top">
        <div class="panel panel-default">
          <div class="panel-body text-center">
              All Copyright Reserved 2016- DGSW Web Server<br>
              DGSW 2016-2016 DGSW WEB SERVER PROJECT TEAM
          </div>
        </div>

     </footer>
  </div>
</body>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="include/js/bootstrap.min.js"></script>
<script>
    $('.carousel').carousel()
</script>

</html>