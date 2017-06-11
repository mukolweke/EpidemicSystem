package sys.servlets;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sys.classes.*;
import sys.security.HashPassword;

/**
 *
 * @author Michael Mukolwe
 */
public class SignUp extends HttpServlet {
//    Objects

    HashPassword hp = new HashPassword();
    DB_class db = new DB_class();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

//       user signup details
        String full_name = request.getParameter("user-full-name");
        String email = request.getParameter("user-email");
        String phone = request.getParameter("user-phone");
        String pass = request.getParameter("user-password");
        String cpass = request.getParameter("user-con-password");
        String userLoc = request.getParameter("user-search");
        String lat = request.getParameter("lat");
        String lng = request.getParameter("lng");
        String regDate = request.getParameter("reg_date");

//        verify  fields if empty
        if (full_name.isEmpty() | email.isEmpty() | phone.isEmpty()
                | pass.isEmpty() | cpass.isEmpty() | userLoc.isEmpty()) {
            String signuperr = "/backend/SignUp.jsp";
            String sign_error = "Fill the Details correctly Please...";
            Error_class user_error = new Error_class(sign_error);
            request.setAttribute("signupErr", user_error);

            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(signuperr);
            dispatcher.forward(request, response);
        } else {
            try {
                String passcode = hp.hashPassword(pass);
//                //check if user exists
//                if (db.checkUser(email, "email").equals(email) || db.checkUser(email, "pass").equals(pass)) {
//                    String signuperr = "/backend/SignUp.jsp";
//                    String sign_error = "Email / Password already exist...";
//                    Error_class user_error = new Error_class(sign_error);
//                    request.setAttribute("signupErr", user_error);
//
//                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(signuperr);
//                    dispatcher.forward(request, response);
//                } else 
                {
                    //if not empty; submit, then redirect
                    Sign_class user_details = new Sign_class(full_name, email, phone, pass, userLoc);

                    db.addFarmer(full_name, email, phone, passcode, userLoc, lat, lng, regDate);

                    HttpSession session = request.getSession();

                    session.setAttribute("user_details", user_details);
                    String signupsucc = "/backend/Login.jsp";
                    String sign_succ = "User Details Saved Successfully, Now Login";

                    Success_class user_succ = new Success_class(sign_succ);
                    request.setAttribute("signupSuccess", user_succ);

                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(signupsucc);
                    dispatcher.forward(request, response);
                }
            } catch (Exception err) {
                String signuperr = "/backend/SignUp.jsp";
                String sign_error = "SQL ERROR " + err;
                Error_class user_error = new Error_class(sign_error);
                request.setAttribute("signupErr", user_error);

                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(signuperr);
                dispatcher.forward(request, response);
            }
        }
    }
}
