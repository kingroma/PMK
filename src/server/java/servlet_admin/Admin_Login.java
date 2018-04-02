package server.java.servlet_admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.controller.Controller;
import com.java.user.User;
import com.java.user.UserAdmin;

@WebServlet("/Admin_Login")
public class Admin_Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Admin_Login() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		String user_id_admin = (String)request.getSession().getAttribute("user_id_admin");
		if(user_id_admin!=null) {
			response.sendRedirect("/Admin_Main");
		}else {
			RequestDispatcher rd = request.getRequestDispatcher("/view_admin/login.jsp");
			rd.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		UserAdmin userAdmin = new UserAdmin();
		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");
		
		System.out.println(user_id+"/"+user_pw);
		
		Controller controller = new Controller();
		User user = controller.getUser(user_id);
		if(user!=null && user.getUser_pw().equals(user_pw) && userAdmin.isAdminUserId(user_id)) {
			request.getSession().setAttribute("user_id_admin", user_id);
			System.out.println("admin login");
			response.sendRedirect("/Admin_Main");
		}else {
			doGet(request, response);
		}
		
		
	}

}
