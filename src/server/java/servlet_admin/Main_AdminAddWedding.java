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
import com.java.user.UserAdmin;
import com.java.wedding.Wedding;

@WebServlet("/Main_AdminAddWedding")
//			 /Main_adminAddWedding
public class Main_AdminAddWedding extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Main_AdminAddWedding() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		String user_id = (String)request.getSession().getAttribute("user_id");
		String location_number = request.getParameter("location_number");
		UserAdmin userAdmin = new UserAdmin();
		if(user_id!=null && location_number != null && userAdmin.isAdminUserId(user_id)) {
			Controller controller = new Controller();
			Location location = controller.getLocationAdmin(location_number);
			
			request.setAttribute("location", location);
			
			RequestDispatcher rd = request.getRequestDispatcher("/view_admin/main_adminAddWedding.jsp");
			rd.forward(request, response);
		}else {
			//PrintWriter write = response.getWriter();
			//String text = "<script>location.reload();</script>";
			//write.println(text);
		}
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String time = request.getParameter("time");
		
		String location_number = request.getParameter("location_number");
		String hall_number = request.getParameter("hall_number");
		String man_name = request.getParameter("man_name");
		String woman_name = request.getParameter("woman_name");
		
		//System.out.println(year+"/"+month+"/"+day+"/"+time+"  =  "+hall_number+" , "+man_name+" , "+woman_name);
		
		
		if(year!=null && month!=null && day !=null && time != null &&
				location_number != null && hall_number !=null && man_name !=null && woman_name != null) {
			String work_date = year+month+day+time;
			Wedding wedding = new Wedding();
			wedding.setLocation_number(Integer.parseInt(location_number));
			wedding.setHall_number(Integer.parseInt(hall_number));
			wedding.setTitle(man_name+" / "+woman_name);
			wedding.setWork_date(work_date);
			
			Controller controller = new Controller();
			controller.addWedding(wedding);
			
		}
		
		PrintWriter write = response.getWriter();
		write.println("<script>parent.reloadFromChildrend()</script>");
		
	}

}
