package server.java.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
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
import com.java.user.UserAdmin;
import com.java.user.UserLocation;
import com.java.util.MyDate;
import com.java.wedding.Wedding;

@WebServlet("/Main")
public class Main extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Main() {
        super();
    }

    public String parseJspArrayList(String input) {
    		StringBuilder result = new StringBuilder();
    		
    		return result.toString();
    }
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");

		/** 
		 * first check session for user_id
		 */
		UserAdmin userAdmin = new UserAdmin();
		String user_id = (String)request.getSession().getAttribute("user_id");
		
		Location location = null;
		ArrayList<Wedding> weddings = null;
		if(user_id == null) {
			response.sendRedirect("/Login");
		}else {
			try {
				Controller controller = new Controller();
				ArrayList<UserLocation> userLocations = controller.getUserLocations(user_id);
				ArrayList<String> weddingList = new ArrayList<String>(); 
				Map<String,Integer> weddingMap = new HashMap<String,Integer>();
				
				
				// jsp 에 맞게 집어넣기 
				if(userLocations.size()>0) {
					int location_number = userLocations.get(0).getLocation_number();
					location = controller.getLocation(location_number);
					
					weddings = controller.getWeddings(location_number);
					for(Object wedding : weddings.toArray()) {
						Wedding w = (Wedding)wedding;
						Date date = MyDate.changeStringToDate(w.getWork_date());
						int wedding_hall_number = w.getHall_number();
						String hallName = "";
						for(Object hall : location.getHalls().toArray()) {
							Hall h = (Hall)hall;
							if(wedding_hall_number == h.getHall_number()) {
								hallName = h.getName();
								//hallNh.getNickname();
								break;
							}
						}
						
						String key = hallName+"_"+date.getYear()+"/"+(date.getMonth()+1)+"/"+date.getDate();
						System.out.println(w.getWork_date()+"   /   "+key);
						Object num = weddingMap.get(key);
						if(num == null) {
							weddingMap.put(key, 1);
						}else {
							weddingMap.put(key,(int)num+1);
						}
						
						
					}
					
					for(String key : weddingMap.keySet()) {
						weddingList.add(key+"/"+weddingMap.get(key));
					}
					request.setAttribute("weddingList", weddingList);
					request.setAttribute("location", location);
					
					System.out.println(weddingList);
					// User Work Date set 
					ArrayList<String> userWorkDate = controller.getUserWorkDatesAndGetOnlyWorkDateStringList(location_number, user_id);
					request.setAttribute("userWorkDate", userWorkDate);
					
					boolean isAdmin = userAdmin.isAdminUserId(user_id);
					//System.out.println(user_id);
					//System.out.println(isAdmin);
					//admin
					if(isAdmin) {
						request.setAttribute("admin", true);
					}else {
						request.setAttribute("admin", false);
					}
					
					try {
						RequestDispatcher rd = request.getRequestDispatcher("/view/main.jsp");
						rd.forward(request, response);
					}catch(Exception e) {
						e.printStackTrace();
					}
				}else {
					RequestDispatcher rd = request.getRequestDispatcher("/view/main.jsp");
					rd.forward(request, response);
				}
				
				
				
			}catch(Exception e) {
				RequestDispatcher rd = request.getRequestDispatcher("/view/error.jsp");
				rd.forward(request, response);
			}
		}
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
	}

}
