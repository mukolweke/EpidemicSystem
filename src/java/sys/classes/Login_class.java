/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sys.classes;

import java.io.Serializable;

/**
 *
 * @author Michael Mukolwe
 */
public class Login_class implements Serializable {

    private static final long serialVersionUID = 1L;

    private String user_email;
    private String user_pass;

//    empty constructor
    public Login_class() {
        user_email = "";
        user_pass = "";
    }
//    init constructor

    public Login_class(String email, String pass) {
        user_email = email;
        user_pass = pass;
    }
//    setters

    public void setUserEmail(String email) {
        user_email = email;
    }

    public void setUserPass(String pass) {
        user_pass = pass;
    }

//    getters
    public String getUserEmail() {
        return user_email;
    }

    public String getUserPass() {
        return user_pass;
    }
}
