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
import com.java.wedding.Wedding;

@WebServlet("/Main2Wedding")
public class Main2Wedding extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Main2Wedding() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String location_number = request.getParameter("location_number");
		String work_date = request.getParameter("work_date");
		String user_id = (String)request.getSession().getAttribute("user_id");
		UserAdmin userAdmin = new UserAdmin();
		
		if(user_id==null) {
			response.sendRedirect("/Login");
		}else {
			Controller controller = new Controller();
			ArrayList<UserLocation> userLocations = controller.getUserLocations(user_id);
			
			request.setAttribute("userLocations",userLocations);
			request.setAttribute("user", controller.getUser(user_id));
			
			ArrayList<Wedding> weddings = controller.getWeddingsWithLocationNumberDate(location_number, work_date);
			request.setAttribute("weddings", weddings);
			
			System.out.println(weddings.toString());
			 
			
			Location location = controller.getLocation(location_number);
			
			boolean isUser = userAdmin.isAdminUserId(user_id);
			
			request.setAttribute("isAdmin", isUser);
			request.setAttribute("location", location);
			
			
		}

		RequestDispatcher rd = request.getRequestDispatcher("/view2/main2Wedding");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
