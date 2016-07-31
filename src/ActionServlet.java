import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fallarm.database.DeviceManager;
import com.fallarm.database.Device_data;
import com.fallarm.database.PersonManager;
import com.fallarm.database.Person_information;
import com.fallarm.database.PopupManager;
import com.fallarm.util.EmailService;

public class ActionServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		BufferedReader br = new BufferedReader(new InputStreamReader(req.getInputStream()));
		String data = "";
		if (br != null) {
			data = br.readLine();
		}
		try{
		if (data != null) {
			Device_data d = new Device_data();
			String[] info = data.split(" ");
			d.setDeviceid(info[1]);
			d.setG1(Double.parseDouble(info[11]));
			d.setG2(Double.parseDouble(info[13]));
			d.setG3(Double.parseDouble(info[15]));
			d.setA1(Double.parseDouble(info[4]));
			d.setA2(Double.parseDouble(info[6]));
			d.setA3(Double.parseDouble(info[8]));
			d.setX(Double.parseDouble(info[18]));
			d.setY(Double.parseDouble(info[20]));
			d.setSeverity(Integer.parseInt(info[22]));
			d.setTime(new Date());
			PersonManager pm = new PersonManager();
			Person_information pi = pm.listPersonDetailsByDeviceId(d.getDeviceid());
			if (pi != null && pi.getDeviceid() != null) {
				d.setPid(pi.getPid());
				DeviceManager manager = new DeviceManager();
				manager.insertDeviceData(d);
				if (d.getSeverity() <= 2) {
					new PopupManager().insertPopup(pi.getPid());
					EmailService em = new EmailService();
					em.sendEmergencyEmail(d,pi);
				}
			}
		}
		}catch(Exception e){
			System.out.println("Exception in ActionServlet:"+e.getMessage()+": Data="+data);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}