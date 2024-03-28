/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Login;

import java.awt.Component;
import javax.swing.JOptionPane;
import javax.swing.plaf.RootPaneUI;

/**
 *
 * @author Nguyen Quoc Trung
 */
public class Login_Check {
    public static boolean check_text(String str){
      return str.matches("[a-zA-Z]+");   
    }
    public static boolean check_number(String number){
        return number.matches("-?\\d+(\\.\\d+)?");
    }    

     public  static boolean check_SignUp(String user_text , char[] passWord_text , String phone , String name){
        if(user_text.length() * passWord_text.length * phone.length() > 0)
        {
            if(!check_text(name) || !check_number(phone)){
              Component RootPaneUI = null;
            JOptionPane.showMessageDialog(RootPaneUI," sai dinh dang ");
            }
            return true;
        }else{
            Component RootPaneUI = null;
            JOptionPane.showMessageDialog(RootPaneUI," khong dc de trong ");
            return false;
        }
     }
    public  static boolean check_Login(String user_text , char[] passWord_text){
        if(user_text.length() * passWord_text.length > 0)
        {
            return true;
        }else{
            Component RootPaneUI = null;
            JOptionPane.showMessageDialog(RootPaneUI," khong dc de trong ");
            return false;
        }
//        if(passWord_text.length > 0)
//        {
//            
//        }else{
//            Component RootPaneUI = null;
//            JOptionPane.showMessageDialog(RootPaneUI,"passWord khong dc de trong ");
//        }
    }
}
