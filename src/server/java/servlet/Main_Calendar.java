package server.java.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.controller.Controller;
import com.java.user.UserAdmin;
import com.java.user.UserLocation;
import com.java.util.MyDate;

/**
 * Servlet implementation class Main_Calendar
 */
@WebServlet("/Main_Calendar")
public class Main_Calendar extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Main_Calendar() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		String work_date = request.getParameter("work_date");
		String user_id = (String)request.getSession().getAttribute("user_id");
		String location_number = request.getParameter("location_number");
		
		UserAdmin userAdmin = new UserAdmin();
		
		if(user_id == null) {
			response.sendRedirect("/Login");
		}
		else {
			if(work_date == null) {
				String now = MyDate.getNow();
				try {
					Controller controller = new Controller();
					controller.getLocation(location_number);
					
				}catch(Exception e) {
					e.printStackTrace();
				}
			}else {
				
			}
		}
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
