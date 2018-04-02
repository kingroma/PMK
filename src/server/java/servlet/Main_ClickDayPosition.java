package server.java.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.controller.Controller;
import com.java.location.Location;
import com.java.location.LocationPosition;
import com.java.user.UserAdmin;
import com.java.user.UserLocation;
import com.java.user.UserWorkDate;
import com.java.util.MyDate;

@WebServlet("/Main_ClickDayPosition")
public class Main_ClickDayPosition extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Main_ClickDayPosition() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String user_id = (String)request.getSession().getAttribute("user_id");
		String location_number = request.getParameter("location_number");
		String date = request.getParameter("date");
		String work_date = MyDate.removeSlashFromJavascript(date)+"0000";
		
		if(user_id==null) {
			PrintWriter write = response.getWriter();
			write.println("<script>parent.reloadFromChildrend()</script>");
		}else {
			Controller controller = new Controller();
			//controller.getUser(user_id);
			Location location = controller.getLocation(location_number);
			ArrayList<LocationPosition> locationPositions = controller.getLocationPositionsWithDate(location_number,work_date);
			request.setAttribute("locationPositions", locationPositions);
			request.setAttribute("location", location);
			request.setAttribute("work_date", work_date);
			
			ArrayList<UserWorkDate> userWorkDates = controller.getUserWorkDatesLocationNumberWorkDate(location_number, work_date);
			ArrayList<UserLocation> userLocations = controller.getUserLocationsLocationNumber(location_number);
			
			for(UserWorkDate userWorkDate : userWorkDates) {
				for(UserLocation userLocation : userLocations) {
					if(userWorkDate.getUser_id().equals(userLocation.getUser_id())){
						userLocations.remove(userLocation);
						break;
					}
				}
			}
			
			request.setAttribute("userWorkDates", userWorkDates);
			request.setAttribute("userLocations", userLocations);
			
			
			UserAdmin userAdmin = new UserAdmin();
			boolean isAdmin = userAdmin.isAdminUserId(user_id);
			//System.out.println(user_id);
			//System.out.println(isAdmin);
			//admin
			if(isAdmin) {
				request.setAttribute("admin", true);
			}else {
				request.setAttribute("admin", false);
			}
			
		}
		
		
		
		RequestDispatcher rd = request.getRequestDispatcher("/view/main_clickday_position.jsp");
		rd.forward(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
