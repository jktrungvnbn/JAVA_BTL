package BiA.Controller;


import BiA.Controller.Connection.DatabaseConnection;
import BiA.javamodel.ModelLogin;
import BiA.javamodel.ModelNguoiDung;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;


/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Nguyen Quoc Trung
 */
public class _ServiceUser {
    private final Connection connection;
    //Connect tới DataBase 
    public _ServiceUser() {
        connection =DatabaseConnection.getInstance().getConnection() ;
    }
    
    /*
        Kiểm tra thông tin đăng nhập
        Trả về : null <- Nếu Thông tin đăng nhập sai
                 ModelNguoiDung <- Nếu thông tin đăng nhập đúng
    */
    public ModelNguoiDung login(ModelLogin login)throws SQLException {
        ModelNguoiDung nguoiDung = null ;
        String sql = "SELECT * FROM nguoidung WHERE Email=? AND Matkhau=? LIMIT 1";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1,login.getEmail());
        ps.setString(2, login.getPassword());
        ResultSet r = ps.executeQuery();
        if(r.next()){
            int  UserID = r.getInt("UserID");
            String email=r.getString("Email");
            String password=r.getString("Matkhau");
            String role=r.getString("Vaitro");
            nguoiDung =new ModelNguoiDung(UserID,email,password,role);
        }
        r.close();
        ps.close();
        return nguoiDung;
    }
    
    /*
        Phần đăng ký chỉ dành cho khách hàng, sau khi đăng ký thành công:
        Thêm thông tin Người dùng gồm email, mật khẩu, verifycode với
          Vai trò mặc định là 'Khach Hang' xuống bảng NguoiDung.
    */
    //Tạo random Mã xác minh
    public String generateVerifiyCode()throws SQLException{
        DecimalFormat df = new DecimalFormat("000000");
        Random ran = new Random();
        String code = df.format(ran.nextInt(1000000));  //  Random from 0 to 999999
        while (checkDuplicateCode(code)) {
            code = df.format(ran.nextInt(1000000));
        }
        return code;
    }
    public void insertUser (ModelNguoiDung user ) throws SQLException {
        //Lấy ID của User tiếp theo 
        PreparedStatement ps1 = connection.prepareStatement("SELECT MAX(UserID) as UserID FROM NguoiDung");
        ResultSet r = ps1.executeQuery();
        r.next();
        int userID = r.getInt("UserID")+1;
        
          //Thêm Ngưgời Dùng
        String sql_ND  = "INSERT INTO NguoiDung (UserID ,Email, MatKhau, VerifyCode,Vaitro) VALUES (?,?, ?, ?,'Khach Hang')";
        PreparedStatement ps = connection.prepareStatement(sql_ND);
        String code=generateVerifiyCode();
        ps.setInt(1, userID);
        ps.setString(2, user.getEmail());
        ps.setString(3, user.getPassword());
        ps.setString(4, code);
        ps.execute();
        
        r.close();
        ps.close();
        ps1.close();
        
        user.setUserID(userID);
        user.setVerifyCode(code);
        user.setRole("Khách Hàng");
    }
    //Kiểm tra Mã trùng 
    private boolean checkDuplicateCode(String code) throws SQLException{
        boolean duplicate=false;
        String sql="SELECT * FROM NguoiDung WHERE VerifyCode=?  LIMIT 1";
        PreparedStatement p = connection.prepareStatement(sql);
        p.setString(1, code);
        ResultSet r=p.executeQuery();
        if(r.next()){
            duplicate=true;
        }
        r.close();
        p.close();
        return duplicate;
    }
    /*
        Sau khi Hoàn tất xác minh tài khoản:
        1.Cập nhật VerifyCode= '' và Trangthai của Người dùng thành Verified
        2. Thêm mới một khách hàng vào bảng KhachHang với các thông tin:
        - Tên KH : lấy từ phần đăng ký
        - Ngày tham gia: ngày hiện tại đăng ký
        - Doanh số, điểm tích lũy mặc định là 0
        - UserID lấy từ Người dùng vừa tạo
       
    */
    public void doneVerify(int userID,String name) throws SQLException{
        //Cập nhật NguoiDung
        String sql_ND="UPDATE nguoidung SET VerifyCode='', Trangthai='Verified' WHERE UserID=?";
        PreparedStatement p1 = connection.prepareStatement(sql_ND);
        p1.setInt(1, userID);
        p1.execute();
        //Lấy id của Khách Hàng tiếp theo
        int id=0;
        String sql_ID="SELECT MAX(MaKH) as ID FROM khachhang";
        PreparedStatement p_id = connection.prepareStatement(sql_ID);
        ResultSet r=p_id.executeQuery();
        if(r.next()){
            id=r.getInt("ID")+1;
        }
        
        //Thêm KH mới
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd-MM-YYYY");
        String sql_KH="INSERT INTO KhachHang (ID_KH,TenKH, NgayThamGia,ID_ND) VALUES (?,?,to_date(?, 'dd-mm-yyyy'),?)";
        PreparedStatement p2=connection.prepareStatement(sql_KH);
        p2.setInt(1, id);
        p2.setString(2, name);
        p2.setString(3, simpleDateFormat.format(new Date()));
        p2.setInt(4, userID);
        p2.execute();
        
        p1.close();
        p_id.close();
        p2.close();
    }
    
    /* 
       Kiểm trả Verify Code của người dùng nhập vào  
       Verify Code của người dùng đó được lưu 
       Trả về : True <- Nếu Mã xác minh đúng
                False <- Nếu nhập sai
    */
    public boolean verifyCodeWithUser(int userID,String code) throws SQLException{
        boolean verify=false;
        String sql="SELECT COUNT(UserID) as CountID FROM nguoidung WHERE UserID=? AND VerifyCode=?";
        PreparedStatement p = connection.prepareStatement(sql);
        p.setInt(1, userID);
        p.setString(2,code);
        ResultSet r = p.executeQuery();
        if(r.next()){
            if(r.getInt("CountID")>0){
                verify=true;
            }
        }
        r.close();
        p.close();
        return verify;
    }
    //Thay đổi mật khẩu tài khoản
    public void changePassword(int userID,String newPass) throws SQLException{
        String sql="UPDATE nguoidung SET MatKhau = ? WHERE UserID = ?";
        PreparedStatement p=connection.prepareStatement(sql);
        p.setString(1, newPass);
        p.setInt(2, userID);
        p.execute();
        p.close();
    }
}
