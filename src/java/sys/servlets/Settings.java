/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sys.servlets;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sys.classes.DB_class;
import sys.classes.Error_class;
import sys.classes.Success_class;
import sys.security.HashPassword;

/**
 *
 * @author Michael Mukolwe
 */
public class Settings extends HttpServlet {

    //database object  
    DB_class db = new DB_class();
    HashPassword hp = new HashPassword();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        //get setting type params
        String settingType = request.getParameter("settingType");
        String userEmail = request.getParameter("userEmail");
        System.out.println(userEmail);
        switch (settingType) {
            case "profile_settings": {
                //others param
                String userFname = request.getParameter("userFullName");
                String userPhone = request.getParameter("userPhone");
                String userLocation = request.getParameter("userLocation");
                String lat = request.getParameter("lat");
                String lng = request.getParameter("lng");
                //check which update is selected
                if (userFname.isEmpty() && userPhone.isEmpty()&&userLocation.isEmpty()) {
                    String ErrorMessage = "/backend/farmer/settings.jsp";
                    String setting_error = "No updates;empty fields";

                    Error_class user_error = new Error_class(setting_error);
                    request.setAttribute("ErrorMessage", user_error);
                    request.setAttribute("user_email", userEmail);

                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(ErrorMessage);
                    dispatcher.forward(request, response);
                } else {
                    try {
                        if (!userFname.isEmpty() && (userPhone.isEmpty()||userLocation.isEmpty())) {
                            String type = "name";
                            db.updateProfile(userFname, type, userEmail);
                        } else if ((userLocation.isEmpty() || userFname.isEmpty()) && !userPhone.isEmpty()) {
                            String type = "phone";
                            db.updateProfile(userPhone, type, userEmail);
                        }else if(!userLocation.isEmpty() && (userEmail.isEmpty()||userFname.isEmpty())){
                            String type = "location";
                            db.updateProfile(userLocation, type, userEmail);
                        }

                        String SuccessMessage = "/backend/farmer/settings.jsp";
                        String setting_success = "Details Updated...";

                        Success_class user_succ = new Success_class(setting_success);
                        request.setAttribute("signupSuccess", user_succ);
                        request.setAttribute("user_email", userEmail);

                        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(SuccessMessage);
                        dispatcher.forward(request, response);
                    } catch (SQLException e) {
                        String ErrorMessage = "/backend/farmer/settings.jsp";
                        String setting_error = e.toString();

                        Error_class user_error = new Error_class(setting_error);
                        request.setAttribute("ErrorMessage", user_error);

                        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(ErrorMessage);
                        dispatcher.forward(request, response);
                    } catch (Exception ex) {
                        String ErrorMessage = "/backend/farmer/settings.jsp";
                        String setting_error = ex.toString();

                        Error_class user_error = new Error_class(setting_error);
                        request.setAttribute("ErrorMessage", user_error);
                        request.setAttribute("user_email", userEmail);

                        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(ErrorMessage);
                        dispatcher.forward(request, response);
                    }
                }
                break;
            }
            //pic setting
            case "pic_settings":
            //expert seetting
            case "ex_prof_settings":{
            //others param
                String userFname = request.getParameter("userFullName");
                String userPhone = request.getParameter("userPhone");
                String userProff = request.getParameter("user-profession");
                //check which update is selected
                if (userFname.isEmpty() && userPhone.isEmpty() && userProff.isEmpty()) {
                    String ErrorMessage = "/backend/farmer/settings.jsp";
                    String setting_error = "No updates;empty fields";

                    Error_class user_error = new Error_class(setting_error);
                    request.setAttribute("ErrorMessage", user_error);
                    request.setAttribute("user_email", userEmail);

                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(ErrorMessage);
                    dispatcher.forward(request, response);
                } else {
                    try {
                        if (!userFname.isEmpty() && (userPhone.isEmpty()|| userProff.isEmpty())) {
                            String type = "name";
                            db.updateProfile(userFname, type, userEmail);
                        } else if ((userFname.isEmpty() || userProff.isEmpty()) && !userPhone.isEmpty()) {
                            String type = "phone";
                            db.updateProfile(userPhone, type, userEmail);
                        }else if(!userProff.isEmpty() && (userFname.isEmpty() || userPhone.isEmpty())){
                            String type = "proff";
                            db.updateProfile(userPhone, type, userEmail);
                        }

                        String SuccessMessage = "/backend/farmer/settings.jsp";
                        String setting_success = "Details Updated...";

                        Success_class user_succ = new Success_class(setting_success);
                        request.setAttribute("signupSuccess", user_succ);
                        request.setAttribute("user_email", userEmail);

                        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(SuccessMessage);
                        dispatcher.forward(request, response);
                    } catch (SQLException e) {
                        String ErrorMessage = "/backend/farmer/settings.jsp";
                        String setting_error = e.toString();

                        Error_class user_error = new Error_class(setting_error);
                        request.setAttribute("ErrorMessage", user_error);

                        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(ErrorMessage);
                        dispatcher.forward(request, response);
                    } catch (Exception ex) {
                        String ErrorMessage = "/backend/farmer/settings.jsp";
                        String setting_error = ex.toString();

                        Error_class user_error = new Error_class(setting_error);
                        request.setAttribute("ErrorMessage", user_error);
                        request.setAttribute("user_email", userEmail);

                        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(ErrorMessage);
                        dispatcher.forward(request, response);
                    }
                }
                break;
            }    
            
                
            //  UPDATE PASSWORD
            case "pass_settings":
                String old = request.getParameter("user-old-pass");
                String newPass = request.getParameter("user-new-pass");
                String newCon = request.getParameter("user-con-new-pass");
                System.out.println(old);
                //hash them
                try {
                    String oldPass = hp.hashPassword(old);
                    String passNew = hp.hashPassword(newPass);
                    String newConPass = hp.hashPassword(newCon);

                    if (old.isEmpty() | newPass.isEmpty() | newCon.isEmpty()) {
                        String ErrorMessage = "/backend/farmer/settings.jsp";
                        String setting_error = "Fill all fields to be Updated";

                        Error_class user_error = new Error_class(setting_error);
                        request.setAttribute("ErrorMessage", user_error);
                        request.setAttribute("user_email", userEmail);

                        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(ErrorMessage);
                        dispatcher.forward(request, response);
                    } else {
                        try {
                            String pass = db.getPass(userEmail);
                            System.out.println("pass" + pass);
                            System.out.println("old" + oldPass);
                            if (!pass.equals(oldPass)) {
                                String ErrorMessage = "/backend/farmer/settings.jsp";
                                String setting_error = "Check your old password";

                                Error_class user_error = new Error_class(setting_error);
                                request.setAttribute("ErrorMessage", user_error);
                                request.setAttribute("user_email", userEmail);

                                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(ErrorMessage);
                                dispatcher.forward(request, response);
                            } else if (!newPass.equals(newConPass)) {
                                String ErrorMessage = "/backend/farmer/settings.jsp";
                                String setting_error = "New password not matching";

                                Error_class user_error = new Error_class(setting_error);
                                request.setAttribute("ErrorMessage", user_error);
                                request.setAttribute("user_email", userEmail);

                                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(ErrorMessage);
                                dispatcher.forward(request, response);
                            } else {
                                try {

                                    db.updatePassword(userEmail, passNew);
                                    System.out.println(newPass);
                                    System.out.println(db.updatePassword(userEmail, newPass));

                                    String SuccessMessage = "/backend/farmer/settings.jsp";
                                    String setting_success = "Passwords Updated...";

                                    Success_class user_succ = new Success_class(setting_success);
                                    request.setAttribute("signupSuccess", user_succ);
                                    request.setAttribute("user_email", userEmail);

                                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(SuccessMessage);
                                    dispatcher.forward(request, response);
                                } catch (Exception e) {
                                    String ErrorMessage = "/backend/farmer/settings.jsp";
                                    String setting_error = e.toString();

                                    Error_class user_error = new Error_class(setting_error);
                                    request.setAttribute("ErrorMessage", user_error);
                                    request.setAttribute("user_email", userEmail);

                                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(ErrorMessage);
                                    dispatcher.forward(request, response);
                                }
                            }
                        } catch (Exception e) {
                            String ErrorMessage = "/backend/farmer/settings.jsp";
                            String setting_error = e.toString();
                            Error_class user_error = new Error_class(setting_error);
                            request.setAttribute("ErrorMessage", user_error);
                            request.setAttribute("user_email", userEmail);

                            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(ErrorMessage);
                            dispatcher.forward(request, response);
                        }
                    }
                } catch (NoSuchAlgorithmException ex) {
                    String ErrorMessage = "/backend/farmer/settings.jsp";
                    String setting_error = ex.toString();
                    Error_class user_error = new Error_class(setting_error);
                    request.setAttribute("ErrorMessage", user_error);
                    request.setAttribute("user_email", userEmail);

                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(ErrorMessage);
                    dispatcher.forward(request, response);
                }
            case "account_settings":
                try {
                    db.deactivateAccount(userEmail);
                    //delete cookies
                    Cookie cookie = null;
                    Cookie[] cookies = null;
                    // Get an array of Cookies associated with this domain
                    cookies = request.getCookies();
                    if (cookies != null) {
                        for (Cookie cookie1 : cookies) {
                            cookie = cookie1;
                            if ((cookie.getName()).compareTo("user_email") == 0) {
                                cookie.setMaxAge(0);
                                response.addCookie(cookie);
                            } else if ((cookie.getName()).compareTo("user_pass") == 0) {
                                cookie.setMaxAge(0);
                                response.addCookie(cookie);
                            }
                        }
                    }
                    //remove session
                    HttpSession session = request.getSession();
                    session.removeAttribute("user");
                    session.invalidate();

                    response.sendRedirect("../../index.jsp");
                } catch (Exception ex) {

                }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doPost(request, response);
    }
}
