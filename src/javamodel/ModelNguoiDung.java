
package javamodel;


public class ModelNguoiDung {
    private int userID;
    private String email;
    private String password;
    private String verifyCode;
    private String trangThai ;
    private String vaiTro ;

    public ModelNguoiDung() {
    }

    public ModelNguoiDung(int userID, String email, String password, String verifyCode, String trangThai, String vaiTro) {
        this.userID = userID;
        this.email = email;
        this.password = password;
        this.verifyCode = verifyCode;
        this.trangThai = trangThai;
        this.vaiTro = vaiTro;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getVerifyCode() {
        return verifyCode;
    }

    public void setVerifyCode(String verifyCode) {
        this.verifyCode = verifyCode;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public String getVaiTro() {
        return vaiTro;
    }

    public void setVaiTro(String vaiTro) {
        this.vaiTro = vaiTro;
    }
    
    
}
