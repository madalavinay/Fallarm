import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fallarm.database.PopupManager;

public class PopupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String user = request.getParameter("user");
		try {
			String data = new PopupManager().getPopup(user);
			response.getWriter().println("<p id='pop'>" + data + "</p>");
		} catch (Exception e) {
			System.out.println("Exception in PopupServlet:" + e.getMessage() + ": user=" + user);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
