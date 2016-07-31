<%@page errorPage="login.jsp" %>
<%@page import="com.fallarm.database.Device_data"%>
<%@page import="com.fallarm.database.DeviceManager"%>
<%
 if(session.getAttribute("userId")==null || session.getAttribute("pass")==null)
 {
	 response.sendRedirect("login.jsp");
 }
 else if(request.getParameter("searchTab")!=null){
	 response.sendRedirect("search.jsp");
 }
 else if(request.getParameter("addComments")!=null){
	 String data[]=(request.getParameter("addComments")).split(",");
	 String comments=request.getParameter("comments");
	 new DeviceManager().addComments(data[0], data[1], comments);
 }
 else{
	response.sendRedirect("search.jsp");
 }
%>