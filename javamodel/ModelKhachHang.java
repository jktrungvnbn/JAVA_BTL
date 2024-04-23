
package javamodel;


public class ModelKhachHang {
      private int MaKH ;
      private String tenKH ;
      private String ngayThamGia ;
      private int doanhSo ;
      private int userID ;
      private String loaiKhachHang ;

    public ModelKhachHang() {
    }

    public ModelKhachHang(int MaKH, String tenKH, String ngayThamGia, int doanhSo, int userID, String loaiKhachHang) {
        this.MaKH = MaKH;
        this.tenKH = tenKH;
        this.ngayThamGia = ngayThamGia;
        this.doanhSo = doanhSo;
        this.userID = userID;
        this.loaiKhachHang = loaiKhachHang;
    }

    public int getMaKH() {
        return MaKH;
    }

    public void setMaKH(int MaKH) {
        this.MaKH = MaKH;
    }

    public String getTenKH() {
        return tenKH;
    }

    public void setTenKH(String tenKH) {
        this.tenKH = tenKH;
    }

    public String getNgayThamGia() {
        return ngayThamGia;
    }

    public void setNgayThamGia(String ngayThamGia) {
        this.ngayThamGia = ngayThamGia;
    }

    public int getDoanhSo() {
        return doanhSo;
    }

    public void setDoanhSo(int doanhSo) {
        this.doanhSo = doanhSo;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getLoaiKhachHang() {
        return loaiKhachHang;
    }

    public void setLoaiKhachHang(String loaiKhachHang) {
        this.loaiKhachHang = loaiKhachHang;
    }
      
      
}
