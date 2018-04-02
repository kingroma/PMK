package server.java.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.controller.Controller;

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Login() {
        super();
    }

    private String loginUrl = "/view/login.jsp";
    private String mainUrl = "/Main";
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String user_id = (String)request.getSession().getAttribute("user_id");
		if(user_id == null) {
			//login page
			RequestDispatcher rd = request.getRequestDispatcher(loginUrl);
			rd.forward(request, response);
		}else {
			response.sendRedirect(mainUrl);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String user_id = (String)request.getSession().getAttribute("user_id");
		if(user_id == null) {
			//login page
			user_id = request.getParameter("user_id");
			String user_pw = request.getParameter("user_pw");
			System.out.println(user_id+" / "+user_pw);
			Controller controller = new Controller();
			int result = controller.login(user_id, user_pw);
			
			String msg = "";
			if(result==0) {
				request.getSession().setAttribute("user_id", user_id);
				response.sendRedirect(mainUrl);
			}else if(result==1){
				msg = "id cant figure out !";
				request.setAttribute("mymsg", msg);
				this.doGet(request, response);
			}else {
				msg = "pw is not !";
				request.setAttribute("mymsg", msg);
				this.doGet(request, response);
			}
		}else {
			response.sendRedirect(mainUrl);	
		}
		
	}

}
