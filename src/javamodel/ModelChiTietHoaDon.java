
package javamodel;


public class ModelChiTietHoaDon {
    private int MaHD ;
    private int MaSP ;
    private int SoLuong ;

    public ModelChiTietHoaDon() {
    }

    public ModelChiTietHoaDon(int MaHD, int MaSP, int SoLuong) {
        this.MaHD = MaHD;
        this.MaSP = MaSP;
        this.SoLuong = SoLuong;
    }

    public int getMaHD() {
        return MaHD;
    }

    public void setMaHD(int MaHD) {
        this.MaHD = MaHD;
    }

    public int getMaSP() {
        return MaSP;
    }

    public void setMaSP(int MaSP) {
        this.MaSP = MaSP;
    }

    public int getSoLuong() {
        return SoLuong;
    }

    public void setSoLuong(int SoLuong) {
        this.SoLuong = SoLuong;
    }
    
    
}
