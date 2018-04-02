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
import com.java.wedding.WeddingIssue;

@WebServlet("/Main_AdminWeddingIssue")
public class Main_AdminWeddingIssue extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Main_AdminWeddingIssue() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
			if(method.equals("addIssue") && wedding_number !=null && text != null && title !=null ) {
				WeddingIssue weddingIssue = new WeddingIssue();
				weddingIssue.setText(text);
				weddingIssue.setTitle(title);
				weddingIssue.setWedding_number(Integer.parseInt(wedding_number));
				
				controller.addWeddingIssue(weddingIssue);
			}else if(method.equals("deleteIssue") && issue_number != null) {
				System.out.println(issue_number);
			}
			
			PrintWriter write = response.getWriter();
			write.print("<script>parent.location.reload();</script>");
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
		
		System.out.println(method+" / "+wedding_number + "/ "+ text + "/ "+title);
		UserAdmin userAdmin = new UserAdmin();
		if(method != null && wedding_number !=null && user_id !=null && userAdmin.isAdminUserId(user_id)) {
			Controller controller = new Controller();
			if(method.equals("addIssue") && text != null && title !=null ) {
				WeddingIssue weddingIssue = new WeddingIssue();
				weddingIssue.setText(text);
				weddingIssue.setTitle(title);
				weddingIssue.setWedding_number(Integer.parseInt(wedding_number));
				
				controller.addWeddingIssue(weddingIssue);
			}else if(method.equals("deleteIssue") && issue_number != null) {
				
			}
			
			PrintWriter write = response.getWriter();
			write.print("<script>parent.location.reload();</script>");
		}
	}

}
