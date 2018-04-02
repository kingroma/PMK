package server.java.servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.controller.Controller;
import com.java.wedding.WeddingPhoto;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/Main_ClickDayWeddingPhotoServer")
public class Main_ClickDayWeddingPhotoServer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Main_ClickDayWeddingPhotoServer() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int sizeLimit = 1024*1024*15;
		String path = "/Users/mac/Desktop/pmk2/pmk/WebContent/weddingPhoto/";
		String url = "/weddingPhoto/";
		try {
			MultipartRequest multi = new MultipartRequest(request, path , sizeLimit, "utf-8", new DefaultFileRenamePolicy());
			//File file = multi.getFile("file");
			//String title = multi.getParameter("title");
			String title = multi.getParameter("title");
			String user_id = (String)request.getSession().getAttribute("user_id");
			String wedding_number = multi.getParameter("wedding_number");
			File file = multi.getFile("photo");
			String fileName = file.getName();
			
			
			Controller controller = new Controller();
			WeddingPhoto weddingPhoto = new WeddingPhoto();
			weddingPhoto.setTitle(title);
			weddingPhoto.setUser_id(user_id);
			weddingPhoto.setWedding_number(Integer.parseInt(wedding_number));
			weddingPhoto.setImgUrl(url+fileName);
			
			controller.addWeddingPhoto(weddingPhoto);
			
			response.sendRedirect("/Main_ClickDayWeddingDetail?wedding_number="+wedding_number);
			
			//System.out.println("title : "+file.getName()+" ** "+file.getAbsolutePath());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
