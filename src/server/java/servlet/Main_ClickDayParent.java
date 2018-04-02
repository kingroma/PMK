package server.java.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Main_ClickDayParent")
public class Main_ClickDayParent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Main_ClickDayParent() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		
		request.setAttribute("date", request.getParameter("date"));
		request.setAttribute("location_number", request.getParameter("location_number"));
		
		RequestDispatcher rd = request.getRequestDispatcher("/view/main_clickdayParent.jsp");
		rd.forward(request,response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
