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
public class Success_class implements Serializable{
    private String user_success;

    public Success_class() {
        this.user_success = "";
    }

    public Success_class(String user_success) {
        this.user_success = user_success;
    }

    public void setUserSuccess(String user_success) {
        this.user_success = user_success;
    }

    public String getUserSuccess() {
        return user_success;
    }
}
