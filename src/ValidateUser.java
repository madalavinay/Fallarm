import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fallarm.database.PersonManager;
import com.fallarm.database.Person_information;
import com.fallarm.util.EmailService;

public class ValidateUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BufferedReader br = new BufferedReader(new InputStreamReader(req.getInputStream()));
		String data = "";
		if (br != null) {
			data = br.readLine();
		}
		try {
			if (data != null) {
				String[] info = data.split(" ");
				Person_information pi = new PersonManager().findPerson(info[1], info[3]);
				if (pi != null && pi.getDeviceid() == null) {
					pi.setDeviceid(info[5]);
					new PersonManager().insertPersonDetails(pi,"update");

					EmailService em = new EmailService();
					em.sendUserVerification(pi.getFname() + "" + pi.getLname(), pi.getEmail());
				}
			}
		} catch (Exception e) {
			System.out.println("Exception in ValidateUser:" + e.getMessage() + ": Data=" + data);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}