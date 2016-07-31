<%@page errorPage="login.jsp"%>
<%@page import="com.fallarm.database.Device_data"%>
<%@page import="com.fallarm.database.DeviceManager"%>
<%@page import="com.fallarm.database.PersonManager"%>
<%
 if(session.getAttribute("userId")==null || session.getAttribute("pass")==null)
 {
	 response.sendRedirect("login.jsp");
 }
 else{
%>
<!DOCTYPE html>
<html>
<head>
<title>Search Data</title>
<link href="css/home.css" rel="stylesheet" />
<link href="css/search.css" rel="stylesheet" />
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="javascript/jquery-1.9.1.js"></script>
<script src="javascript/jquery-ui.js"></script>
<script src="javascript/search.js"></script>

</head>
<header>
	<img id="logo" alt="Fallarm Logo" src="images/fallarm_logo.jpg" /> <label
		id="user">Hello, <%= session.getAttribute("name") %></label><br /> <br />
	<input id="popUser" type="hidden"
		value="<%= (String)session.getAttribute("userId") %>" /><a
		id="signout" href="login.jsp">Sign out</a> <br />

</header>
<nav>
	<form action="index.jsp" method="post">
		<input class="menu" type="submit" name="about" value="About" />
	</form>
	<form action="registration.jsp" method="post">
		<input type="hidden" name="registerTab" value="register" /> <input
			class="menu" type="submit" name="register" value="Registration" />
	</form>
	<form action="monitoring.jsp" method="post">
		<input type="hidden" name="monitorTab" value="monitor" /> <input
			class="menu" type="submit" name="monitor" value="Monitor" />
	</form>
	<form action="searching.jsp" method="post">
		<input type="hidden" name="searchTab" value="search" /> <input
			id="selectedMenuItem" class="menu" type="submit" name="search"
			value="Search" />
	</form>
</nav>
<table id="searchOptions">
	<tr>
		<td>
			<form id="searchbox" action="search.jsp" method="post"
				onsubmit="return isValidDate()">
				Patient ID : <select id="searchid" name="searchid"
					onchange="disable()" required>
					<%  PersonManager pm=new PersonManager();
  String s[]=pm.listUsersByMonitor((String)session.getAttribute("userId"));
  for(int i=0;i<s.length;i++){
	  if(request.getParameter("searchid")!=null && ((String)request.getParameter("searchid")).equals(s[i])){ %>
					<option value="<%= s[i] %>" selected><%= s[i] %></option>
					<% } else{  %>
					<option value="<%= s[i] %>"><%= s[i] %></option>
					<% }  }%>
				</select> Start Date :
				<% if(request.getParameter("sdate")==null){ %>
				<input type="text" id="startdatepicker" name="sdate" required />
				<% } else{ %>
				<input type="text" id="startdatepicker" name="sdate"
					value="<%= request.getParameter("sdate") %>" required />
				<% } %>
				End Date :
				<% if(request.getParameter("edate")==null){ %>
				<input type="text" id="enddatepicker" name="edate" required />
				<% } else{ %>
				<input type="text" id="enddatepicker" name="edate"
					value="<%= request.getParameter("edate") %>" required />
				<% } %>
				<% if(request.getParameter("page")==null){ %>
				<input type="hidden" id="startPage" name="page" value="0" />
				<% } else{ %>
				<input type="hidden" id="startPage" name="page"
					value="<%= request.getParameter("page") %>" />
				<% } %>
				<input type="submit" value="Search" />
			</form>
		</td>
	</tr>
</table>
<section>
	<% if(request.getParameter("searchid")!=null && request.getParameter("sdate")!=null && request.getParameter("edate")!=null){ 
	String searchString = request.getParameter("searchid");
	String startDate = request.getParameter("sdate");
	String endDate = request.getParameter("edate");
	int pagesize=10;
	int start=0;
	if(request.getParameter("page")!=null){
		start=Integer.parseInt(request.getParameter("page"));
	}

	Device_data data[] = new DeviceManager().listDetailsSearch(searchString, start, pagesize, startDate, endDate);
%>
	<TABLE BORDER="1">
		<caption>
			<label id="start"><%= data.length==0?"0":(start+1) %></label> - <label
				id="end"><%= start+ data.length %></label> of <label id="count"><%= new DeviceManager().listDetailsCountSearch(searchString, startDate, endDate) %></label>
			<button id="prevPage" onclick="prev()">&lt;</button>
			<button id="nextPage" onclick="next()">&gt;</button>
		</caption>
		<TR>
			<TH>Patient ID</TH>
			<TH>Ax</TH>
			<TH>Ay</TH>
			<TH>Az</TH>
			<TH>Gx</TH>
			<TH>Gy</TH>
			<TH>Gz</TH>
			<TH>Location</TH>
			<TH>Severity</TH>
			<TH>Time</TH>
			<TH>Comments</TH>
		</TR>
		<% for(int i=0;i<data.length;i++){ %>
		<TR>
			<TD id="id<%= i %>"><%= data[i].getPid() %></TD>
			<TD><%= data[i].getA1() %></TD>
			<TD><%= data[i].getA2() %></TD>
			<TD><%= data[i].getA3() %></TD>
			<TD><%= data[i].getG1() %></TD>
			<TD><%= data[i].getG2() %></TD>
			<TD><%= data[i].getG3() %></TD>
			<TD><input type="button" value="open location"
				onclick="window.open('http://maps.google.com/maps?q=<%= data[i].getX() %>,<%= data[i].getY() %>')" /></TD>
			<TD><%= data[i].getSeverity() %></TD>
			<TD id="ti<%= i %>"><%= data[i].getTime() %></TD>
			<% if(session.getAttribute("role")!=null && ((String)(session.getAttribute("role"))).equals("nurse")){ %>
			<TD><input
				id="<%= "c"+data[i].getPid()+","+data[i].getTime() %>" type="text"
				size="15"
				value="<%= data[i].getComments()==null?"":data[i].getComments() %>"
				ondblclick="this.readOnly='';" readonly />
				<button class="comments"
					id="<%= data[i].getPid()+","+data[i].getTime() %>">save</button></TD>
			<% }else{ %>
			<TD><%= data[i].getComments()==null?"":data[i].getComments() %></TD>
			<% } %>
		</TR>
		<% } %>
	</TABLE>
	<%} %>
</section>
</html>
<% } %>