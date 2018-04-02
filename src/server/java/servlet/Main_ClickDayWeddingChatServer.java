package server.java.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.controller.Controller;
import com.java.user.UserAdmin;
import com.java.wedding.WeddingChat;

@WebServlet("/Main_ClickDayWeddingChatServer")
public class Main_ClickDayWeddingChatServer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Main_ClickDayWeddingChatServer() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String text = request.getParameter("text");
		String wedding_number = request.getParameter("wedding_number");
		String user_id = (String)request.getSession().getAttribute("user_id");
		if(user_id != null) {
			Controller controller = new Controller();
			
			WeddingChat weddingChat = new WeddingChat();
			weddingChat.setText(text);
			weddingChat.setUser_id(user_id);
			weddingChat.setWedding_number(Integer.parseInt(wedding_number));
			
			controller.addWeddingChat(weddingChat);
			System.out.println("get");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String text = request.getParameter("text");
		String wedding_number = request.getParameter("wedding_number");
		String user_id = (String)request.getSession().getAttribute("user_id");
		if(user_id != null) {
			Controller controller = new Controller();
			
			WeddingChat weddingChat = new WeddingChat();
			weddingChat.setText(text);
			weddingChat.setUser_id(user_id);
			weddingChat.setWedding_number(Integer.parseInt(wedding_number));
			
			controller.addWeddingChat(weddingChat);

			UserAdmin userAdmin = new UserAdmin();
			boolean isAdmin = userAdmin.isAdminUserId(user_id);
			if(isAdmin) {
				request.setAttribute("admin", true);
			}else {
				request.setAttribute("admin", false);
			}
		}else {
			PrintWriter write = response.getWriter();
			write.println("<script>parent.reloadFromChildrend()</script>");
		}
		
		
	}

}
