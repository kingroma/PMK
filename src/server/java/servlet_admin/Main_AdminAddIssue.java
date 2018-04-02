package server.java.servlet_admin;

import java.io.IOException;
import java.io.PrintWriter;

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

@WebServlet("/Main_AdminAddIssue")
public class Main_AdminAddIssue extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Main_AdminAddIssue() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		String user_id = (String)request.getSession().getAttribute("user_id");
		String location_number = request.getParameter("location_number");
		String work_date = request.getParameter("work_date");
		UserAdmin userAdmin = new UserAdmin();
		System.out.println(user_id + " / " + work_date + " / "+location_number );
		if(user_id!=null && work_date!=null && location_number != null && userAdmin.isAdminUserId(user_id)) {
			request.setAttribute("location_number", location_number);
			request.setAttribute("work_date", work_date);
			
			RequestDispatcher rd = request.getRequestDispatcher("/view_admin/main_adminAddIssue.jsp");
			rd.forward(request, response);
		}else {
			
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		String user_id = (String)request.getSession().getAttribute("user_id");
		String location_number = request.getParameter("location_number");
		String work_date = request.getParameter("work_date");
		String title = request.getParameter("title");
		String text = request.getParameter("text");
		UserAdmin userAdmin = new UserAdmin();
		if(user_id!=null && work_date!=null && location_number != null && userAdmin.isAdminUserId(user_id)) {
			Controller controller = new Controller();
			
			LocationIssue locationIssue = new LocationIssue();
			locationIssue.setLocation_number(Integer.parseInt(location_number));
			locationIssue.setText(text);
			locationIssue.setTitle(title);
			locationIssue.setWork_date(work_date);
			
			controller.addLocationIssue(locationIssue);
		}else {
			
		}
		
		PrintWriter write = response.getWriter();
		write.println("<script>parent.reloadFromChildrend()</script>");
	}

}
