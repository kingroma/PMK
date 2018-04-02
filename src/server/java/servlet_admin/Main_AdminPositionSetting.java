package server.java.servlet_admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.controller.Controller;
import com.java.location.LocationPosition;

@WebServlet("/Main_AdminPositionSetting")
public class Main_AdminPositionSetting extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Main_AdminPositionSetting() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String user_id = request.getParameter("user_id");
		String location_number = request.getParameter("location_number");
		String hall_number = request.getParameter("hall_number");
		String work_date = request.getParameter("work_date");
		String position = request.getParameter("position");
		String method = request.getParameter("method");
		
		if(user_id!=null && work_date!=null && location_number != null && hall_number != null && position != null && method !=null) {
			LocationPosition locationPosition = new LocationPosition();
			Controller controller = new Controller();
			if(method.equals("add")) {
				locationPosition.setHall_number(Integer.parseInt(hall_number));
				locationPosition.setLocation_number(Integer.parseInt(location_number));
				locationPosition.setTitle(position);
				locationPosition.setUser_id(user_id);
				locationPosition.setWork_date(work_date);
				controller.addLocationPosition(locationPosition);
			}
			else if(method.equals("delete")) {
				System.out.println(
						user_id + "/" + location_number + "/" + hall_number + "/" + work_date + "/" + position + "/" + method );
				locationPosition.setHall_number(Integer.parseInt(hall_number));
				locationPosition.setLocation_number(Integer.parseInt(location_number));
				locationPosition.setTitle(position);
				locationPosition.setUser_id(user_id);
				locationPosition.setWork_date(work_date);
				controller.deleteLocationPosition(locationPosition);
			}
		}else {
			
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
