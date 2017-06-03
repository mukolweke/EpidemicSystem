/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sys.servlets;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sys.classes.DB_class;
import sys.classes.Error_class;
import sys.classes.GetLocation;
import sys.classes.Success_class;
import sys.security.HashPassword;

/**
 *
 * @author Michael Mukolwe
 */
public class AddExpert extends HttpServlet {

    //objects
    HashPassword hp = new HashPassword();
    DB_class db = new DB_class();

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //parameters
        String fullName = request.getParameter("user-name");
        String email = request.getParameter("user-email");
        String phone = request.getParameter("user-phone");
        String fieldStusy = request.getParameter("field-study");
        String city = request.getParameter("user-location");
        String lat = request.getParameter("lat");
        String lng = request.getParameter("lng");
        String password = request.getParameter("user-password");
        String regDate = request.getParameter("reg-date");
        String userType = "expert";

        //check if fields are empty
        if (fullName.isEmpty() | email.isEmpty() | phone.isEmpty()
                | fieldStusy.isEmpty() | password.isEmpty() | city.isEmpty()) {
            String signuperr = "/backend/admin/ExpertPage.jsp";
            String sign_error = "Fill the Empty Fields Please...";
            Error_class user_error = new Error_class(sign_error);
            request.setAttribute("addUserErr", user_error);

            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(signuperr);
            dispatcher.forward(request, response);
        } else {
            try {
                String passcode = hp.hashPassword(password);
                //check if user exists
//                if (db.checkUser(email, "email").equals(email) | db.checkUser(email, "pass").equals(passcode)) {
//                    String signuperr = "/backend/admin/ExpertPage.jsp";
//                    String sign_error = "Email / Password already exist...";
//                    Error_class user_error = new Error_class(sign_error);
//                    request.setAttribute("addUserErr", user_error);
//
//                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(signuperr);
//                    dispatcher.forward(request, response);
//                } else 
                {
                    db.addExpert(fullName, email, phone, fieldStusy, passcode, city,lat,lng, regDate, userType);
                    String redir = "/backend/admin/ExpertPage.jsp";
                    String add_succ = "Experts Details Saved Successfully";
                    Success_class addSucc = new Success_class(add_succ);

                    request.setAttribute("addSuccess", addSucc);

                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(redir);
                    dispatcher.forward(request, response);
                }
            } catch (ClassNotFoundException cl) {
                System.out.println("Class not found" + cl);
            } catch (Exception e) {
                throw new RuntimeException("Cannot connect the Database!, " + e);
            }
        }
    }
}
