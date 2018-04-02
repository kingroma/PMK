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
import com.java.location.LocationIssue;
import com.java.user.UserAdmin;
import com.java.util.MyDate;

@WebServlet("/Main_ClickDayIssue")
public class Main_ClickDayIssue extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Main_ClickDayIssue() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		Controller controller = new Controller();
		String location_number = request.getParameter("location_number");
		String date = request.getParameter("date");
		String work_date = MyDate.removeSlashFromJavascript(date);
		String user_id = (String)request.getSession().getAttribute("user_id");
		
		if(user_id!=null) {
			Location location = controller.getLocation(location_number);
			location.setLocationIssues(controller.getLocationIssueWithLocationNumberDate(location_number, work_date));
			
			request.setAttribute("location", location);
			request.setAttribute("work_date", work_date);
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
			
			RequestDispatcher rd = request.getRequestDispatcher("/view/main_clickday_issue.jsp");
			rd.forward(request,response);
		}else {
			PrintWriter write = response.getWriter();
			write.println("<script>parent.reloadFromChildrend()</script>");
		}
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
