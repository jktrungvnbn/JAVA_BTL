
package javamodel;


public class ModelHoaDon {
    private int MaHD ;
    private int MaKH ;
    private int SoBan;
    private String NgayLapHD ;
    private String Code_Voucher;
    private String trangThai;

    public ModelHoaDon() {
    }

    public ModelHoaDon(int MaHD, int MaKH, int SoBan, String NgayLapHD, String Code_Voucher, String trangThai) {
        this.MaHD = MaHD;
        this.MaKH = MaKH;
        this.SoBan = SoBan;
        this.NgayLapHD = NgayLapHD;
        this.Code_Voucher = Code_Voucher;
        this.trangThai = trangThai;
    }

    public int getMaHD() {
        return MaHD;
    }

    public void setMaHD(int MaHD) {
        this.MaHD = MaHD;
    }

    public int getMaKH() {
        return MaKH;
    }

    public void setMaKH(int MaKH) {
        this.MaKH = MaKH;
    }

    public int getSoBan() {
        return SoBan;
    }

    public void setSoBan(int SoBan) {
        this.SoBan = SoBan;
    }

    public String getNgayLapHD() {
        return NgayLapHD;
    }

    public void setNgayLapHD(String NgayLapHD) {
        this.NgayLapHD = NgayLapHD;
    }

    public String getCode_Voucher() {
        return Code_Voucher;
    }

    public void setCode_Voucher(String Code_Voucher) {
        this.Code_Voucher = Code_Voucher;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }
    
    
}
