import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fallarm.database.PersonManager;
import com.fallarm.database.Person_information;

public class LoginServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String user = req.getParameter("username");
		String pass = req.getParameter("pwd");
try{
		PersonManager person = new PersonManager();
		Person_information info=person.findPerson(user, pass);
		if (info!=null) {
			HttpSession session = req.getSession();
			session.setAttribute("userId", user);
			session.setAttribute("pass", pass);
			session.setAttribute("name", info.getFname());
			if(info.getNurse_id()==null || info.getNurse_id().length()==0){
			session.setAttribute("role", "nurse");
			}
			else{
				session.setAttribute("role", "patient");
			}
			resp.sendRedirect(req.getContextPath() +"/index.jsp");

		} else {
			HttpSession session = req.getSession(true);
			session.setAttribute("errorMessage", "Invalid User Credentials");
			resp.sendRedirect(req.getContextPath() +"/login.jsp");
		}
	}catch(Exception e){
		System.out.println("Exception in LoginServlet:"+e.getMessage()+": User="+user +"Password="+pass);
	}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}