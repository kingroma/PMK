package server.java.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.controller.Controller;
import com.java.user.User;

@WebServlet("/Join_CheckUserId")
public class Join_CheckUserId extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Join_CheckUserId() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    		request.setCharacterEncoding("UTF-8");
    		response.setCharacterEncoding("UTF-8");
    	
    		String user_id = request.getParameter("user_id");
    		String result = "false";
    		Controller controller = new Controller();
    		User user = controller.getUser(user_id);
    		System.out.println(user_id);
    		if(user == null) {
    			result = "true";
    		}else {
    			result = "false";
    		}
    		System.out.println(result);
    		//request.setAttribute("user_id", false);
    		PrintWriter write = response.getWriter();
    		write.println("<html><body><div id='user_id'>"+result+"</div></body></html>");
    		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
