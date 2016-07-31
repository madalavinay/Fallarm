<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page isErrorPage="true"%>
<% session.removeAttribute("userId");
session.removeAttribute("pass");
session.removeAttribute("name");
session.removeAttribute("page");
session.removeAttribute("datapage");
session.removeAttribute("role");
session.removeAttribute("refresh");
%>
<!DOCTYPE html>
<html>
<head>
<title>Fallarm Login</title>
<link rel="stylesheet" href="css/style.css" />
</head>
<section class="loginform">
	<form name="login" action="login" method="post">
		<h3>Fallarm Login</h3>
		&nbsp;&nbsp;<label for="username">User ID :</label> <input type="text"
			name="username" placeholder="user id" required autofocus><br />
		<br /> <label for="pwd">Password :</label> <input type="password"
			name="pwd" placeholder="password" required><br />
		<% 
              String message="";
              if(session.getAttribute("errorMessage")!=null){
              message=(String)session.getAttribute("errorMessage");
              out.println("<label id='error' for='error'>"+ message +"</label> <br/>");
              session.removeAttribute("errorMessage");
               }
        %>
		<input type="submit" value="Login" />
	</form>
</section>

</html>