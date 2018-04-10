package server.java.servlet2;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.controller.Controller;
import com.java.wedding.Wedding;

@WebServlet("/Main2AddWedding")
public class Main2AddWedding extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Main2AddWedding() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		String man_name = request.getParameter("boy");
		String woman_name = request.getParameter("girl");
		
		//System.out.println(year+"/"+month+"/"+day+"/"+time+"  =  "+hall_number+" , "+man_name+" , "+woman_name);
		
		if(year!=null && month!=null && day !=null && time != null &&
				location_number != null && hall_number !=null && man_name !=null && woman_name != null) {
			if(month.length() == 1) {
				month = "0" + month;
			}
			if(day.length() == 1) {
				day = "0" + day;
			}
			
			String work_date = year+month+day+time;
			Wedding wedding = new Wedding();
			wedding.setLocation_number(Integer.parseInt(location_number));
			wedding.setHall_number(Integer.parseInt(hall_number));
			wedding.setTitle(man_name+" / "+woman_name);
			wedding.setWork_date(work_date);
			
			Controller controller = new Controller();
			controller.addWedding(wedding);
			
			
		}else {
			//error
		}
		
		response.sendRedirect("/Main2?location_number=" + location_number);
		
		//request.setAttribute("location_number", location_number);
		//RequestDispatcher rd = request.getRequestDispatcher("/Main2");
		//rd.forward(request, response);
		//PrintWriter write = response.getWriter();
		//write.println("<script>parent.reloadFromChildrend()</script>");
	}

}
