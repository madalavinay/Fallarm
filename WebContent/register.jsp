<%@page errorPage="login.jsp"%>
<%@page import="com.fallarm.database.Person_information"%>
<%@page import="com.fallarm.database.PersonManager"%>
<%
	if (session.getAttribute("userId") == null || session.getAttribute("pass") == null) {
		response.sendRedirect("login.jsp");
	} else {
		if (session.getAttribute("page") == null || (Integer) session.getAttribute("page") <= 0) {
			session.setAttribute("page", 1);
		}
%>

<!DOCTYPE html>
<html>
<head>
<title>Fallarm Registration</title>
<link href="css/home.css" rel="stylesheet" />
<link href="css/register.css" rel="stylesheet" />
<script src="javascript/jquery-1.9.1.js"></script>
<script src="javascript/jquery-ui.js"></script>
<script src="javascript/register.js"></script>

</head>
<header>
	<img id="logo" alt="Fallarm Logo" src="images/fallarm_logo.jpg" /> <label
		id="user">Hello, <%=session.getAttribute("name")%></label><br /> <br />
	<input id="popUser" type="hidden"
		value="<%=(String) session.getAttribute("userId")%>" /><a
		id="signout" href="login.jsp">Sign out</a> <br />

</header>
<nav>
	<form action="index.jsp" method="post">
		<input class="menu" type="submit" name="about" value="About" />
	</form>
	<form action="registration.jsp" method="post">
		<input type="hidden" name="registerTab" value="register" /> <input id="selectedMenuItem"
			class="menu" type="submit" name="register" value="Registration" />
	</form>
	<form action="monitoring.jsp" method="post">
		<input type="hidden" name="monitorTab" value="monitor" /> <input
			class="menu" type="submit" name="monitor" value="Monitor" />
	</form>
	<form action="searching.jsp" method="post">
		<input type="hidden" name="searchTab" value="search" /> <input
			class="menu" type="submit" name="search" value="Search" />
	</form>
</nav>
<body id="body" style="overflow: hidden;">
	<div id="abc">
		<div id="registration">
			<form action="registration.jsp" id="newuser" method="post"
				onsubmit="return validate()">
				<table>
					<tr>
						<td class="usrLabels"><label>Enter User ID </label></td>
						<td>:</td>
						<td><input id="userid" name="userid"
							placeholder="Enter User ID" type="number" required /></td>
					</tr>
					<tr>
						<td class="usrLabels"><label> First Name </label></td>
						<td>:</td>
						<td><input id="first" name="first" placeholder="First Name"
							type="text" required /></td>
					</tr>
					<tr>
						<td class="usrLabels"><label> Last Name </label></td>
						<td>:</td>
						<td><input id="last" name="last" placeholder="Last Name"
							type="text" /></td>
					</tr>
					<tr>
						<td class="usrLabels"><label> Email </label></td>
						<td>:</td>
						<td><input id="mail" name="mail" placeholder="email address"
							type="email" required /></td>
					</tr>
					<tr>
						<td class="usrLabels"><label> Phone Number </label></td>
						<td>:</td>
						<td><input id="phone" name="phone" placeholder="phone number"
							type="number" required /></td>
					</tr>
					<tr>
						<td class="usrLabels"><label> Password </label></td>
						<td>:</td>
						<td><input id="pass" name="pass" placeholder="password"
							type="password" required /></td>
					</tr>
					<tr>
						<td class="usrLabels"><label> Gender </label></td>
						<td>:</td>
						<td><input id="male" name="gender" type="radio" value="M"
							checked>Male <input id="female" name="gender"
							type="radio" value="F">Female</td>
					</tr>
					<tr>
						<td class="usrLabels"><label> Monitor By </label></td>
						<td>:</td>
						<td><select id="nurse" name="nurse">
								<option value="">--select--</option>
								<%
									PersonManager pm = new PersonManager();
										String s[] = pm.listMonitors();
										for (int i = 0; i < s.length; i++) {
								%>
								<option value="<%=s[i]%>"><%=s[i]%></option>
								<%
									}
								%>

						</select>
					</tr>
					<tr>
						<td class="saveButton"><input id="savePerson" type="submit" name="save" value="Save" />
						<input id="updatePerson" type="submit" name="update" value="Update" /></td>
						<td></td>
						<td class="cancelButton"><input id="cancelPerson" type="button" value="Cancel"
							onclick="div_hide()" /></td>
					</tr>
				</table>
			</form>
			<form method="post" action="registration.jsp" id="deleteUser">
				<input type="hidden" name="command" value="delete" /> <input
					type="hidden" id="deleteId" name="uid" value="1" />
			</form>

			<form method="post" action="registration.jsp" id="pagination">
				<input id="prepost" type="hidden" name="page" value="next" />
			</form>

		</div>
	</div>
</body>

<aside>
	<%
		if (((String) session.getAttribute("role")).equals("nurse")) {
	%>
	<button id="newIcon" onclick="div_show()">
		<img src="images/add_user.png" alt="New" /><br />New
	</button>
	<br />
	<button id="editIcon" onclick="div_edit()">
		<img src="images/edit_user.png" alt="Edit" /><br />Edit
	</button>
	<br />

	<button id="deleteIcon" onclick="div_delete()">
		<img src="images/delete_user.png" alt="Delete" /><br />Delete
	</button>
	<br />
	<form id="refreshForm" action="registration.jsp" method="post">
		<input type="hidden" name="refreshTab" value="register" /> <input
			type="hidden" id="role"
			value="<%=(String) session.getAttribute("role")%>" />
		<button id="refreshIcon" onclick="div_refresh()">
			<img src="images/refresh.png" alt="Refresh" /><br />Refresh
		</button>
	</form>
	<%
		} else {
	%>
	<input type="hidden" id="role"
		value="<%=(String) session.getAttribute("role")%>" />
	<button id="editIcon" onclick="div_edit()">
		<img src="images/edit_user.png" alt="Edit" /><br />Edit
	</button>
	<br />
	<%
		}
	%>
</aside>

<section>
	<TABLE BORDER="1">
		<%
			int pagesize = 5;
				int start = ((Integer) session.getAttribute("page") - 1) * pagesize;

				String userId = (String) session.getAttribute("userId");
				Person_information persons[] = pm.listPersonDetails(userId, start, pagesize);
		%>
		<caption>
			<label id="start"> <%=persons.length == 0 ? "0" : (start + 1)%>
			</label> - <label id="end"><%=start + persons.length%></label> of <label
				id="count"><%=pm.countPersons(userId)%></label>
			<button id="prevPage" onclick="prev()">&lt;</button>
			<button id="nextPage" onclick="next()">&gt;</button>
		</caption>
		<TR>
			<TH></TH>
			<TH>Patient ID</TH>
			<TH>First Name</TH>
			<TH>Last Name</TH>
			<TH>Email</TH>
			<TH>Phone</TH>
			<TH>Gender</TH>
			<TH>Monitor By</TH>
		</TR>
		<%
			for (int i = 0; i < persons.length; i++) {
		%>
		<TR>
			<TD><input id="regData" name="regData" type="radio"
				value="<%=persons[i].getPid()%>"></TD>
			<TD id="id<%=i%>"><%=persons[i].getPid()%></TD>
			<TD id="fn<%=i%>"><%=persons[i].getFname()%></TD>
			<TD id="ln<%=i%>"><%=persons[i].getLname()%></TD>
			<TD id="em<%=i%>"><%=persons[i].getEmail()%></TD>
			<TD id="ph<%=i%>"><%=persons[i].getPhone()%></TD>
			<TD id="g<%=i%>"><%= persons[i].getGender() %></TD>
			<TD id="nu<%= i %>"><%= persons[i].getNurse_id()==null?"":persons[i].getNurse_id() %></TD>
		</TR>
		<% } %>
	</TABLE>
</section>

</html>
<% } %>
