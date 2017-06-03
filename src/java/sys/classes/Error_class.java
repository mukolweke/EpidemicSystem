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
public class Error_class implements Serializable{
     private String ErrorMessage;
    
    public Error_class(){
        this.ErrorMessage = "";
    }
    
    public Error_class(String ErrorMessage){
        this.ErrorMessage = ErrorMessage;
    }
    
    public void setErrorMessage(String ErrorMessage){
        this.ErrorMessage = ErrorMessage;
    }
    
    public String getErrorMessage(){
        return ErrorMessage;
    }
}
