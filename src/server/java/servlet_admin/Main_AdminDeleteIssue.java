package server.java.servlet_admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.controller.Controller;
import com.java.user.UserAdmin;

@WebServlet("/Main_AdminDeleteIssue")
public class Main_AdminDeleteIssue extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Main_AdminDeleteIssue() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		System.out.println("doget");
		
		String user_id = (String)request.getSession().getAttribute("user_id");
		String issue_number = request.getParameter("issue_number");
		UserAdmin userAdmin = new UserAdmin();
		if(user_id!=null && issue_number!=null && userAdmin.isAdminUserId(user_id)) {
			Controller controller = new Controller();
			controller.deleteLocationIssue(Integer.parseInt(issue_number));
		}else {
			
		}
		
		PrintWriter write = response.getWriter();
		write.println("<script>parent.reloadFromChildrend()</script>");
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
