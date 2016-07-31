<%@page import="com.fallarm.database.Person_information"%>
<%@page import="com.fallarm.database.PersonManager"%>
<%
 if(session.getAttribute("userId")==null || session.getAttribute("pass")==null)
 {
	 response.sendRedirect("login.jsp");
 }
 else if(request.getParameter("registerTab")!=null){
	 session.removeAttribute("page");
	 response.sendRedirect("register.jsp");
 }
 else if(request.getParameter("refreshTab")!=null){
	 session.removeAttribute("page");
	 response.sendRedirect("register.jsp");
 }
 else if(request.getParameter("page")!=null){
	 if(request.getParameter("page").equals("next")){
	 	session.setAttribute("page", (Integer)session.getAttribute("page")+1);
	 }
	 else{
		 session.setAttribute("page", (Integer)session.getAttribute("page")-1);
	 }
		response.sendRedirect("register.jsp");
 }
 else if(request.getParameter("command")!=null){
	 session.removeAttribute("page");
	 PersonManager manager=new PersonManager();
		manager.deletePerson(request.getParameter("uid"));
		
		response.sendRedirect("register.jsp");
 }
 else{
	 session.removeAttribute("page");
	 String operation="save";
	 if(request.getParameter("save")==null){
		 operation="update";
	 }
	 Person_information person=new Person_information();
	 person.setPid(request.getParameter("userid"));;
	 person.setFname(request.getParameter("first"));
	 person.setLname(request.getParameter("last"));
	 person.setEmail(request.getParameter("mail"));
	 person.setPhone(request.getParameter("phone"));
	 person.setPwd(request.getParameter("pass"));
	 person.setGender(request.getParameter("gender").toCharArray()[0]);
	 person.setNurse_id(request.getParameter("nurse"));
	 
	PersonManager manager=new PersonManager();
	
	manager.insertPersonDetails(person,operation);
	
	response.sendRedirect("register.jsp");
 }
%>
