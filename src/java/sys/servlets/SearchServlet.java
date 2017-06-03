package sys.servlets;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.RowFilter;
import sys.classes.DB_class;

public class SearchServlet extends HttpServlet {

    DB_class DB = new DB_class();

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse responce)throws ServletException
    , IOException {
        doPost(request, responce);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException
    , IOException{
        String search_filter = request.getParameter("inputSearch");
        String page = request.getParameter("searchFrom");
        //
        if(page.equals("mainSearch")){
            String page_url = "/backend/Search.jsp";

            request.setAttribute("search_filter", search_filter);

            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(page_url);
            dispatcher.forward(request, response);
        }else if(page.equals("farmSearch")){
            String result = DB.searchEpidemic(search_filter);
            String page_url = "/backend/farmer/FarmerDash.jsp";
            request.setAttribute("search_filter", search_filter);
            request.setAttribute("search_result", result);

            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(page_url);
            dispatcher.forward(request, response);
        }
    }
}
