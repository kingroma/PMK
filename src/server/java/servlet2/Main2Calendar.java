package server.java.servlet2;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.controller.Controller;
import com.java.hall.Hall;
import com.java.location.Location;
import com.java.wedding.Wedding;

@WebServlet("/Main2Calendar")
public class Main2Calendar extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Main2Calendar() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		String year = request.getParameter("year");
		request.setAttribute("year", year);
		String month = request.getParameter("month");
		request.setAttribute("month", month);
		
		String location_number = request.getParameter("location_number");
		String user_id = (String)request.getSession().getAttribute("user_id");
		
		if(month.length()==1) {	month = "0"+month;	}
		String work_date=year+month;
		Controller controller = new Controller();
		Location location = controller.getLocation(location_number);
		//ArrayList<Wedding> weddings = controller.getWeddingsWithLocationNumberDate(location_number, work_date);
		ArrayList<Wedding> weddings = controller.getWeddings(Integer.parseInt(location_number));
		//weddingInfoMap
		Map<String,String> weddingInfoMap = new HashMap<String,String>(); 
		
		for(Wedding wedding : weddings) {
			String weddingDate = wedding.getWork_date().substring(0, 8);
			int weddingHallNumber = wedding.getHall_number();
			String hallNickname = "";
			for(Hall hall : location.getHalls()) {
				if(hall.getHall_number()==weddingHallNumber) {
					hallNickname = hall.getNickname();
					break;
				}
			}
			String keyForm = hallNickname+"_"+weddingDate;
			String weddingCount = weddingInfoMap.get(keyForm);
			if(weddingCount==null) {
				weddingInfoMap.put(keyForm, "1");
			}else {
				weddingInfoMap.put(keyForm,""+(Integer.parseInt(weddingCount)+1));
			}
		}
		//weddingInfoMap
		
		//UserLocation 
		
		request.setAttribute("weddingInfoMap", weddingInfoMap);
		request.setAttribute("location", location);
		request.setAttribute("weddings", weddings);
		
		RequestDispatcher rd = request.getRequestDispatcher("/view2/calendar.jsp");
		rd.forward(request, response);
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
	

}
