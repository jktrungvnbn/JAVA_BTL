
package javamodel;


public class ModelBan {
    private int SoBan ;
    private String ViTri ;
    private String trangThai ;

    public ModelBan() {
    }

    public ModelBan(int SoBan, String ViTri, String trangThai) {
        this.SoBan = SoBan;
        this.ViTri = ViTri;
        this.trangThai = trangThai;
    }

    public int getSoBan() {
        return SoBan;
    }

    public void setSoBan(int SoBan) {
        this.SoBan = SoBan;
    }

    public String getViTri() {
        return ViTri;
    }

    public void setViTri(String ViTri) {
        this.ViTri = ViTri;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }
    
    
}
