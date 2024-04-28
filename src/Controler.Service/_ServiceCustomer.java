/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package BiA.Controller;

import BiA.Controller.Connection.DatabaseConnection;
import BiA.javamodel.ModelBan;
import BiA.javamodel.ModelChiTietHoaDon;
import BiA.javamodel.ModelHoaDon;
import BiA.javamodel.ModelKhachHang;
import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import BiA.javamodel.ModelSanPham;
import java.util.Date;
import BiA.javamodel.ModelVoucher;
import java.text.SimpleDateFormat;



/**
 *
 * @author Nguyen Quoc Trung
 */
public class _ServiceCustomer {
    private final Connection connection ;
    
    //Connect tới DataBase       
    public _ServiceCustomer() {
        connection = DatabaseConnection.getInstance().getConnection();
    }
    
    
   
    /**
     *
     * @param userID
     * @return
     * @throws SQLException
     */
    //Lấy thông tin khách hàng từ ID người dùng
    public ModelKhachHang getCustomer(int userID) throws SQLException {
        ModelKhachHang data = null;
        String sql = "SELECT ID_KH, TenKH, to_char(Ngaythamgia, 'dd-mm-yyyy') AS NgayTG, Doanhso,Diemtichluy FROM KhachHang WHERE ID_ND=?";
        PreparedStatement p = connection.prepareStatement(sql);
        p.setInt(1, userID);
        ResultSet r = p.executeQuery();
        while (r.next()) {

            int id = r.getInt("ID_KH");
            String name = r.getString("TenKH");
            Date date = r.getDate("NgayTG");
            int sales = r.getInt("Doanhso");
            int points = r.getInt("Diemtichluy");
            data = new ModelKhachHang(id, name, (java.sql.Date) date, sales, points , userID);
        }
        r.close();
        p.close();
        return data;
    }

    // Đổi tên Khách hàng 
    public void reNameCustomer(ModelKhachHang data) throws SQLException {
        String sql = "UPDATE khachhang SET TenKH=? WHERE MaKH=?";
        PreparedStatement p = connection.prepareStatement(sql);
        p.setString(1, data.getTenKH());
        p.setInt(2, data.getMaKH());
        p.execute();
        p.close();
    }
    
    //Lấy toàn bộ danh sách sản phẩm theo loại Món Ăn đang kinh doanh
    public ArrayList<ModelSanPham> MenuFood(String type) throws SQLException{
        ArrayList<ModelSanPham> list = new ArrayList<>();
        String sql = "SELECT MaSP,TenSP,Gia FROM sanpham WHERE TrangThai= true";
        PreparedStatement p = connection.prepareStatement(sql);
        p.setString(1, type);
        ResultSet r = p.executeQuery();
        while (r.next()){
            int id = r.getInt("ID_MonAn");
            String name = r.getString("TenMon");
            int value = r.getInt("DonGia");
            ModelSanPham data ;
            data = new ModelSanPham(id, name, value, true);
            list.add(data);
        }
        r.close();
        p.close();
        return list;
    }
    
    //Lấy toàn bộ danh sách bàn theo tầng
    public ArrayList<ModelBan> MenuTable(String floor) throws SQLException {
        ArrayList<ModelBan> list = new ArrayList<>();
        String sql = "SELECT ID_Ban,TenBan,Trangthai FROM ban WHERE Vitri= ?";
        PreparedStatement p = connection.prepareStatement(sql);
        p.setString(1, floor);
        ResultSet r = p.executeQuery();
        while (r.next()) {
            int id = r.getInt("ID_Ban");
            String name = r.getString("TenBan");
            boolean status = r.getBoolean("Trangthai");
            ModelBan data = new ModelBan(id, name, status);
            list.add(data);
        }
        r.close();
        p.close();
        return list;
    }
    
    //Lấy danh sách bàn theo trạng thái bàn Còn trống/Đã đặt trước

    public ArrayList<ModelBan> MenuTableState(String floor, boolean state) throws SQLException {
        ArrayList<ModelBan> list = new ArrayList<>();
        String sql = "SELECT SoBan,Trangthai FROM Ban WHERE Vitri=?";
        if (state){
            sql += " AND Trangthai='true'";
        } else  {
            sql += " AND Trangthai='false'";
        }
        PreparedStatement p = connection.prepareStatement(sql);
        p.setString(1, floor);
        ResultSet r = p.executeQuery();
        // Lặp qua kết quả truy vấn và thêm vào danh sách kết quả
        while (r.next()) {
            int id = r.getInt("SoBan");
            boolean status = r.getBoolean("Trangthai");
            ModelBan data = new ModelBan(id, floor, status);
            list.add(data);
        }
        r.close();
        p.close();
        return list;
    }
    
    //Lấy toàn bộ danh sách Voucher
    public ArrayList<ModelVoucher> MenuVoucher() throws SQLException {
        ArrayList<ModelVoucher> list = new ArrayList<>();
        String sql = "SELECT * FROM Voucher";
        PreparedStatement p = connection.prepareStatement(sql);
        ResultSet r = p.executeQuery();
        while (r.next()) {
            String code = r.getString("Code_Voucher");
            String desc = r.getString("Mota");
            int percent = r.getInt("Phantram");
            int quantity = r.getInt("SoLuong");
            int point = r.getInt("Diem");
            ModelVoucher data = new ModelVoucher(code, desc, percent, quantity, point);
            list.add(data);
        }
        r.close();
        p.close();
        return list;
    }
    
    /*
        Khi khách hàng đặt bàn thì tự động thêm mới một hóa đơn với ID_Ban và ID_KH từ tham số 
        Tiền món ăn và Tiền giảm mặc định là 0
        Trạng thái Hóa đơn mặc định là Chưa thanh toán
     */
    public void InsertHoaDon(ModelBan table, ModelKhachHang customer) throws SQLException {
        //Tìm ID_HD tiếp theo
        int idHD=0;
        PreparedStatement p_ID = connection.prepareStatement("SELECT MAX(MaHD) +1 FROM hoadon");
        ResultSet r_id = p_ID.executeQuery();
        if(r_id.next()){
            idHD=r_id.getInt(1);
        }
       
        //Thêm Hoá Đơn mới
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd-MM-YYYY");
        String sql = "INSERT INTO HoaDon(MaHD,MaKH,SoBan,NgayLapHD,Code_Voucher,Trangthai)"
                + " VALUES (?,?,?,to_date(?, 'dd-mm-yyyy'),0,'Chua thanh toan')";
        PreparedStatement p = connection.prepareStatement(sql);
        p.setInt(1, idHD);
        p.setInt(2, customer.getMaKH());
        p.setInt(3, table.getSoBan());
        p.setString(4, simpleDateFormat.format(new Date()));
        p_ID.close();
        r_id.close();
        p.execute();
        p.close();

    }
    //Lấy thông tin HoaDon mà Khách hàng vừa đặt, Hóa Đơn có trạng thái 'Chưa thanh toán'
    public ModelHoaDon FindHoaDon(ModelKhachHang customer) throws SQLException {
        ModelHoaDon hoadon = null;
        String sql = "SELECT ID_HoaDon,ID_KH,ID_Ban,to_char(NgayHD,'dd-mm-yyyy') AS Ngay,TienMonAn,Code_Voucher,TienGiam,Tongtien,Trangthai FROM HoaDon "
                + "WHERE ID_KH=? AND Trangthai='Chua thanh toan'";
        PreparedStatement p = connection.prepareStatement(sql);
        p.setInt(1, customer.getMaKH());
        ResultSet r = p.executeQuery();
        while (r.next()) {
            int idHoaDon = r.getInt(1);
            int idKH = r.getInt(2);
            int idBan = r.getInt(3);
            Date ngayHD = r.getDate(4);
            int tienMonAn = r.getInt(5);
            String code_voucher = r.getString(6);
            int tienGiam = r.getInt(7);
            int tongtien = r.getInt(8);
            boolean trangthai = r.getBoolean(9);
            hoadon = new ModelHoaDon(idHoaDon, (java.sql.Date) ngayHD, code_voucher, trangthai , idKH, idBan);
        }
        r.close();
        p.close();
        return hoadon;
    }
    
    //Thêm món ăn mới khách hàng vừa đặt vào CTHD
    public void InsertCTHD(int ID_HoaDon, int ID_MonAn, int soluong) throws SQLException {
        //Kiểm tra món ăn đã có trong CTHD hay chưa, nếu đã có cập nhật số lượng, nếu chưa thì thêm CTHD mới
        String sql = "SELECT 1 FROM CTHD WHERE ID_HoaDon=? AND ID_MonAn=?";
        PreparedStatement p = connection.prepareStatement(sql);
        p.setInt(1, ID_HoaDon);
        p.setInt(2, ID_MonAn);
        ResultSet r = p.executeQuery();
        if (r.next()) {
            // Nếu tồn tại 
            String sql_update = "UPDATE CTHD SET SoLuong=SoLuong+? WHERE ID_HoaDon=? AND ID_MonAn=?";
            PreparedStatement p1 = connection.prepareStatement(sql_update);
            p1.setInt(1, soluong);
            p1.setInt(2, ID_HoaDon);
            p1.setInt(3, ID_MonAn);
            p1.execute();
            p1.close();
        } else {
            //Nếu không tồn tại
            String sql_insert = "INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (?,?,?)";
            PreparedStatement p1 = connection.prepareStatement(sql_insert);
            p1.setInt(1, ID_HoaDon);
            p1.setInt(2, ID_MonAn);
            p1.setInt(3, soluong);
            p1.execute();
            p1.close();
        }
        p.close();
        r.close();
    }
    
    // Lấy danh sách CTHD từ ID_HoaDon
    public ArrayList<ModelChiTietHoaDon> getCTHD(int ID_HoaDon) throws SQLException {
        ArrayList<ModelChiTietHoaDon> list = new ArrayList<>();
        String sql = "SELECT * FROM ChiTietHD "
                + "JOIN sanpham ON sanpham.MaSP = ChiTietHD.MaSp WHERE IDHD =?";
        PreparedStatement p = connection.prepareStatement(sql);
        p.setInt(1, ID_HoaDon);
        ResultSet r = p.executeQuery();
        while (r.next()) {
            int IDHD = r.getInt(1);
            int MaSP = r.getInt(2);
            int SoLuong = r.getInt(3);
           
            ModelChiTietHoaDon data = new ModelChiTietHoaDon(IDHD , MaSP , SoLuong);
            list.add(data);
        }
        r.close();
        p.close();
        return list;
    }
    //Lấy toàn bộ danh sách hóa đơn của một khách hàng
    public ArrayList<ModelHoaDon> getListHD(int ID_KH) throws SQLException {
        ArrayList<ModelHoaDon> list = new ArrayList<>();
        String sql = "SELECT ID_HoaDon,ID_KH,ID_Ban,to_char(NgayHD,'dd-mm-yyyy') AS Ngay,TienMonAn,Code_Voucher,TienGiam,Tongtien,Trangthai FROM HoaDon "
                + "WHERE ID_KH=? ORDER BY ID_HoaDon";
        PreparedStatement p = connection.prepareStatement(sql);
        p.setInt(1, ID_KH);
        ResultSet r = p.executeQuery();
        while (r.next()) {
            int idHoaDon = r.getInt(1);
            int idKH = r.getInt(2);
            int idBan = r.getInt(3);
            Date ngayHD = r.getDate(4);
            String code_voucher = r.getString(6);
            boolean trangthai = r.getBoolean(9);
            ModelHoaDon hoadon = new ModelHoaDon(idHoaDon,(java.sql.Date) ngayHD, code_voucher,  trangthai , idKH, idBan);
            list.add(hoadon);
        }
        r.close();
        p.close();
        return list;
    }
    // chưa sửa 
    //Lấy toàn bộ danh sách hóa đơn của một khách hàng theo mốc Tổng tiền Hóa Đơn
    public ArrayList<ModelHoaDon> getListHDOrder(int ID_KH, String order) throws SQLException {
        ArrayList<ModelHoaDon> list = new ArrayList<>();
        String sql = "SELECT ID_HoaDon,ID_KH,ID_Ban,to_char(NgayHD,'dd-mm-yyyy') AS Ngay,TienMonAn,Code_Voucher,TienGiam,Tongtien,Trangthai FROM HoaDon "
                + "WHERE ID_KH=? ORDER BY ID_HoaDon";
        switch (order) {
            case "Tất cả":
                sql = "SELECT ID_HoaDon,ID_KH,ID_Ban,to_char(NgayHD,'dd-mm-yyyy') AS Ngay,TienMonAn,Code_Voucher,TienGiam,Tongtien,Trangthai FROM HoaDon "
                        + "WHERE ID_KH=? ORDER BY ID_HoaDon";
                break;
            case "Dưới 1.000.000đ":
                sql = "SELECT ID_HoaDon,ID_KH,ID_Ban,to_char(NgayHD,'dd-mm-yyyy') AS Ngay,TienMonAn,Code_Voucher,TienGiam,Tongtien,Trangthai FROM HoaDon "
                        + "WHERE ID_KH=? AND Tongtien <1000000 ORDER BY ID_HoaDon";
                break;
            case "Từ 1 đến 5.000.000đ":
                sql = "SELECT ID_HoaDon,ID_KH,ID_Ban,to_char(NgayHD,'dd-mm-yyyy') AS Ngay,TienMonAn,Code_Voucher,TienGiam,Tongtien,Trangthai FROM HoaDon "
                        + "WHERE ID_KH=? AND Tongtien BETWEEN 1000000 AND 5000001 ORDER BY ID_HoaDon";
                break;
            case "Trên 5.000.000đ":
                sql = "SELECT ID_HoaDon,ID_KH,ID_Ban,to_char(NgayHD,'dd-mm-yyyy') AS Ngay,TienMonAn,Code_Voucher,TienGiam,Tongtien,Trangthai FROM HoaDon "
                        + "WHERE ID_KH=? AND Tongtien >5000000 ORDER BY ID_HoaDon";
                break;
            default:
                break;
        }
        PreparedStatement p = connection.prepareStatement(sql);
        p.setInt(1, ID_KH);
        ResultSet r = p.executeQuery();
        while (r.next()) {
            int idHoaDon = r.getInt(1);
            int idKH = r.getInt(2);
            int idBan = r.getInt(3);
            String ngayHD = r.getString(4);
            int tienMonAn = r.getInt(5);
            String code_voucher = r.getString(6);
            int tienGiam = r.getInt(7);
            int tongtien = r.getInt(8);
            String trangthai = r.getString(9);
            //ModelHoaDon hoadon = new ModelHoaDon(idHoaDon, idKH, idBan, ngayHD, tienMonAn, code_voucher, tienGiam, tongtien, trangthai);
            //list.add(hoadon);
        }
        r.close();
        p.close();
        return list;
    }
    
     //Sau khi khách hàng đổi Voucher ở phần Điểm tích lũy, áp dụng trực tiếp lên hóa đơn mà khách hàng đang sử dụng
    //Thực hiện Trigger giảm Điểm tích lũy của Khách hàng và tính Tiền Giảm giá
    public void exchangeVoucher(int ID_HoaDon, String Code_Voucher) throws SQLException {
        String sql = "UPDATE HoaDon SET Code_Voucher=? WHERE ID_HoaDon=?";
        PreparedStatement p = connection.prepareStatement(sql);
        p.setString(1, Code_Voucher);
        p.setInt(2, ID_HoaDon);
        p.execute();
        p.close();
    }
}
