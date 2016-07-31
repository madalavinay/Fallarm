<%@page errorPage="login.jsp"%>
<%
	if (session.getAttribute("userId") == null || session.getAttribute("pass") == null) {
		response.sendRedirect("login.jsp");
	} else {
%>

<!DOCTYPE html>
<html>
<head>
<title>Fallarm Application</title>
<link href="css/home.css" rel="stylesheet" />
<link href="css/index.css" rel="stylesheet" />
<script src="javascript/jquery-1.9.1.js"></script>
<script src="javascript/jquery-ui.js"></script>
<script src="javascript/changePwd.js"></script>
</head>
<header>
	<img id="logo" alt="Fallarm Logo" src="images/fallarm_logo.jpg" /> <label
		id="user">Hello, <%=session.getAttribute("name")%></label><br /> <br />
	<input id="popUser" type="hidden"
		value="<%=(String) session.getAttribute("userId")%>" /><a
		id="signout" href="login.jsp">Sign out</a> <br /> <a id="changepwd"
		href="javascript:div_show();">Change Password </a>

</header>
<body id="body" style="overflow: hidden;">
	<div id="abc">
		<div id="popup">
			<form action="changePwd.jsp" id="changePwdForm" method="post"
				onsubmit="return check_empty()">
				<table>
					<tr>
						<td class="chgLabels"><label>Enter New Password </label></td>
						<td>:</td>
						<td><input id="newPwd" name="newPwd"
							placeholder="Enter new password" type="password" required /></td>
					</tr>
					<tr>
						<td class="chgLabels"><label>Retype Password </label></td>
						<td>:</td>
						<td><input id="newPwd1" name="newPwd1"
							placeholder="Retype new password" type="password" required /></td>
					</tr>
					<tr>
						<td class="changeButton"><input type="submit" value="Change" /></td>
						<td></td>
						<td class="cancelButton"><input type="button" value="Cancel"
							onclick="div_hide()" /></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
<nav>
	<form action="index.jsp" method="post">
		<input id="selectedMenuItem" class="menu" type="submit" name="about" value="About" />
	</form>
	<form action="registration.jsp" method="post">
		<input type="hidden" name="refreshTab" value="register" /> <input
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

<section>
	<h2>Fallarm project features</h2>
	<ul>
		<li>Fallarm software enables communication with the device.</li>
		<li>It has the purpose of monitoring the output of the devices.</li>
		<li>It will record the acceleration and orientation patterns of
			the device.</li>
		<li>It will include a database that contains the user profiles of
			patients.</li>
		<li>The software automatically sends the estimated risk class to
			the device.</li>
		<li>The software includes a component for the analysis of data.</li>
		<li>When detection of a fall or an event, the software must show
			a pop-up.</li>
		<li>This software is sensitive to events, such as values
			exceeding a threshold, or when the user presses a button.</li>
	</ul>
	<br />

	<p>
		<font color='blue'> Contact Us</font><br /> 47671 Westinghouse Drive,<br />
		Fremont, CA 94539, USA.<br /> <font color='blue'> mail:
			npufallarm@gmail.com</font>
	</p>
</section>

</html>
<% } %>