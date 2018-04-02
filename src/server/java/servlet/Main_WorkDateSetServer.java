package server.java.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.controller.Controller;
import com.java.user.UserWorkDate;
import com.java.util.MyDate;

@WebServlet("/Main_WorkDateSetServer")
public class Main_WorkDateSetServer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Main_WorkDateSetServer() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		String user_id = (String)request.getSession().getAttribute("user_id");
		
		if(user_id == null) {
			PrintWriter out = response.getWriter();
			out.print("<script>alert('login plz');");
			out.print("location.href='/Login'");
		}else {
			String location_number = request.getParameter("location_number");
			String date = request.getParameter("date");
			String work_date = MyDate.removeSlashFromJavascript(date);
			String ox = request.getParameter("ox");
			if(location_number!=null&&date!=null&&ox!=null) {
				try {
					//System.out.println(user_id+"_"+location_number+"_"+date+"_"+ox);
					UserWorkDate userWorkDate = new UserWorkDate();
					userWorkDate.setLocation_number(Integer.parseInt(location_number));
					userWorkDate.setUser_id(user_id);
					userWorkDate.setWork_date(work_date+"0000");
					
					
					Controller controller = new Controller();
					if(ox.equals("o")) {
						System.out.println("add : "+userWorkDate.getUser_id()+"/"+userWorkDate.getWork_date()+"/"+userWorkDate.getLocation_number());
						controller.addUserWorkDate(userWorkDate);
					}else if(ox.equals("x")) {
						System.out.println("delete : "+userWorkDate.getUser_id()+"/"+userWorkDate.getWork_date()+"/"+userWorkDate.getLocation_number());
						controller.deleteUserWorkDate(userWorkDate);
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
