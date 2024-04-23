
package javamodel;


public class ModelDatBan {
    private int MaDatBan ;
    private String GioBatDau ;
    private String GioKetThuc ;
    private int SoBan ;
    private int MaKH ;

    public ModelDatBan() {
    }

    public ModelDatBan(int MaDatBan, String GioBatDau, String GioKetThuc, int SoBan, int MaKH) {
        this.MaDatBan = MaDatBan;
        this.GioBatDau = GioBatDau;
        this.GioKetThuc = GioKetThuc;
        this.SoBan = SoBan;
        this.MaKH = MaKH;
    }

    public int getMaDatBan() {
        return MaDatBan;
    }

    public void setMaDatBan(int MaDatBan) {
        this.MaDatBan = MaDatBan;
    }

    public String getGioBatDau() {
        return GioBatDau;
    }

    public void setGioBatDau(String GioBatDau) {
        this.GioBatDau = GioBatDau;
    }

    public String getGioKetThuc() {
        return GioKetThuc;
    }

    public void setGioKetThuc(String GioKetThuc) {
        this.GioKetThuc = GioKetThuc;
    }

    public int getSoBan() {
        return SoBan;
    }

    public void setSoBan(int SoBan) {
        this.SoBan = SoBan;
    }

    public int getMaKH() {
        return MaKH;
    }

    public void setMaKH(int MaKH) {
        this.MaKH = MaKH;
    }
    
    
}
