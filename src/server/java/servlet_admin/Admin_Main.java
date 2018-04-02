package server.java.servlet_admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.controller.Controller;
import com.java.location.Location;
import com.java.user.UserLocation;
import com.java.wedding.Wedding;

@WebServlet("/Admin_Main")
public class Admin_Main extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Admin_Main() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		
		String location_number = request.getParameter("location_number");
		String user_id = (String)request.getSession().getAttribute("user_id_admin");

		try {
			if(location_number==null) {
				//location number == null 
				Controller controller = new Controller();
				ArrayList<UserLocation> userLocations = controller.getUserMembers(user_id);
				ArrayList<Location> locations = new ArrayList<Location>();
				
				for(UserLocation userLocation : userLocations) {
					locations.add(controller.getLocationAdmin(userLocation.getLocation_number()));
				}
				request.setAttribute("locations", locations);
			}else {
				// location number exist
				
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("/view_admin/main.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
	}

}
