<%@page errorPage="login.jsp"%>
<%@page import="com.fallarm.database.Device_data"%>
<%@page import="com.fallarm.database.DeviceManager"%>
<%
 if(session.getAttribute("userId")==null || session.getAttribute("pass")==null)
 {
	 response.sendRedirect("login.jsp");
 }
 else{
	 if(session.getAttribute("refresh")!=null || session.getAttribute("datapage")==null || (Integer)session.getAttribute("datapage")<=0)
	 {
		 session.setAttribute("datapage", 1);
	 }
%>

<!DOCTYPE html>
<html>
<head>
<title>Monitoring Data</title>
<link href="css/home.css" rel="stylesheet" />
<link href="css/monitor.css" rel="stylesheet" />
<script src="javascript/jquery-1.9.1.js"></script>
<script src="javascript/jquery-ui.js"></script>
<script src="javascript/monitor.js"></script>

</head>
<header>
	<img id="logo" alt="Fallarm Logo" src="images/fallarm_logo.jpg" /> <label
		id="user">Hello, <%= session.getAttribute("name") %></label><br /> <br />
	<input id="popUser" type="hidden" value="<%= (String)session.getAttribute("userId") %>" /><a id="signout" href="login.jsp">Sign out</a> <br />

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
		<input type="hidden" name="monitorTab" value="monitor" /> <input id="selectedMenuItem"
			class="menu" type="submit" name="monitor" value="Monitor" />
	</form>
	<form action="searching.jsp" method="post">
		<input type="hidden" name="searchTab" value="search" /> <input
			class="menu" type="submit" name="search" value="Search" />
	</form>
</nav>
<section>

	<TABLE BORDER="1">

		<%
 int pagesize=10;
 int start=((Integer)session.getAttribute("datapage")-1)* pagesize;
 
 String user=(String)session.getAttribute("userId");
 Device_data data[]=new DeviceManager().listDetails(user,start,pagesize);
	 %>
		<caption>
		<% if(session.getAttribute("refresh")!=null){ %>
		<label id="autoRefresh"><input type="checkbox" id="refreshCheck" onclick="doRefresh()" checked="checked">Auto Refresh</label>
		<%}else{ %>
		<label id="autoRefresh"><input type="checkbox" id="refreshCheck" onclick="doRefresh()">Auto Refresh</label>
		<% } %>
		<code id="pag">
			<label id="start"> <%=data.length==0?"0":(start +1) %>
			</label> - <label id="end"><%= start + data.length %></label> of <label
				id="count"><%= new DeviceManager().countData(user) %></label>
			<button id="prevPage" onclick="prev()">&lt;</button>
			<button id="nextPage" onclick="next()">&gt;</button>
			</code>
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
                <TD id="id<%= i %>"> <%= data[i].getPid() %></TD>
                <TD> <%= data[i].getA1() %></TD>
                <TD> <%= data[i].getA2() %></TD>
                <TD> <%= data[i].getA3() %></TD>
                <TD> <%= data[i].getG1() %></TD>
                <TD> <%= data[i].getG2() %></TD>
                <TD> <%= data[i].getG3() %></TD>
                <TD><input type="button" value="open location" onclick="window.open('http://maps.google.com/maps?q=<%= data[i].getX() %>,<%= data[i].getY() %>')" /></TD>
                <TD> <%= data[i].getSeverity() %></TD>
                <TD id="ti<%= i %>"> <%= data[i].getTime() %></TD>
                <% if(session.getAttribute("role")!=null && ((String)(session.getAttribute("role"))).equals("nurse")){ %>
                <TD><input id="<%= "c"+data[i].getPid()+","+data[i].getTime() %>" type="text" size="15" value="<%= data[i].getComments()==null?"":data[i].getComments() %>" ondblclick="this.readOnly='';" readonly/>
                <button class="comments" id="<%= data[i].getPid()+","+data[i].getTime() %>">save</button></TD>
                <% }else{ %>
                <TD> <%= data[i].getComments()==null?"":data[i].getComments() %></TD>
                <% } %>
            </TR>
		<% } %>
	</TABLE>
</section>
<form method="post" action="monitoring.jsp" id="pagination">
	<input id="prepost" type="hidden" name="datapage" value="next" />
</form>

<form method="post" action="monitoring.jsp" id="refreshForm">
	<input id="refresh" type="hidden" name="refresh" value="D" />
</form>

</html>
<% } %>