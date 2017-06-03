/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sys.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sys.classes.DB_class;
import sys.classes.Error_class;
import sys.classes.Success_class;

/**
 *
 * @author Michael Mukolwe
 */
public class Forget extends HttpServlet {

    //    Database Object
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
        String user_email = request.getParameter("user-email");

//        check field if empty
        if (user_email.isEmpty()) {
            String signuperr = "/backend/Forget.jsp";
            String sign_error = "Fill your Email Address Please...";
            Error_class user_error = new Error_class(sign_error);
            request.setAttribute("signupErr", user_error);

            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(signuperr);
            dispatcher.forward(request, response);

        } else {
            //send mail function
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            try {
                String signupsucc = "/backend/Login.jsp";
                String sign_succ = "Check your email for the reset code ...";
                Success_class user_succ = new Success_class(sign_succ);
                request.setAttribute("signupSuccess", user_succ);

                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(signupsucc);
                dispatcher.forward(request, response);
            } catch (Exception e) {
                throw new RuntimeException("Cannot connect the Database!, " + e);
            }

        }

    }
}
