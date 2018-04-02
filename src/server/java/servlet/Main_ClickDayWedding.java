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
import com.java.test.TestSet;
import com.java.user.UserAdmin;
import com.java.util.MyDate;
import com.java.wedding.Wedding;

@WebServlet("/Main_ClickDayWedding")
public class Main_ClickDayWedding extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Main_ClickDayWedding() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		//Location location = TestSet.location;
		//ArrayList<Wedding> weddings = TestSet.weddings;
		
		String user_id = (String)request.getSession().getAttribute("user_id");
		String location_number = request.getParameter("location_number");
		String date = request.getParameter("date");
		
		//date 2018/3/3
		
		if(user_id==null) {
			PrintWriter write = response.getWriter();
			write.println("<script>parent.reloadFromChildrend()</script>");
		}else {
			String work_date = MyDate.removeSlashFromJavascript(date);
			
			Controller controller = new Controller();
			Location location = controller.getLocation(location_number);
			ArrayList<Wedding> weddings = controller.getWeddingsWithLocationNumberDate(location_number, work_date);
			
			
			request.setAttribute("location", location);
			request.setAttribute("weddings", weddings);	
			request.setAttribute("date", MyDate.removeSlashFromJavascript(date));
			request.setAttribute("location_number", request.getParameter("location_number"));
			
			UserAdmin userAdmin = new UserAdmin();
			boolean isAdmin = userAdmin.isAdminUserId(user_id);
			if(isAdmin) {
				request.setAttribute("admin", true);
			}else {
				request.setAttribute("admin", false);
			}
			
			try {
				RequestDispatcher rd = request.getRequestDispatcher("/view/main_clickday_wedding.jsp");
				rd.forward(request, response);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
