package server.java.servlet2;

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
import com.java.user.UserAdmin;
import com.java.user.UserLocation;

@WebServlet("/Main2")
public class Main2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public Main2() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String user_id = (String)request.getSession().getAttribute("user_id");
		//String currentYearMonth = request.getParameter("currentYearMonth");//2018_1_1
		String location_number = request.getParameter("location_number");
		UserAdmin userAdmin = new UserAdmin();
		if(user_id==null) {
			response.sendRedirect("/Login");
		}else {
			Controller controller = new Controller();
			ArrayList<UserLocation> userLocations = controller.getUserLocations(user_id);
			
			request.setAttribute("userLocations",userLocations);
			request.setAttribute("user", controller.getUser(user_id));
			
			Location location = null;
			if(location_number==null) {
				if(userLocations != null && userLocations.size() > 0) {
					location = controller.getLocation(userLocations.get(0).getLocation_number());
				}
			}else {
				location = controller.getLocation(location_number);
			}
			
			boolean isUser = userAdmin.isAdminUserId(user_id);
			
			
			request.setAttribute("isAdmin", isUser);
			request.setAttribute("location", location);
			
			RequestDispatcher rd = request.getRequestDispatcher("/view2/main2.jsp");
			rd.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
