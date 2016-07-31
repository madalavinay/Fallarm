<%@page errorPage="login.jsp" %>
<%@page import="com.fallarm.database.PersonManager"%>
<%
 if(session.getAttribute("userId")==null || session.getAttribute("pass")==null)
 {
	 response.sendRedirect("login.jsp");
 }
 else{
	String newPwd=request.getParameter("newPwd"); 	
	PersonManager manager=new PersonManager();
	manager.changePassword((String)session.getAttribute("userId"), (String)session.getAttribute("pass"), newPwd);
	
	session.invalidate();
	response.sendRedirect("login.jsp");
 }
%>
