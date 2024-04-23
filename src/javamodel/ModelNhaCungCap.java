
package javamodel;


public class ModelNhaCungCap {
    private int MaNCC ;
    private String tenNCC ;
    private String DiaChi ;
    private String thoiGianHopTac; 

    public ModelNhaCungCap() {
    }

    public ModelNhaCungCap(int MaNCC, String tenNCC, String DiaChi, String thoiGianHopTac) {
        this.MaNCC = MaNCC;
        this.tenNCC = tenNCC;
        this.DiaChi = DiaChi;
        this.thoiGianHopTac = thoiGianHopTac;
    }

    public int getMaNCC() {
        return MaNCC;
    }

    public void setMaNCC(int MaNCC) {
        this.MaNCC = MaNCC;
    }

    public String getTenNCC() {
        return tenNCC;
    }

    public void setTenNCC(String tenNCC) {
        this.tenNCC = tenNCC;
    }

    public String getDiaChi() {
        return DiaChi;
    }

    public void setDiaChi(String DiaChi) {
        this.DiaChi = DiaChi;
    }

    public String getThoiGianHopTac() {
        return thoiGianHopTac;
    }

    public void setThoiGianHopTac(String thoiGianHopTac) {
        this.thoiGianHopTac = thoiGianHopTac;
    }
    
    
}
