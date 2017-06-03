package sys.servlets;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sys.classes.DB_class;

/**
 *
 * @author Michael Mukolwe
 */
public class PostEpidemic extends HttpServlet {

    DB_class dbase = new DB_class();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("useremail");
        String blog_title = request.getParameter("blog-title");
        String blog_desc = request.getParameter("blog-content");
        String blog_date = request.getParameter("blogdate");

        if (blog_desc.isEmpty() || blog_title.isEmpty()) {
            String ErrorPage = "/backend/farmer/FarmerDash.jsp";
            String blog_err = "Post a Question correctly";

            request.setAttribute("ErrorMessage", blog_err);

            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(ErrorPage);
            dispatcher.forward(request, response);
        } else {
            try {
                dbase.newConn();
                int user_id = dbase.getUserId(username);
                double lat = dbase.getLat(username, "farmer");
                double lng = dbase.getLng(username, "farmer");
                int postQuerryStatus = dbase.postQuestion(user_id, blog_title, blog_desc, lat, lng, blog_date);
                int post_id = dbase.getQuestion(user_id, blog_title, blog_date);
                int postNotf = dbase.postNotf(user_id, "post", post_id);
                System.out.println("id: "+postNotf);
                if (postQuerryStatus == 1 && postNotf == 1) {
                    String page_url = "/backend/farmer/FarmerDash.jsp";
                    String post_success = "Successfull Postings";

                    request.setAttribute("post_succ", post_success);
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(page_url);
                    dispatcher.forward(request, response);
                } else {
                    String page_url = "/backend/farmer/FarmerDash.jsp";
                    String post_success = "Unsuccessfull Postings";

                    request.setAttribute("post_error", post_success);
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(page_url);
                    dispatcher.forward(request, response);
                }

            } catch (SQLException ex) {
                //Tell if no database is connected                    
                String ErrorMessage = "/backend/farmer/FarmerDash.jsp";
                String post_error = "Database Connection Unsuccessfull" + ex;

                request.setAttribute("ErrorMessage", post_error);

                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(ErrorMessage);
                dispatcher.forward(request, response);
            } catch (Exception ex) {
                //Tell if no database is connected                    
                request.getSession().invalidate();

                String ErrorMessage = "/backend/farmer/FarmerDash.jsp";
                String post_error = "Class Not Found" + ex;

                request.setAttribute("ErrorMessage", post_error);

                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(ErrorMessage);
                dispatcher.forward(request, response);
            }
        }
    }

}
