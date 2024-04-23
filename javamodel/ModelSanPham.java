
package javamodel;


public class ModelSanPham {
    private int MaSP ;
    private String tenSP ;
    private double Gia ; 
    private int MaNCC ;
    private String trangThai ;

    public ModelSanPham() {
    }

    public ModelSanPham(int MaSP, String tenSP, double Gia, int MaNCC, String trangThai) {
        this.MaSP = MaSP;
        this.tenSP = tenSP;
        this.Gia = Gia;
        this.MaNCC = MaNCC;
        this.trangThai = trangThai;
    }

    public int getMaSP() {
        return MaSP;
    }

    public void setMaSP(int MaSP) {
        this.MaSP = MaSP;
    }

    public String getTenSP() {
        return tenSP;
    }

    public void setTenSP(String tenSP) {
        this.tenSP = tenSP;
    }

    public double getGia() {
        return Gia;
    }

    public void setGia(double Gia) {
        this.Gia = Gia;
    }

    public int getMaNCC() {
        return MaNCC;
    }

    public void setMaNCC(int MaNCC) {
        this.MaNCC = MaNCC;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }
    
    
}
