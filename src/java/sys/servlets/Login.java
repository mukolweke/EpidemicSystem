package sys.servlets;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sys.classes.*;
import sys.security.HashPassword;

public class Login extends HttpServlet {

    //database object  
    HashPassword hp = new HashPassword();
    DB_class db = new DB_class();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        //get params
        String useremail = request.getParameter("user-email");
        String userpass = request.getParameter("user-password");
        String checkRemember = request.getParameter("rememberme");

        if (useremail.isEmpty() | userpass.isEmpty()) {
            String ErrorMessage = "/backend/Login.jsp";
            String login_error = "Fill both your email and password";

            Error_class user_error = new Error_class(login_error);
            request.setAttribute("ErrorMessage", user_error);

            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(ErrorMessage);
            dispatcher.forward(request, response);
        } else {

            try {
                db.newConn();
                String pass = hp.hashPassword(userpass);
                //setup cookie;one week age
                if (checkRemember != null) {
                    Cookie user_email = new Cookie("user_email", useremail);
                    Cookie user_pass = new Cookie("user_pass", pass);
                    // Set expiry date after 24 Hrs for both the cookies.
                    user_email.setMaxAge(60 * 60 * 24 * 7);
                    user_pass.setMaxAge(60 * 60 * 24 * 7);

                    // Add both the cookies in the response header.
                    response.addCookie(user_email);
                    response.addCookie(user_pass);
                }

                int group_num = db.userLogin(useremail, pass);
                switch (group_num) {
                    case 1: {
                        Login_class user_login = new Login_class(useremail, userpass);
                        HttpSession session = request.getSession();
                        session.setAttribute("user", user_login);
                        //Load admin
                        String loginSuccess = "./admin/AdminDash.jsp";
                        response.sendRedirect(loginSuccess);
                        break;
                    }
                    case 2: {
                        Login_class user_login = new Login_class(useremail, userpass);
                        HttpSession session = request.getSession();
                        session.setAttribute("user", user_login);
                        //Load admin
                        String loginSuccess = "./expert/ExpertDash.jsp";
                        response.sendRedirect(loginSuccess);
                        break;
                    }
                    case 3: {

                        Login_class user_login = new Login_class(useremail, userpass);
                        HttpSession session = request.getSession();
                        session.setAttribute("user", user_login);
                        //Load admin
                        String loginSuccess = "./farmer/FarmerDash.jsp";
                        response.sendRedirect(loginSuccess);
                        break;
                    }
                    case 4: {
                        String ErrorMessage = "/backend/Login.jsp";
                        String login_error = "User account not available.Create Account";
                        Error_class user_error = new Error_class(login_error);
                        request.setAttribute("ErrorMessage", user_error);
                        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(ErrorMessage);
                        dispatcher.forward(request, response);
                        break;
                    }
                    default:
                        //destroy any session
                        String ErrorMessage = "/backend/Login.jsp";
                        String login_error = "Wrong email or password";
                        Error_class user_error = new Error_class(login_error);
                        request.setAttribute("ErrorMessage", user_error);
                        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(ErrorMessage);
                        dispatcher.forward(request, response);
                        break;
                }
            } catch (SQLException e) {
                //Tell if no database is connected                    
                request.getSession().invalidate();

                String ErrorMessage = "/backend/Login.jsp";
                String login_error = "Wrong email or password";
                System.out.println(e);
                Error_class user_error = new Error_class(login_error);
                request.setAttribute("ErrorMessage", user_error);

                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(ErrorMessage);
                dispatcher.forward(request, response);
            } catch (Exception ex) {

            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doPost(request, response);
    }
}
