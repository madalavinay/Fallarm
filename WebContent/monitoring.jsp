<%@page errorPage="login.jsp"%>
<%@page import="com.fallarm.database.Device_data"%>
<%@page import="com.fallarm.database.DeviceManager"%>
<%@page import="java.util.Date"%>
<%
 if(session.getAttribute("userId")==null || session.getAttribute("pass")==null)
 {
	 response.sendRedirect("login.jsp");
 }
 else if(request.getParameter("monitorTab")!=null){
	 session.removeAttribute("datapage");
	 session.removeAttribute("refresh");
	 response.sendRedirect("monitor.jsp");
 }
 else if(request.getParameter("refresh")!=null){
	 if(request.getParameter("refresh").equals("R")){
	 	session.setAttribute("refresh", "R");
	 }
		response.sendRedirect("monitor.jsp");
 }
 else if(request.getParameter("datapage")!=null){
	 session.removeAttribute("refresh");
	 if(request.getParameter("datapage").equals("next")){
	 	session.setAttribute("datapage", (Integer)session.getAttribute("datapage")+1);
	 }
	 else{
		 session.setAttribute("datapage", (Integer)session.getAttribute("datapage")-1);
	 }
		response.sendRedirect("monitor.jsp");
 }
 else{
	 session.removeAttribute("datapage");
	 session.removeAttribute("refresh");
	response.sendRedirect("monitor.jsp");
 }
%>
