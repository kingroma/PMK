package server.java.servlet;

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
import com.java.location.LocationChat;
import com.java.user.User;
import com.java.user.UserAdmin;
import com.java.util.MyDate;

@WebServlet("/Main_ClickDayChat")
public class Main_ClickDayChat extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Main_ClickDayChat() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String user_id = (String)request.getSession().getAttribute("user_id");
		
		String location_number = request.getParameter("location_number");
		String date = request.getParameter("date");
		String work_date = MyDate.removeSlashFromJavascript(date);
		
		if(user_id==null) {
			//response.sendRedirect("/Login");
			PrintWriter write = response.getWriter();
			write.println("<script>parent.reloadFromChildrend()</script>");
		}else if(location_number!=null && date != null && work_date != null){
			Controller controller = new Controller();
			
			
			Location location = controller.getLocation(location_number);
			location.setLocationChats(controller.getLocationChat(Integer.parseInt(location_number), work_date));
			
			request.setAttribute("location", location);
			request.setAttribute("date", date);
			
			UserAdmin userAdmin = new UserAdmin();
			boolean isAdmin = userAdmin.isAdminUserId(user_id);
			if(isAdmin) {
				request.setAttribute("admin", true);
			}else {
				request.setAttribute("admin", false);
			}
			
			RequestDispatcher rd = request.getRequestDispatcher("/view/main_clickday_chat.jsp");
			rd.forward(request,response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String user_id = (String)request.getSession().getAttribute("user_id");
		if(user_id==null) {
			//response.sendRedirect("/Login");
			PrintWriter write = response.getWriter();
			write.println("<script>parent.reloadFromChildrend()</script>");
		}
		else {
			Controller controller = new Controller();
			int location_number = Integer.parseInt(request.getParameter("location_number"));
			String date = request.getParameter("date");
			String work_date = MyDate.removeSlashFromJavascript(date);
			String text = request.getParameter("text");
			
			User user = controller.getUser(user_id);
			
			LocationChat locationChat = new LocationChat();
			locationChat.setLocation_number(location_number);
			locationChat.setText(text);
			locationChat.setUser_id(user_id);
			locationChat.setWork_date(work_date);
			controller.addLocationChat(locationChat);
			
			this.doGet(request, response);
		}
	}

}
