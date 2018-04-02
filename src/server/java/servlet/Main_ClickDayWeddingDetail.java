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
import com.java.user.UserAdmin;
import com.java.wedding.Wedding;
import com.java.wedding.WeddingChat;
import com.java.wedding.WeddingIssue;
import com.java.wedding.WeddingPhoto;

@WebServlet("/Main_ClickDayWeddingDetail")
public class Main_ClickDayWeddingDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Main_ClickDayWeddingDetail() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		String wedding_number = request.getParameter("wedding_number");
		String user_id = (String)request.getSession().getAttribute("user_id");
		
		if(user_id!=null && wedding_number !=null) {
			Controller controller = new Controller();
			Wedding wedding = controller.getWedding(wedding_number);
			int location_number = wedding.getLocation_number();
			int hall_number = wedding.getHall_number();
			
			
			ArrayList<WeddingChat> weddingChats = controller.getWeddingChats(wedding_number);
			ArrayList<WeddingIssue> weddingIssues = controller.getWeddingIssues(wedding_number);
			ArrayList<WeddingPhoto> weddingPhotos = controller.getWeddingPhotos(wedding_number);
			wedding.setWeddingChats(weddingChats);
			wedding.setWeddingIssues(weddingIssues);
			wedding.setWeddingPhotos(weddingPhotos);
			
			request.setAttribute("wedding", wedding);
			
			UserAdmin userAdmin = new UserAdmin();
			boolean isAdmin = userAdmin.isAdminUserId(user_id);
			if(isAdmin) {
				request.setAttribute("admin", true);
			}else {
				request.setAttribute("admin", false);
			}
			
			RequestDispatcher rd = request.getRequestDispatcher("/view/main_clickday_wedding_detail.jsp");
			rd.forward(request, response);
		}else {
			response.sendRedirect("/Main");
		}
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		String user_id = (String)request.getSession().getAttribute("user_id");
		String method = request.getParameter("method");
		String wedding_number = request.getParameter("wedding_number");
		String text = request.getParameter("text");
		String title = request.getParameter("title");
		String issue_number = request.getParameter("issue_number");
		
		UserAdmin userAdmin = new UserAdmin();
		if(method != null && user_id !=null && userAdmin.isAdminUserId(user_id)) {
			Controller controller = new Controller();
			if(method.equals("addIssue") && text != null && title !=null && wedding_number!=null) {
				WeddingIssue weddingIssue = new WeddingIssue();
				weddingIssue.setText(text);
				weddingIssue.setTitle(title);
				weddingIssue.setWedding_number(Integer.parseInt(wedding_number));
				
				controller.addWeddingIssue(weddingIssue);
			}else if(method.equals("deleteIssue") && issue_number != null) {
				//System.out.println(issue_number);
				controller.deleteWeddingIssue(Integer.parseInt(issue_number));
			}
			doGet(request, response);
			//PrintWriter write = response.getWriter();
			//write.print("<script>location.reload();</script>");
			
		}
		
	}

}
