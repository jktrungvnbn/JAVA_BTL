
package javamodel;


public class ModelNhanVien {
    private int MaNV;
    private String tenNV;
    private String ngayVaoLam;
    private String SDT;
    private String chucVu;
    private int userID ;

    public ModelNhanVien() {
    }

    public ModelNhanVien(int MaNV, String tenNV, String ngayVaoLam, String SDT, String chucVu, int userID) {
        this.MaNV = MaNV;
        this.tenNV = tenNV;
        this.ngayVaoLam = ngayVaoLam;
        this.SDT = SDT;
        this.chucVu = chucVu;
        this.userID = userID;
    }

    public int getMaNV() {
        return MaNV;
    }

    public void setMaNV(int MaNV) {
        this.MaNV = MaNV;
    }

    public String getTenNV() {
        return tenNV;
    }

    public void setTenNV(String tenNV) {
        this.tenNV = tenNV;
    }

    public String getNgayVaoLam() {
        return ngayVaoLam;
    }

    public void setNgayVaoLam(String ngayVaoLam) {
        this.ngayVaoLam = ngayVaoLam;
    }

    public String getSDT() {
        return SDT;
    }

    public void setSDT(String SDT) {
        this.SDT = SDT;
    }

    public String getChucVu() {
        return chucVu;
    }

    public void setChucVu(String chucVu) {
        this.chucVu = chucVu;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }
    
    
}
