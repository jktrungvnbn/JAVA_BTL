
use BIAVIP ;

-- DROP table NguoiDung;
-- --  Tao bang NguoiDung
create table NguoiDung(
    ID_ND INT,
    Email varchar(50),
    Matkhau varchar(20),
    VerifyCode varchar(10) DEFAULT NULL,
    Trangthai varchar(10) DEFAULT '',
    Vaitro varchar(20)
);
-- --  Them rang buoc
alter table NguoiDung
    add constraint ND_Email_NNULL check ('Email' is not null),
    add constraint ND_Matkhau_NNULL check ('Matkhau' is not null),
    add constraint ND_Vaitro_Ten check (Vaitro in ('Khach Hang','Nhan Vien','Nhan Vien Kho','Quan Ly'));

-- --  Them khoa chinh
alter table NguoiDung
    add constraint NguoiDung_PK PRIMARY KEY (ID_ND);
    
-- Tao bang NhanVien
--  drop table NhanVien;
create table NhanVien(
    ID_NV INT,
    TenNV VARCHAR(50),
    NgayVL DATE ,
    SDT VARCHAR(50),
    Chucvu VARCHAR(50),
    ID_ND INT DEFAULT NULL,
    ID_NQL INT,
    Tinhtrang VARCHAR(20)
);
-- --  Them rang buoc cho bang NhanVien
-- --  Them Check Constraint
alter table NhanVien
    add constraint NV_TenNV_NNULL check ('TenNV' is not null),
    add constraint NV_SDT_NNULL check ('SDT' is not null),
    add constraint NV_NgayVL_NNULL check ('NgayVL' is not null),
    add constraint NV_Chucvu_Thuoc check (Chucvu IN ('Phuc vu','Tiep tan','Thu ngan','Bep','Kho','Quan ly')),
    add constraint NV_Tinhtrang_Thuoc check (Tinhtrang IN ('Dang lam viec','Da nghi viec'));

-- --  Them khoa chinh
alter table NhanVien
    add constraint NV_PK PRIMARY KEY (ID_NV);

-- --  Them khoa ngoai
ALTER TABLE NhanVien
 ADD CONSTRAINT NV_fk_idND FOREIGN KEY 
 (ID_ND) REFERENCES NguoiDung(ID_ND),
 ADD CONSTRAINT NV_fk_idNQL FOREIGN KEY
 (ID_NQL) REFERENCES NhanVien(ID_NV);
 

-- --  Tao bang KhachHang
-- --  drop table KhachHang;
create table KhachHang(
    ID_KH INT,
    TenKH VARCHAR(50), 
    Ngaythamgia date, 
    Doanhso INT , 
    Diemtichluy INT,
    ID_ND INT
);
-- --  Them Check Constraint
alter table KhachHang
    add constraint KH_TenKH_NNULL check ('TenKH' is not null),
    add constraint KH_Ngaythamgia_NNULL check ('Ngaythamgia' is not null),
    add constraint KH_Doanhthu_NNULL check ('Doanhthu' is not null),
    add constraint KH_Diemtichluy_NNULL check ('Diemtichluy' is not null),
    add constraint KH_IDND_NNULL check ('ID_ND' is not null);

-- --  -- Them khoa chinh
alter table KhachHang
    add constraint KhachHang_PK PRIMARY KEY (ID_KH);
    
-- --  -- Them khoa ngoai
ALTER TABLE KhachHang
 ADD CONSTRAINT KH_fk_idND FOREIGN KEY 
 (ID_ND) REFERENCES NguoiDung(ID_ND);

-- --  Tao bang MonAn
-- --  drop table MonAn;
create table MonAn(
    ID_MonAn INT,
    TenMon VARCHAR(50), 
    DonGia INT,
    Loai VARCHAR(50),
    TrangThai VARCHAR(30)
);
-- --  Them Check Constraint
alter table MonAn
    add constraint MA_TenMon_NNULL check ('TenMon' is not null),
    add constraint MA_DonGia_NNULL check ('Dongia' is not null),
    add constraint MA_Loai_Ten check (Loai in ('Aries','Taurus','Gemini','Cancer','Leo','Virgo'
                                                 ,'Libra','Scorpio','Sagittarius','Capricorn','Aquarius','Pisces')),
    add constraint MA_TrangThai_Thuoc check (TrangThai in('Dang kinh doanh','Ngung kinh doanh'));                                             

-- --  Them khoa chinh
alter table MonAn
    add constraint MonAn_PK PRIMARY KEY (ID_MonAn);


-- --  Tao bang Ban
-- --  drop table Ban;
create table Ban(
    ID_Ban INT,
    TenBan VARCHAR(50), 
    Vitri VARCHAR(50), 
    Trangthai VARCHAR(50)
);
-- --  Them Check Constraint
alter table Ban
    add constraint Ban_TenBan_NNULL check ('TenBan' is not null),
    add constraint Ban_Vitri_NNULL check ('Vitri' is not null),
    add constraint Ban_Trangthai_Ten check (Trangthai in ('Con trong','Dang dung bua','Da dat truoc'));


-- --  Them khoa chinh
alter table Ban
    add constraint Ban_PK PRIMARY KEY (ID_Ban);


-- --  Tao bang Voucher

-- --  Tao bang Voucher
-- --  drop table Voucher;

create table Voucher(
    Code_Voucher VARCHAR(10),
    Mota VARCHAR(50),
    Phantram INT,
    LoaiMA VARCHAR(50),
    SoLuong INT,
    Diem INT
);
-- --  Them Check Constraint
alter table Voucher
    add constraint V_Code_NNULL check ('Code_Voucher' is not null),
    add constraint V_Mota_NNULL check ('Mota' is not null),
    add constraint V_Phantram_NNULL check (Phantram > 0 AND Phantram <= 100),
    add constraint V_LoaiMA_Thuoc check (LoaiMA in ('All','Aries','Taurus','Gemini','Cancer','Leo','Virgo'
                                                 ,'Libra','Scorpio','Sagittarius','Capricorn','Aquarius','Pisces'));

-- --  -- Them khoa chinh
alter table Voucher
    add constraint Voucher_PK PRIMARY KEY (Code_Voucher);
    
-- --  Tao bang HoaDon
-- --  drop table HoaDon;

create table HoaDon(
    ID_HoaDon INT,
    ID_KH INT,
    ID_Ban INT,
    NgayHD date,
    TienMonAn INT,
    Code_Voucher VARCHAR(10),
    TienGiam INT,
    Tongtien INT,
    Trangthai VARCHAR(50)
);

-- --  Them Check Constraint
alter table HoaDon
    add constraint HD_NgayHD_NNULL check ('TenMon' is not null),
    add constraint HD_TrangThai check (Trangthai in ('Chua thanh toan','Da thanh toan'));

-- --  Them khoa chinh
alter table HoaDon
    add constraint HD_PK PRIMARY KEY (ID_HoaDon);

ALTER TABLE HoaDon
 ADD CONSTRAINT HD_fk_idKH FOREIGN KEY 
 (ID_KH) REFERENCES KhachHang(ID_KH),
 ADD CONSTRAINT HD_fk_idBan FOREIGN KEY 
 (ID_Ban) REFERENCES Ban(ID_Ban);
 

-- --  Tao bang CTHD
-- --  drop table CTHD;
create table CTHD(
    ID_HoaDon INT,
    ID_MonAn INT,
    SoLuong INT,
    Thanhtien INT
);

-- --  Them Check Constraint
alter table CTHD
    add constraint CTHD_SoLuong_NNULL check ('SoLuong' is not null);

-- --  Them khoa chinh
alter table CTHD
    add constraint CTHD_PK PRIMARY KEY (ID_HoaDon,ID_MonAn);

ALTER TABLE CTHD
 ADD CONSTRAINT CTHD_fk_idHD FOREIGN KEY 
 (ID_HoaDon) REFERENCES HoaDon(ID_HoaDon),
 ADD CONSTRAINT CTHD_fk_idMonAn FOREIGN KEY 
 (ID_MonAn) REFERENCES MonAn(ID_MonAn);

 
-- --  Tao bang Nguyenlieu
-- --  drop table NguyenLieu;
create table NguyenLieu(
    ID_NL INT,
    TenNL VARCHAR(50), 
    Dongia INT, 
    Donvitinh VARCHAR(50)
);
-- --  Them Check Constraint
alter table NguyenLieu
    add constraint NL_TenNL_NNULL check ('TenNL' is not null),
    add constraint NL_Dongia_NNULL check ('Dongia' is not null),
    add constraint NL_DVT_Thuoc check (Donvitinh in ('g','kg','ml','l'));

-- --  Them khoa chinh
alter table NguyenLieu
    add constraint NL_PK PRIMARY KEY (ID_NL);

-- --  Tao bang Kho
-- --  drop table Kho;
create table Kho(
    ID_NL INT,
    SLTon INT
);
-- --  Them Check Constraint


-- --  Them khoa chinh
ALTER TABLE Kho
    ADD CONSTRAINT Kho_pk PRIMARY KEY (ID_NL);

-- --  Them khoa ngoai
ALTER TABLE Kho
 ADD CONSTRAINT Kho_fk_idNL FOREIGN KEY 
 (ID_NL) REFERENCES NguyenLieu(ID_NL);

-- --  Tao bang PhieuNK
-- --  drop table PhieuNK;
create table PhieuNK(
    ID_NK INT,
    ID_NV INT,
    NgayNK date,
    Tongtien INT
);

-- --  Them Check Constraint
alter table PhieuNK
    add constraint PNK_NgayNK_NNULL check ('NgayNK' is not null);

-- --  Them khoa chinh
alter table PhieuNK
    add constraint PNK_PK PRIMARY KEY (ID_NK);

ALTER TABLE PhieuNK
 ADD CONSTRAINT PNK_fk_idNV FOREIGN KEY 
 (ID_NV) REFERENCES NhanVien(ID_NV);


-- --  Them bang CTNK
-- --  drop table CTNK;
create table CTNK(
    ID_NK INT,
    ID_NL INT,
    SoLuong INT,
    Thanhtien INT
);

-- --  Them Check Constraint
alter table CTNK
    add constraint CTNK_SL_NNULL check ('SoLuong' is not null);

-- --  Them khoa chinh
alter table CTNK
    add constraint CTNK_PK PRIMARY KEY (ID_NK,ID_NL);
    
-- --  Them khoa ngoai
ALTER TABLE CTNK
 ADD CONSTRAINT CTNK_fk_idNK FOREIGN KEY 
 (ID_NK) REFERENCES PhieuNK(ID_NK),
 ADD CONSTRAINT CTNK_fk_idNL FOREIGN KEY 
 (ID_NL) REFERENCES NguyenLieu(ID_NL);


-- --  Tao bang PhieuXK
-- --  drop table PhieuXK;
create table PhieuXK(
    ID_XK INT,
    ID_NV INT,
    NgayXK date
);

-- --  Them Check Constraint
alter table PhieuXK
    add constraint PXK_NgayXK_NNULL check ('NgayXK' is not null);

-- --  Them khoa chinh
alter table PhieuXK
    add constraint PXK_PK PRIMARY KEY (ID_XK);

ALTER TABLE PhieuXK
 ADD CONSTRAINT PXK_fk_idNV FOREIGN KEY 
 (ID_NV) REFERENCES NhanVien(ID_NV);


-- --  Them bang CTXK
-- --  drop table CTXK;
create table CTXK(
    ID_XK INT,
    ID_NL INT,
    SoLuong INT
);

-- --  Them Check Constraint
alter table CTXK
    add constraint CTXK_SL_NNULL check ('SoLuong' is not null);

-- --  Them khoa chinh
alter table CTXK
    add constraint CTXK_PK PRIMARY KEY (ID_XK,ID_NL);

-- --  Them khoa ngoai
ALTER TABLE CTXK
 ADD CONSTRAINT CTNK_fk_idXK FOREIGN KEY 
 (ID_XK) REFERENCES PhieuXK(ID_XK),
 ADD CONSTRAINT CTXK_fk_idNL FOREIGN KEY 
 (ID_NL) REFERENCES NguyenLieu(ID_NL);


-- --  --  Tao Trigger

-- --  Khach hang chi duoc co toi da mot hoa don co trang thai Chua thanh toan
DELIMITER //

CREATE TRIGGER Tg_SLHD_CTT
BEFORE INSERT ON HoaDon
FOR EACH ROW
BEGIN
    DECLARE v_count INT;

    -- Tính số lượng hóa đơn chưa thanh toán của khách hàng
    SELECT COUNT(*) INTO v_count
    FROM HoaDon
    WHERE ID_KH = NEW.ID_KH AND TrangThai = 'Chua thanh toan';
    
    -- Nếu số lượng hóa đơn chưa thanh toán lớn hơn 1, ném lỗi
    IF v_count > 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Moi khach hang chi duoc co toi da mot hoa don co trang thai chua thanh toan';
    END IF;
END;
//
DELIMITER ;
DELIMITER //

CREATE TRIGGER Tg_SLHD_CTT_Update
BEFORE UPDATE ON HoaDon
FOR EACH ROW
BEGIN
    DECLARE v_count INT;

    -- Tính số lượng hóa đơn chưa thanh toán của khách hàng sau khi cập nhật
    SELECT COUNT(*) INTO v_count
    FROM HoaDon
    WHERE ID_KH = NEW.ID_KH AND TrangThai = 'Chua thanh toan';
    
    -- Nếu số lượng hóa đơn chưa thanh toán lớn hơn 1, ném lỗi
    IF v_count > 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Moi khach hang chi duoc co toi da mot hoa don co trang thai chua thanh toan';
    END IF;
END;
//

DELIMITER ;


-- --    Trigger Thanh tien o CTHD bang SoLuong x Dongia cua mon an do

DELIMITER //

CREATE TRIGGER Tg_CTHD_Thanhtien_INSERT
BEFORE INSERT ON CTHD
FOR EACH ROW
BEGIN
    DECLARE gia INT;

    -- Lấy giá của món ăn từ bảng MonAn
    SELECT DonGia INTO gia
    FROM MonAn
    WHERE ID_MonAn = NEW.ID_MonAn;

    -- Tính toán thành tiền và gán cho cột Thanhtien trong CTHD
    SET NEW.ThanhTien = NEW.SoLuong * gia;
END;
//

CREATE TRIGGER Tg_CTHD_Thanhtien_UPDATE
BEFORE UPDATE ON CTHD
FOR EACH ROW
BEGIN
    DECLARE gia INT;

    -- Lấy giá của món ăn từ bảng MonAn
    SELECT DonGia INTO gia
    FROM MonAn
    WHERE ID_MonAn = NEW.ID_MonAn;

    -- Tính toán thành tiền và gán cho cột Thanhtien trong CTHD
    SET NEW.ThanhTien = NEW.SoLuong * gia;
END;
//

DELIMITER ;

-- --  --  Trigger Tien mon an o Hoa Don bang tong thanh tien o CTHD
DELIMITER //

CREATE TRIGGER Tg_HD_TienMonAn_AFTER_INSERT
AFTER INSERT ON CTHD
FOR EACH ROW
BEGIN
    UPDATE HoaDon 
    SET TienMonAn = TienMonAn + NEW.ThanhTien
    WHERE ID_HoaDon = NEW.ID_HoaDon;
END;
//

CREATE TRIGGER Tg_HD_TienMonAn_AFTER_UPDATE
AFTER UPDATE ON CTHD
FOR EACH ROW
BEGIN
    UPDATE HoaDon 
    SET TienMonAn = TienMonAn + NEW.ThanhTien - OLD.ThanhTien
    WHERE ID_HoaDon = NEW.ID_HoaDon;
END;
//

CREATE TRIGGER Tg_HD_TienMonAn_AFTER_DELETE
AFTER DELETE ON CTHD
FOR EACH ROW
BEGIN
    UPDATE HoaDon 
    SET TienMonAn = TienMonAn - OLD.ThanhTien
    WHERE ID_HoaDon = OLD.ID_HoaDon;
END;
//

DELIMITER ;



-- --  Trigger Tien giam o Hoa Don = tong thanh tien cua mon An duoc giam  x Phantram
DELIMITER //

CREATE TRIGGER Tg_HD_TienGiam AFTER INSERT ON CTHD
FOR EACH ROW
BEGIN
    DECLARE v_code VARCHAR(255);
    DECLARE v_loaiMA VARCHAR(255);
    DECLARE MA_Loai VARCHAR(255);
    
    SET v_code = NULL;
    
    -- Tìm Code Voucher và Loại món ăn áp dụng từ bảng HoaDon và Voucher
    IF (NEW.ID_HoaDon IS NOT NULL) THEN
        SELECT HoaDon.Code_Voucher, Voucher.LoaiMA 
        INTO v_code, v_loaiMA
        FROM HoaDon
        LEFT JOIN Voucher ON Voucher.Code_Voucher = HoaDon.Code_Voucher
        WHERE HoaDon.ID_HoaDon = NEW.ID_HoaDon;
        
        -- Tìm loại món ăn của món ăn được thêm vào CTHD   
        SELECT Loai
        INTO MA_Loai
        FROM MonAn 
        WHERE MonAn.ID_MonAn = NEW.ID_MonAn;
    END IF;
    
    IF (OLD.ID_HoaDon IS NOT NULL) THEN
        SELECT HoaDon.Code_Voucher, Voucher.LoaiMA 
        INTO v_code, v_loaiMA
        FROM HoaDon
        LEFT JOIN Voucher ON Voucher.Code_Voucher = HoaDon.Code_Voucher
        WHERE HoaDon.ID_HoaDon = OLD.ID_HoaDon;
        
        -- Tìm loại món ăn của món ăn được xóa khỏi CTHD   
        SELECT Loai
        INTO MA_Loai
        FROM MonAn 
        WHERE MonAn.ID_MonAn = OLD.ID_MonAn;
    END IF;
    
    IF v_code IS NOT NULL THEN
        IF (v_loaiMA = 'All' OR v_loaiMA = MA_Loai) THEN 
            IF (NEW.ID_HoaDon IS NOT NULL) THEN
                UPDATE HoaDon SET TienGiam = TienGiam + Tinhtiengiam(NEW.ThanhTien, v_code) WHERE HoaDon.ID_HoaDon = NEW.ID_HoaDon;
            END IF;
            
            IF (OLD.ID_HoaDon IS NOT NULL) THEN
                UPDATE HoaDon SET TienGiam = TienGiam + Tinhtiengiam(OLD.ThanhTien, v_code) WHERE HoaDon.ID_HoaDon = OLD.ID_HoaDon;
            END IF;
        END IF;
    END IF;
END//

DELIMITER ;

-- --   Tong tien o Hoa Don = Tien mon an --  Tien giam
DELIMITER //
CREATE TRIGGER Tg_HD_Tongtien AFTER INSERT ON HoaDon
FOR EACH ROW
BEGIN
    UPDATE HoaDon SET Tongtien = NEW.TienMonAn - NEW.TienGiam WHERE ID_HoaDon = NEW.ID_HoaDon;
END;
//
DELIMITER ;

-- --   Khi cap nhat Code_Voucher o HoaDon, Tinh tien giam theo thong tin cua Voucher do va giam Diem tich luy cua KH
DELIMITER //
CREATE TRIGGER Tg_HD_DoiVoucher BEFORE UPDATE ON HoaDon
FOR EACH ROW
BEGIN
    DECLARE TongtienLoaiMonAnduocgiam INT;
    DECLARE v_Diemdoi INT;
    DECLARE v_Phantram INT;
    DECLARE v_LoaiMA VARCHAR(50);
    
    IF (NEW.Code_Voucher IS NOT NULL) THEN
        SELECT Diem, Phantram, LoaiMA
        INTO v_Diemdoi, v_Phantram, v_LoaiMA
        FROM Voucher
        WHERE Code_Voucher = NEW.Code_Voucher;
        
        CALL KH_TruDTL(NEW.ID_KH, v_Diemdoi);
        CALL Voucher_GiamSL(NEW.Code_Voucher);
        
        IF (v_LoaiMA = 'All') THEN
            SET TongtienLoaiMonAnduocgiam := NEW.TienMonAn;
        ELSE 
            SELECT SUM(Thanhtien)
            INTO TongtienLoaiMonAnduocgiam
            FROM CTHD 
            JOIN MonAn ON MonAn.ID_MonAn = CTHD.ID_MonAn
            WHERE ID_HoaDon = NEW.ID_HoaDon AND LOAI = v_LoaiMA;
        END IF;
        
        SET NEW.Tiengiam := ROUND(TongtienLoaiMonAnduocgiam * v_Phantram / 100);
        SET NEW.Tongtien := NEW.Tienmonan - NEW.Tiengiam;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Voucher khong ton tai';
    END IF;
END;
//
DELIMITER ;

-- --  Trigger Doanh so cua Khach hang bang tong tien cua tat ca hoa don co trang thai 'Da thanh toan' 
-- --  cua khach hang do
-- --   Diem tich luy cua Khach hang duoc tinh bang 0.005% Tong tien cua hoa don (1.000.000d tuong duong 50 diem)
DELIMITER //
CREATE TRIGGER Tg_KH_DoanhsovaDTL AFTER UPDATE ON HoaDon
FOR EACH ROW
BEGIN
    IF NEW.Trangthai = 'Da thanh toan' THEN
        UPDATE KhachHang SET Doanhso = Doanhso + NEW.Tongtien WHERE ID_KH = NEW.ID_KH;
        UPDATE KhachHang SET Diemtichluy = Diemtichluy + ROUND(NEW.Tongtien * 0.00005)
        WHERE ID_KH = NEW.ID_KH;
    END IF;
END;
//
DELIMITER ;


-- --  Trigger khi khach hang them hoa don moi, trang thai ban chuyen tu 'Con trong' sang 'Dang dung bua'
-- --   Khi trang thai don hang tro thanh 'Da thanh toan' trang thai ban chuyen tu 'Dang dung bua' sang 'Con trong'

DELIMITER //

CREATE TRIGGER Tg_TrangthaiBan AFTER INSERT ON HoaDon
FOR EACH ROW
BEGIN
    IF NEW.Trangthai = 'Chua thanh toan' THEN 
        UPDATE Ban SET Trangthai = 'Dang dung bua' WHERE ID_Ban = NEW.ID_Ban;
    ELSE 
        UPDATE Ban SET Trangthai = 'Con trong' WHERE ID_Ban = NEW.ID_Ban;
    END IF; 
END;
//

DELIMITER ;
DELIMITER //

CREATE TRIGGER Tg_TrangthaiBan AFTER UPDATE ON HoaDon
FOR EACH ROW
BEGIN
    IF NEW.Trangthai = 'Chua thanh toan' THEN 
        UPDATE Ban SET Trangthai = 'Dang dung bua' WHERE ID_Ban = NEW.ID_Ban;
    ELSE 
        UPDATE Ban SET Trangthai = 'Con trong' WHERE ID_Ban = NEW.ID_Ban;
    END IF; 
END;
//

DELIMITER ;

-- --    Trigger Thanh tien o CTNK bang SoLuong x Dongia cua nguyen lieu do

DELIMITER //

CREATE TRIGGER Tg_CTNK_Thanhtien_Insert BEFORE INSERT ON CTNK
FOR EACH ROW
BEGIN
    DECLARE gia FLOAT; -- Sử dụng FLOAT cho kiểu dữ liệu giá
    
    SELECT DonGia
    INTO gia
    FROM NguyenLieu
    WHERE NguyenLieu.ID_NL = NEW.ID_NL;
    
    SET NEW.ThanhTien := NEW.SoLuong * gia;
    
END;
//

DELIMITER ;
DELIMITER //

CREATE TRIGGER Tg_CTNK_Thanhtien_Update BEFORE UPDATE ON CTNK
FOR EACH ROW
BEGIN
    DECLARE gia FLOAT; -- Sử dụng FLOAT cho kiểu dữ liệu giá
    
    SELECT DonGia
    INTO gia
    FROM NguyenLieu
    WHERE NguyenLieu.ID_NL = NEW.ID_NL;
    
    SET NEW.ThanhTien := NEW.SoLuong * gia;
    
END;
//

DELIMITER ;


-- --  Trigger Tong tien o PhieuNK bang tong thanh tien cua CTNK
DELIMITER //

CREATE TRIGGER Tg_PNK_Tongtien AFTER INSERT ON CTNK
FOR EACH ROW
BEGIN
    IF NEW IS NOT NULL THEN
        UPDATE PhieuNK SET Tongtien = Tongtien + NEW.ThanhTien WHERE PhieuNK.ID_NK = NEW.ID_NK;
    END IF;
END;
//

CREATE TRIGGER Tg_PNK_Tongtien_Update AFTER UPDATE ON CTNK
FOR EACH ROW
BEGIN
    IF NEW IS NOT NULL THEN
        UPDATE PhieuNK SET Tongtien = Tongtien + NEW.ThanhTien WHERE PhieuNK.ID_NK = NEW.ID_NK;
    END IF;
END;
//

CREATE TRIGGER Tg_PNK_Tongtien_Delete AFTER DELETE ON CTNK
FOR EACH ROW
BEGIN
    IF OLD IS NOT NULL THEN
        UPDATE PhieuNK SET Tongtien = Tongtien - OLD.ThanhTien WHERE PhieuNK.ID_NK = OLD.ID_NK;
    END IF;
END;
//

DELIMITER ;

-- --  Trigger khi them CTNK tang So luong ton cua nguyen lieu trong kho
DELIMITER //

CREATE TRIGGER Tg_Kho_ThemSLTon_Insert AFTER INSERT ON CTNK
FOR EACH ROW
BEGIN
    UPDATE Kho SET SLTon = SLTon + NEW.SoLuong WHERE Kho.ID_NL = NEW.ID_NL;
END;
//

CREATE TRIGGER Tg_Kho_ThemSLTon_Update AFTER UPDATE ON CTNK
FOR EACH ROW
BEGIN
    UPDATE Kho SET SLTon = SLTon + NEW.SoLuong - OLD.SoLuong WHERE Kho.ID_NL = NEW.ID_NL;
END;
//

CREATE TRIGGER Tg_Kho_ThemSLTon_Delete AFTER DELETE ON CTNK
FOR EACH ROW
BEGIN
    UPDATE Kho SET SLTon = SLTon - OLD.SoLuong WHERE Kho.ID_NL = OLD.ID_NL;
END;
//

DELIMITER ;

-- --  Trigger khi them CTXK giam So luong ton cua nguyen lieu trong kho
DELIMITER //

CREATE TRIGGER Tg_Kho_GiamSLTon_Insert AFTER INSERT ON CTXK
FOR EACH ROW
BEGIN
    UPDATE Kho SET SLTon = SLTon - NEW.SoLuong WHERE Kho.ID_NL = NEW.ID_NL;
END;
//

CREATE TRIGGER Tg_Kho_GiamSLTon_Update AFTER UPDATE ON CTXK
FOR EACH ROW
BEGIN
    UPDATE Kho SET SLTon = SLTon - NEW.SoLuong + OLD.SoLuong WHERE Kho.ID_NL = NEW.ID_NL;
END;
//

CREATE TRIGGER Tg_Kho_GiamSLTon_Delete AFTER DELETE ON CTXK
FOR EACH ROW
BEGIN
    UPDATE Kho SET SLTon = SLTon + OLD.SoLuong WHERE Kho.ID_NL = OLD.ID_NL;
END;
//

DELIMITER ;

-- --  Trigger khi them mot Nguyen Lieu moi, them NL do vao Kho
DELIMITER //

CREATE TRIGGER Tg_Kho_ThemNL
AFTER INSERT ON NguyenLieu
FOR EACH ROW
BEGIN
    INSERT INTO Kho (ID_NL) VALUES (NEW.ID_NL);
END;
//

DELIMITER ;


-- --  Procedure
-- --  Procudure them mot khach hang moi voi cac thong tin tenKH , NgayTG va ID_ND
DELIMITER //

CREATE PROCEDURE KH_ThemKH(IN tenKH VARCHAR(255), IN NgayTG DATE, IN ID_ND INT)
BEGIN
    DECLARE v_ID_KH INT;
    
    -- Tìm ID_KH tiếp theo
    SELECT COALESCE(MIN(ID_KH) + 1, 1) INTO v_ID_KH
    FROM KHACHHANG
    WHERE ID_KH + 1 NOT IN (SELECT ID_KH FROM KHACHHANG);
    
    -- Chèn dữ liệu mới vào bảng KhachHang
    IF v_ID_KH IS NOT NULL THEN
        INSERT INTO KhachHang (ID_KH, TenKH, Ngaythamgia, ID_ND) VALUES (v_ID_KH, tenKH, NgayTG, ID_ND);
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Thong tin khong hop le';
    END IF;
END;
//

DELIMITER ;

-- --  Procudure them mot nhan vien moi voi cac thong tin tenNV, NgayVL, SDT, Chucvu, ID_NQL, Tinhtrang
DELIMITER //

CREATE PROCEDURE NV_ThemNV(
    IN tenNV VARCHAR(255), 
    IN NgayVL DATE, 
    IN SDT VARCHAR(20),
    IN Chucvu VARCHAR(255),
    IN ID_NQL INT, 
    IN Tinhtrang VARCHAR(255)
)
BEGIN
    DECLARE v_ID_NV INT;
    
    -- Tìm ID_NV tiếp theo
    SELECT COALESCE(MIN(ID_NV) + 1, 1) INTO v_ID_NV
    FROM NHANVIEN
    WHERE ID_NV + 1 NOT IN (SELECT ID_NV FROM NHANVIEN);
    
    -- Chèn dữ liệu mới vào bảng NhanVien
    IF v_ID_NV IS NOT NULL THEN
        INSERT INTO NhanVien (ID_NV, TenNV, NgayVL, SDT, Chucvu, ID_NQL, Tinhtrang) 
        VALUES (v_ID_NV, tenNV, NgayVL, SDT, Chucvu, ID_NQL, Tinhtrang);
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Thong tin khong hop le';
    END IF;
END;
//

DELIMITER ;

-- --   Procudure xoa mot NHANVIEN voi idNV
DELIMITER //

CREATE PROCEDURE NV_XoaNV(
    IN idNV INT
)
BEGIN
    DECLARE v_count INT;
    DECLARE idNQL INT;
    
    -- Tìm số lượng nhân viên có ID_NV như được chỉ định
    SELECT COUNT(ID_NV), ID_NQL INTO v_count, idNQL
    FROM NHANVIEN
    WHERE ID_NV = idNV;
    
    IF v_count > 0 THEN
        IF idNV = idNQL THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Khong the xoa QUAN LY';
        ELSE
            -- Xóa dữ liệu liên quan trong bảng CTNK
            DELETE CTNK 
            FROM CTNK
            INNER JOIN PHIEUNK ON CTNK.ID_NK = PHIEUNK.ID_NK
            WHERE PHIEUNK.ID_NV = idNV;
            
            -- Xóa dữ liệu liên quan trong bảng CTXK
            DELETE CTXK 
            FROM CTXK
            INNER JOIN PHIEUXK ON CTXK.ID_XK = PHIEUXK.ID_XK
            WHERE PHIEUXK.ID_NV = idNV;
            
            -- Xóa dữ liệu trong bảng PHIEUNK
            DELETE FROM PHIEUNK WHERE ID_NV = idNV;
            
            -- Xóa dữ liệu trong bảng PHIEUXK
            DELETE FROM PHIEUXK WHERE ID_NV = idNV;
            
            -- Xóa dữ liệu trong bảng NHANVIEN
            DELETE FROM NHANVIEN WHERE ID_NV = idNV;
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nhan vien khong ton tai';
    END IF;
END;
//

DELIMITER ;

-- --   Procudure xoa mot KHACHHANG voi idKH
DELIMITER //

CREATE PROCEDURE KH_XoaKH(
    IN idKH INT
)
BEGIN 
    DECLARE v_count INT;
    
    -- Tìm số lượng khách hàng có ID_KH như được chỉ định
    SELECT COUNT(*) INTO v_count
    FROM KHACHHANG
    WHERE ID_KH = idKH;
    
    IF v_count > 0 THEN
        -- Xóa dữ liệu trong bảng CTHD liên quan đến khách hàng
        DELETE CTHD
        FROM CTHD
        INNER JOIN HOADON ON CTHD.ID_HoaDon = HOADON.ID_HoaDon
        WHERE HOADON.ID_KH = idKH;
        
        -- Xóa dữ liệu trong bảng HOADON liên quan đến khách hàng
        DELETE FROM HOADON WHERE ID_KH = idKH;
        
        -- Xóa dữ liệu trong bảng KHACHHANG
        DELETE FROM KHACHHANG WHERE ID_KH = idKH;
    ELSE 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Khach hang khong ton tai';
    END IF;
END;
//

DELIMITER ;


-- --   Procedure xem thong tin KHACHHANG voi thong tin idKH
DELIMITER //

CREATE PROCEDURE KH_XemTT(
    IN idKH INT
)
BEGIN 
    DECLARE v_TenKH VARCHAR(255);
    DECLARE v_NgayThamGia DATE;
    DECLARE v_DoanhSo DECIMAL(10, 2);
    DECLARE v_DiemTichLuy INT;
    DECLARE v_ID_ND INT;
    
    -- Lấy thông tin của khách hàng với ID_KH được chỉ định
    SELECT TenKH, Ngaythamgia, Doanhso, Diemtichluy, ID_ND
    INTO v_TenKH, v_NgayThamGia, v_DoanhSo, v_DiemTichLuy, v_ID_ND
    FROM KHACHHANG
    WHERE ID_KH = idKH;
    
    -- Kiểm tra nếu không tìm thấy dữ liệu
    IF v_TenKH IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Khach hang khong ton tai';
    ELSE
        -- Xuất thông tin khách hàng ra console
        SELECT CONCAT('Ma khach hang: ', idKH) AS 'Ma khach hang';
        SELECT CONCAT('Ten khach hang: ', v_TenKH) AS 'Ten khach hang';
        SELECT CONCAT('Ngay tham gia: ', DATE_FORMAT(v_NgayThamGia,'%d-- %m-- %Y')) AS 'Ngay tham gia';
        SELECT CONCAT('Doanh so: ', v_DoanhSo) AS 'Doanh so';
        SELECT CONCAT('Diem tich luy: ', v_DiemTichLuy) AS 'Diem tich luy';
        SELECT CONCAT('Ma nguoi dung: ', v_ID_ND) AS 'Ma nguoi dung';
    END IF;
END;
//

DELIMITER ;

-- --   Procedure xem thong tin NHANVIEN voi thong tin idNV
DELIMITER //

CREATE PROCEDURE NV_XemTT(
    IN idNV INT
)
BEGIN 
    DECLARE v_TenNV VARCHAR(255);
    DECLARE v_NgayVL DATE;
    DECLARE v_SDT VARCHAR(20);
    DECLARE v_ChucVu VARCHAR(255);
    DECLARE v_ID_NQL INT;
    
    -- Lấy thông tin của nhân viên với ID_NV được chỉ định
    SELECT TenNV, NgayVL, SDT, Chucvu, ID_NQL   
    INTO v_TenNV, v_NgayVL, v_SDT, v_ChucVu, v_ID_NQL
    FROM NHANVIEN WHERE ID_NV = idNV;
    
    -- Kiểm tra nếu không tìm thấy dữ liệu
    IF v_TenNV IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nhan vien khong ton tai';
    ELSE
        -- Xuất thông tin nhân viên ra console
        SELECT CONCAT('Ma nhan vien: ', idNV) AS 'Ma nhan vien';
        SELECT CONCAT('Ten nhan vien: ', v_TenNV) AS 'Ten nhan vien';
        SELECT CONCAT('Ngay vao lam: ', DATE_FORMAT(v_NgayVL,'%d-- %m-- %Y')) AS 'Ngay vao lam';
        SELECT CONCAT('Chuc vu: ', v_ChucVu) AS 'Chuc vu';
        SELECT CONCAT('Ma nguoi quan ly: ', v_ID_NQL) AS 'Ma nguoi quan ly';
    END IF;
END;
//

DELIMITER ;

-- --   Procedure liet ke danh sach hoa don tu ngay A den ngay B
DELIMITER //

CREATE PROCEDURE DS_HoaDon_tuAdenB(IN fromA DATE, IN toB DATE)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE ID_HOADON INT;
    DECLARE ID_KH INT;
    DECLARE ID_BAN INT;
    DECLARE NGAYHD DATE;
    DECLARE TIENMONAN DECIMAL(10,2);
    DECLARE TIENGIAM DECIMAL(10,2);
    DECLARE TONGTIEN DECIMAL(10,2);
    DECLARE TRANGTHAI VARCHAR(255);

    DECLARE cur CURSOR FOR
        SELECT ID_HOADON, ID_KH, ID_BAN, NGAYHD, TIENMONAN, TIENGIAM, TONGTIEN, TRANGTHAI   
        FROM HOADON WHERE NGAYHD BETWEEN fromA AND DATE_ADD(toB, INTERVAL 1 DAY);

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO ID_HOADON, ID_KH, ID_BAN, NGAYHD, TIENMONAN, TIENGIAM, TONGTIEN, TRANGTHAI;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT CONCAT('Ma hoa don: ', ID_HOADON);
        SELECT CONCAT('Ma khach hang: ', ID_KH);
        SELECT CONCAT('Ma ban: ', ID_BAN);
        SELECT CONCAT('Ngay hoa don: ', DATE_FORMAT(NGAYHD,'%d-- %m-- %Y'));
        SELECT CONCAT('Tien mon an: ', TIENMONAN);
        SELECT CONCAT('Tien giam: ', TIENGIAM);
        SELECT CONCAT('Tong tien: ', TONGTIEN);
        SELECT CONCAT('Trang thai: ', TRANGTHAI);
    END LOOP;

    CLOSE cur;
END //

DELIMITER ;

-- --   Procedure liet ke danh sach phieu nhap kho tu ngay A den ngay B
DELIMITER //

CREATE PROCEDURE DS_PhieuNK_tuAdenB(IN fromA DATE, IN toB DATE)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE ID_NK INT;
    DECLARE ID_NV INT;
    DECLARE NGAYNK DATE;
    DECLARE TONGTIEN DECIMAL(10,2);

    DECLARE cur CURSOR FOR
        SELECT ID_NK, ID_NV, NGAYNK, TONGTIEN  
        FROM PHIEUNK WHERE NGAYNK BETWEEN fromA AND DATE_ADD(toB, INTERVAL 1 DAY);

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO ID_NK, ID_NV, NGAYNK, TONGTIEN;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT CONCAT('Ma nhap kho: ', ID_NK);
        SELECT CONCAT('Ma nhan vien: ', ID_NV);
        SELECT CONCAT('Ngay nhap kho: ', DATE_FORMAT(NGAYNK,'%d-- %m-- %Y'));
        SELECT CONCAT('Tong tien: ', TONGTIEN);
    END LOOP;

    CLOSE cur;
END //

DELIMITER ;


-- --   Procedure liet ke danh sach phieu xuat kho tu ngay A den ngay B
DELIMITER //

CREATE PROCEDURE DS_PhieuXK_tuAdenB(IN fromA DATE, IN toB DATE)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE ID_XK INT;
    DECLARE ID_NV INT;
    DECLARE NGAYXK DATE;

    DECLARE cur CURSOR FOR
        SELECT ID_XK, ID_NV, NGAYXK
        FROM PHIEUXK WHERE NGAYXK BETWEEN fromA AND DATE_ADD(toB, INTERVAL 1 DAY);

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO ID_XK, ID_NV, NGAYXK;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT CONCAT('Ma xuat kho: ', ID_XK);
        SELECT CONCAT('Ma nhan vien: ', ID_NV);
        SELECT CONCAT('Ngay xuat kho: ', DATE_FORMAT(NGAYXK,'%d-- %m-- %Y'));
    END LOOP;

    CLOSE cur;
END //

DELIMITER ;

-- --   Procedure xem chi tiet hoa don cua 1 hoa don
DELIMITER //

CREATE PROCEDURE HD_XemCTHD(IN idHD INT)
BEGIN 
    DECLARE done INT DEFAULT 0;
    DECLARE ID_MONAN INT;
    DECLARE SOLUONG INT;
    DECLARE THANHTIEN DECIMAL(10, 2);

    DECLARE cur CURSOR FOR
        SELECT ID_MONAN, SOLUONG, THANHTIEN
        FROM CTHD WHERE ID_HOADON = idHD;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO ID_MONAN, SOLUONG, THANHTIEN;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT CONCAT('Ma mon an: ', ID_MONAN);
        SELECT CONCAT('So luong: ', SOLUONG);
        SELECT CONCAT('Thanh tien: ', THANHTIEN);
    END LOOP;

    CLOSE cur;
END //

DELIMITER ;

-- --   Procedure giam So Luong cua Voucher di 1 khi KH doi Voucher
DELIMITER //

CREATE PROCEDURE Voucher_GiamSL(IN code VARCHAR(10))
BEGIN
    DECLARE v_count INT;

    SELECT COUNT(*)
    INTO v_count
    FROM Voucher
    WHERE Code_Voucher = code;

    IF v_count > 0 THEN
        UPDATE Voucher SET SoLuong = SoLuong - 1 WHERE Code_Voucher = code;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Voucher khong ton tai';
    END IF;
END //

DELIMITER ;


-- --   Procedure giam Diem tich luy cua KH khi doi Voucher
DELIMITER //

CREATE PROCEDURE KH_TruDTL(IN ID INT, IN diemdoi INT)
BEGIN 
    DECLARE v_count INT;

    SELECT COUNT(*)
    INTO v_count
    FROM KHACHHANG
    WHERE ID_KH = ID;

    IF v_count > 0 THEN
        UPDATE KHACHHANG SET Diemtichluy = Diemtichluy - diemdoi WHERE ID_KH = ID;
    ELSE 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Khach hang khong ton tai';
    END IF;
END //

DELIMITER ;


-- --  Fuction 
-- --  Fuction Tinh doanh thu hoa don theo ngay
DELIMITER //

CREATE FUNCTION DoanhThuHD_theoNgay (ngHD DATE)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE v_Doanhthu INT;

    SELECT COALESCE(SUM(Tongtien), 0)
    INTO v_Doanhthu
    FROM HOADON 
    WHERE NGAYHD = ngHD;

    RETURN v_Doanhthu;
END //

DELIMITER ;

-- --  Fuction Tinh chi phi nhap kho theo ngay
DELIMITER //

CREATE FUNCTION ChiPhiNK_theoNgay (ngNK DATE)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE v_Chiphi INT;

    SELECT COALESCE(SUM(Tongtien), 0)
    INTO v_Chiphi
    FROM PHIEUNK 
    WHERE NGAYNK = ngNK;

    RETURN v_Chiphi;
END //

DELIMITER ;

-- --  Fuction Tinh doanh so trung binh cua x KHACHHANG co doanh so cao nhat
DELIMITER //

CREATE FUNCTION DoanhsoTB_TOPxKH(x INT)
RETURNS DECIMAL
READS SQL DATA
BEGIN
    DECLARE v_avg DECIMAL;

    SELECT AVG(Doanhso)
    INTO v_avg
    FROM (
        SELECT Doanhso 
        FROM KHACHHANG
        ORDER BY Doanhso DESC
        LIMIT x
        ) AS top_customers;
    
    RETURN v_avg;
END //

DELIMITER ;

-- --  Fuction Tinh so luong KHACHANG moi trong thang chi dinh cua nam co it nhat mot hoa don co tri gia tren x vnd
DELIMITER //

CREATE FUNCTION SL_KH_Moi(thang INT, nam INT, trigiaHD INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE v_count INT;

    SELECT COUNT(ID_KH)
    INTO v_count
    FROM KHACHHANG
    WHERE EXTRACT(MONTH FROM Ngaythamgia) = thang AND EXTRACT(YEAR FROM Ngaythamgia) = nam
    AND EXISTS(
        SELECT *
        FROM HOADON 
        WHERE HOADON.ID_KH = KHACHHANG.ID_KH AND TONGTIEN > trigiaHD
    );

    RETURN v_count;          
END //

DELIMITER ;

    
-- --  Fuction Tinh tien mon an duoc giam khi them mot CTHD moi
DELIMITER //

CREATE FUNCTION CTHD_Tinhtiengiam(Tongtien INT, Code VARCHAR(255))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE Tiengiam INT;
    DECLARE v_Phantram INT;

    SELECT Phantram
    INTO v_Phantram
    FROM Voucher
    WHERE Code_Voucher = Code;

    SET Tiengiam := ROUND(Tongtien * v_Phantram / 100);
    RETURN Tiengiam;
END //

DELIMITER ;

-- --  Them data
-- SET SESSION NLS_DATE_FORMAT = 'dd-- MM-- YYYY';

-- --  Them data cho Bang NguoiDung
-- --  Nhan vien
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (100,'NVHoangViet@gmail.com','1234','Verified','Quan Ly');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (101,'NVHoangPhuc@gmail.com','123','Verified','Nhan Vien');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (102,'NVAnhHong@gmail.com','123','Verified','Nhan Vien Kho');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (103,'NVQuangDinh@gmail.com','123','Verified','Nhan Vien');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (201,'QLtrungkbkb@gmail.com','123','Verified','Quan Ly');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (200,'NVKtrungkbkb@gmail.com','123','Verified','Nhan Vien Kho');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (202,'NVtrungkbkb@gmail.com','123','Verified','Nhan Vien');
-- --  Khach Hang
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (204,'KHPhungVanNguen@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (204,'KHThaoDuong@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (105,'KHTanHieu@gmail.com','223','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (106,'KHQuocThinh@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (107,'KHNhuMai@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (108,'KHBichHao@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (109,'KHMaiQuynh@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (110,'KHMinhQuang@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (111,'KHThanhHang@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (112,'KHThanhNhan@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (113,'KHPhucNguyen@gmail.com','123','Verified','Khach Hang');

-- --  Them data cho bang Nhan Vien
 -- SET @@SESSION.date_format = '%d-- %m-- %Y'; 
-- --  Co tai khoan
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_ND,ID_NQL,Tinhtrang) VALUES (100,'Nguyen Hoang Viet','2024-05-10','0848044725','Quan ly',100,100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_ND,ID_NQL,Tinhtrang) VALUES (101,'Nguyen Hoang Phuc','2024-05-10','0838033334','Tiep tan',101,100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_ND,ID_NQL,Tinhtrang) VALUES (102,'Le Thi Anh Hong','2024-05-10','0838033234','Kho',102,100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_ND,ID_NQL,Tinhtrang) VALUES (103,'Ho Quang Dinh','2024-05-10','0838033234','Tiep tan',103,100,'Dang lam viec');
-- --  Khong co tai khoan
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (104,'Ha Thao Duong','2024-05-10','0838033232','Phuc vu',100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (105,'Nguyen Quoc Thinh','2024-05-10','0838033734','Phuc vu',100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (106,'Truong Tan Hieu','2024-05-10','0838033834','Phuc vu',100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (107,'Nguyen Thai Bao','2024-05-10','0838093234','Phuc vu',100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (108,'Tran Nhat Khang','2024-05-10','0838133234','Thu ngan',100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (109,'Nguyen Ngoc Luong','2024-05-10','0834033234','Bep',100,'Dang lam viec');

-- --  Them data cho bang KhachHang
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (100,'Ha Thao Duong','2024-05-10',104);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (101,'Truong Tan Hieu','2024-05-10',105);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (102,'Nguyen Quoc Thinh','2024-05-10',106);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (103,'Tran Nhu Mai','2024-05-10',107);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (104,'Nguyen Thi Bich Hao','2024-05-10',108);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (105,'Nguyen Mai Quynh','2024-05-10',109);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (106,'Hoang Minh Quang','2024-05-10',110);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (107,'Nguyen Thanh Hang','2024-05-10',111);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (108,'Nguyen Ngoc Thanh Nhan','2024-05-10',112);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (109,'Hoang Thi Phuc Nguyen','2024-05-10',113);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (209,'PhungVanNguyen','2024-05-10',113);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (309,'PhungVanNguyen','2024-05-10',204);
-- --  Them data cho bang MonAn
-- --  Aries
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(1,'DUI CUU NUONG XE NHO', 250000,'Aries','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(2,'BE SUON CUU NUONG GIAY BAC MONG CO', 230000,'Aries','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(3,'DUI CUU NUONG TRUNG DONG', 350000,'Aries','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(4,'CUU XOC LA CA RI', 129000,'Aries','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(5,'CUU KUNGBAO', 250000,'Aries','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(6,'BAP CUU NUONG CAY', 250000,'Aries','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(7,'CUU VIEN HAM CAY', 19000,'Aries','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(8,'SUON CONG NUONG MONG CO', 250000,'Aries','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(9,'DUI CUU LON NUONG TAI BAN', 750000,'Aries','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(10,'SUONG CUU NUONG SOT NAM', 450000,'Aries','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(11,'DUI CUU NUONG TIEU XANH', 285000,'Aries','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(12,'SUON CUU SOT PHO MAI', 450000,'Aries','Dang kinh doanh');

-- --  Taurus
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(13,'Bit tet bo My khoai tay', 179000,'Taurus','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(14,'Bo bit tet Uc',169000,'Taurus','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(15,'Bit tet bo My BASIC', 179000,'Taurus','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(16,'My Y bo bam', 169000,'Taurus','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(17,'Thit suon Wagyu', 1180000,'Taurus','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(18,'Steak Thit Vai Wagyu', 1290000,'Taurus','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(19,'Steak Thit Bung Bo', 550000,'Taurus','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(20,'Tomahawk', 2390000,'Taurus','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(21,'Salad Romaine Nuong', 180000,'Taurus','Dang kinh doanh');

-- --  Gemini
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(22,'Combo Happy', 180000,'Gemini','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(23,'Combo Fantastic', 190000,'Gemini','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(24,'Combo Dreamer', 230000,'Gemini','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(25,'Combo Cupid', 180000,'Gemini','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(26,'Combo Poseidon', 190000,'Gemini','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(27,'Combo LUANG PRABANG', 490000,'Gemini','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(28,'Combo VIENTIANE', 620000,'Gemini','Dang kinh doanh');

-- --  Cancer
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(29,'Cua KingCrab Duc sot', 3650000,'Cancer','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(30,'Mai Cua KingCrab Topping Pho Mai', 2650000,'Cancer','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(31,'Cua KingCrab sot Tu Xuyen', 2300000,'Cancer','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(32,'Cua KingCrab Nuong Tu Nhien', 2550000,'Cancer','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(33,'Cua KingCrab Nuong Bo Toi', 2650000,'Cancer','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(34,'Com Mai Cua KingCrab Chien', 1850000,'Cancer','Dang kinh doanh');

-- --  Leo
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(35,'BOSSAM', 650000,'Leo','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(36,'KIMCHI PANCAKE', 350000,'Leo','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(37,'SPICY RICE CAKE', 250000,'Leo','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(38,'SPICY SAUSAGE HOTPOT', 650000,'Leo','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(39,'SPICY PORK', 350000,'Leo','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(40,'MUSHROOM SPICY SILKY TOFU STEW', 350000,'Leo','Dang kinh doanh');
-- --  Virgo
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(41,'Pavlova', 150000,'Virgo','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(42,'Kesutera', 120000,'Virgo','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(43,'Cremeschnitte', 250000,'Virgo','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(44,'Sachertorte', 150000,'Virgo','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(45,'Schwarzwalder Kirschtorte', 250000,'Virgo','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(46,'New York-- Style Cheesecake', 250000,'Virgo','Dang kinh doanh');

-- --  Libra
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(47,'Cobb Salad', 150000,'Libra','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(48,'Salad Israeli', 120000,'Libra','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(49,'Salad Dau den', 120000,'Libra','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(50,'Waldorf Salad', 160000,'Libra','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(51,'Salad Gado-- Gado', 200000,'Libra','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(52,'Nicoise Salad', 250000,'Libra','Dang kinh doanh');

-- --  Scorpio
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(53,'BULGOGI LUNCHBOX', 250000,'Scorpio','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(54,'CHICKEN TERIYAKI LUNCHBOX', 350000,'Scorpio','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(55,'SPICY PORK LUNCHBOX', 350000,'Scorpio','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(56,'TOFU TERIYAKI LUNCHBOX', 250000,'Scorpio','Dang kinh doanh');

-- --  Sagittarius
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(57,'Thit ngua do tuoi', 250000,'Sagittarius','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(58,'Steak Thit ngua', 350000,'Sagittarius','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(59,'Thit ngua ban gang', 350000,'Sagittarius','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(60,'Long ngua xao dua', 150000,'Sagittarius','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(61,'Thit ngua xao sa ot', 250000,'Sagittarius','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(62,'Ngua tang', 350000,'Sagittarius','Dang kinh doanh');

-- --  Capricorn
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(63,'Thit de xong hoi', 229000,'Capricorn','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(64,'Thit de xao rau ngo', 199000,'Capricorn','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(65,'Thit de nuong tang', 229000,'Capricorn','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(66,'Thit de chao', 199000,'Capricorn','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(67,'Thit de nuong xien', 199000,'Capricorn','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(68,'Nam de nuong/chao', 199000,'Capricorn','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(69,'Thit de xao lan', 19000,'Capricorn','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(70,'Dui de tan thuoc bac', 199000,'Capricorn','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(71,'Canh de ham duong quy', 199000,'Capricorn','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(72,'Chao de dau xanh', 50000,'Capricorn','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(73,'Thit de nhung me', 229000,'Capricorn','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(74,'Lau de nhu', 499000,'Capricorn','Dang kinh doanh');


-- --  Aquarius
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(75,'SIGNATURE WINE', 3290000,'Aquarius','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(76,'CHILEAN WINE', 3990000,'Aquarius','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(77,'ARGENTINA WINE', 2890000,'Aquarius','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(78,'ITALIAN WINE', 5590000,'Aquarius','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(79,'AMERICAN WINE', 4990000,'Aquarius','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(80,'CLASSIC COCKTAIL', 200000,'Aquarius','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(81,'SIGNATURE COCKTAIL', 250000,'Aquarius','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(82,'MOCKTAIL', 160000,'Aquarius','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(83,'JAPANESE SAKE', 1490000,'Aquarius','Dang kinh doanh');

-- --  Pisces
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(84,'Ca Hoi Ngam Tuong', 289000,'Pisces','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(85,'Ca Ngu Ngam Tuong', 289000,'Pisces','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(86,'IKURA:Trung ca hoi', 189000,'Pisces','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(87,'KARIN:Sashimi Ca Ngu', 149000,'Pisces','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(88,'KEIKO:Sashimi Ca Hoi', 199000,'Pisces','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(89,'CHIYO:Sashimi Bung Ca Hoi', 219000,'Pisces','Dang kinh doanh');

-- --  Them data cho bang Ban
-- --  Tang 1
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(100,'Ban T1.1','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(101,'Ban T1.2','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(102,'Ban T1.3','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(103,'Ban T1.4','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(104,'Ban T1.5','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(105,'Ban T1.6','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(106,'Ban T1.7','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(107,'Ban T1.8','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(108,'Ban T1.9','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(109,'Ban T1.10','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(110,'Ban T1.11','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(111,'Ban T1.12','Tang 1','Con trong');
-- --  Tang 2
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(112,'Ban T2.1','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(113,'Ban T2.2','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(114,'Ban T2.3','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(115,'Ban T2.4','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(116,'Ban T2.5','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(117,'Ban T2.6','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(118,'Ban T2.7','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(119,'Ban T2.8','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(120,'Ban T2.9','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(121,'Ban T2.10','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(122,'Ban T2.11','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(123,'Ban T2.12','Tang 2','Con trong');
-- --  Tang 3
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(124,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(125,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(126,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(127,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(128,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(129,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(130,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(131,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(132,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(133,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(134,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(135,'Ban T3.1','Tang 3','Con trong');

-- --  Them data cho bang Voucher
insert into Voucher(Code_Voucher,Mota , Phantram,LoaiMA,SoLuong,Diem) values ('loQy','20% off for Aries Menu',20,'Aries',10,200);
insert into Voucher(Code_Voucher,Mota , Phantram,LoaiMA,SoLuong,Diem) values ('pCfI','30% off for Taurus Menu',30,'Taurus',5,300);
insert into Voucher(Code_Voucher,Mota , Phantram,LoaiMA,SoLuong,Diem) values ('pApo','20% off for Gemini Menu',20,'Gemini',10,200);
insert into Voucher(Code_Voucher,Mota , Phantram,LoaiMA,SoLuong,Diem) values ('ugQx','100% off for Virgo Menu',100,'Virgo',3,500);
insert into Voucher(Code_Voucher,Mota , Phantram,LoaiMA,SoLuong,Diem) values ('nxVX','20% off for All Menu',20,'All',5,300);
insert into Voucher(Code_Voucher,Mota , Phantram,LoaiMA,SoLuong,Diem) values ('Pwyn','20% off for Cancer Menu',20,'Cancer',10,200);
insert into Voucher(Code_Voucher,Mota , Phantram,LoaiMA,SoLuong,Diem) values ('bjff','50% off for Leo Menu',50,'Leo',5,600);
insert into Voucher(Code_Voucher,Mota , Phantram,LoaiMA,SoLuong,Diem) values ('YPzJ','20% off for Aquarius Menu',20,'Aquarius',5,200);
insert into Voucher(Code_Voucher,Mota , Phantram,LoaiMA,SoLuong,Diem) values ('Y5g0','30% off for Pisces Menu',30,'Pisces',5,300);
insert into Voucher(Code_Voucher,Mota , Phantram,LoaiMA,SoLuong,Diem) values ('7hVO','60% off for Aries Menu',60,'Aries',0,1000);
insert into Voucher(Code_Voucher,Mota , Phantram,LoaiMA,SoLuong,Diem) values ('WHLm','20% off for Capricorn Menu',20,'Capricorn',0,200);
insert into Voucher(Code_Voucher,Mota , Phantram,LoaiMA,SoLuong,Diem) values ('GTsC','20% off for Leo Menu',20,'Leo',0,200);


-- --  Them data cho bang HoaDon
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (101,100,100,'2024-05-10',0,0,' ');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (102,104,102,'2024-05-10',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (103,105,103,'2024-05-10',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (104,101,101,'2024-05-10',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (105,103,120,'2024-05-10',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (106,104,100,'2024-05-10',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (107,107,103,'2024-05-10',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (108,108,101,'2024-05-10',0,0,'');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (109,100,100,'2024-05-10',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (110,103,101,'2024-05-10',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (111,106,102,'2024-05-10',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (112,108,103,'2024-05-10',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (113,106,102,'2024-05-10',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (114,108,103,'2024-05-10',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (115,109,104,'2024-05-10',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (116,100,105,'2024-05-10',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (117,106,106,'2024-05-10',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (118,102,106,'2024-05-10',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (119,103,106,'2024-05-10',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (120,104,106,'2024-05-10',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (121,105,106,'2024-05-10',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (122,107,106,'2024-05-10',0,0,'Chua thanh toan');

-- --  Them data cho CTHD
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (101,1,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (101,3,1);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (101,10,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (102,1,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (102,2,1);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (102,4,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (103,12,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (104,30,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (104,59,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (105,28,1);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (105,88,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (106,70,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (106,75,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (106,78,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (107,32,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (107,12,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (108,12,1);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (108,40,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (109,45,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (110,34,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (110,43,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (111,65,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (111,47,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (112,49,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (112,80,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (112,31,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (113,80,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (113,80,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (114,30,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (114,32,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (115,80,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (116,57,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (116,34,1);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (117,67,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (117,66,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (118,34,10);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (118,35,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (119,83,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (119,78,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (120,38,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (120,39,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (121,53,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (121,31,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (122,33,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (122,34,6);
UPDATE HOADON SET TrangThai='Da thanh toan';

-- --  Them data cho bang NguyenLieu
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(100,'Thit ga',40000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(101,'Thit heo',50000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(102,'Thit bo',80000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(103,'Tom',100000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(104,'Ca hoi',500000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(105,'Gao',40000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(106,'Sua tuoi',40000,'l');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(107,'Bot mi',20000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(108,'Dau ca hoi',1000000,'l');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(109,'Dau dau nanh',150000,'l');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(110,'Muoi',20000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(111,'Duong',20000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(112,'Hanh tay',50000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(113,'Toi',30000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(114,'Dam',50000,'l');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(115,'Thit de',130000,'kg');
-- --  Them data cho K
use BIAVIP ;
INSERT INTO Kho(ID_NL,SLTon) VALUES (115,100);
INSERT INTO Kho(ID_NL,SLTon) VALUES (116,100);
INSERT INTO Kho(ID_NL,SLTon) VALUES (110,100);
INSERT INTO Kho(ID_NL,SLTon) VALUES (111,100);
INSERT INTO Kho(ID_NL,SLTon) VALUES (112,100);
INSERT INTO Kho(ID_NL,SLTon) VALUES (113,100);
INSERT INTO Kho(ID_NL,SLTon) VALUES (117,100);
-- --  Them data cho PhieuNK
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (100,102,'2024-05-10');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (101,102,'2024-05-10');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (102,102,'2024-05-10');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (103,102,'2024-05-10');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (104,102,'2024-05-10');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (105,102,'2024-05-10');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (106,102,'2024-05-10');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (107,102,'2024-05-10');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (108,102,'2024-05-10');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (109,102,'2024-05-10');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (110,102,'2024-05-10');

-- --  Them data cho CTNK
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (100,100,10);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (100,101,20);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (100,102,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,101,10);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,103,20);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,104,10);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,105,10);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,106,20);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,107,5);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,108,5);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,109,10);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,110,20);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,112,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,113,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,114,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (103,112,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (103,113,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (103,114,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (104,112,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (104,113,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (105,110,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (106,102,25);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (106,115,25);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (107,110,35);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (107,105,25);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (108,104,25);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (108,103,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (108,106,30);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (109,112,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (109,113,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (109,114,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (110,102,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (110,106,25);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (110,107,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (110,110,20);

-- --  Them data cho PhieuXK
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (100,102,'2024-05-10');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (101,102,'2024-05-10');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (102,102,'2024-05-10');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (103,102,'2024-05-10');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (104,102,'2024-05-10');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (105,102,'2024-05-10');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (106,102,'2024-05-10');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (107,102,'2024-05-10');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (108,102,'2024-05-10');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (109,102,'2024-05-10');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (110,102,'2024-05-10');

-- --  Them data cho CTXK
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (100,100,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (100,101,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (100,102,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,101,7);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,103,10);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,104,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,105,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,106,10);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,109,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,110,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,112,10);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,113,8);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,114,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (103,114,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (103,104,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (104,101,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (104,112,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (105,113,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (105,102,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (106,103,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (106,114,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (107,105,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (107,106,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (108,115,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (108,110,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (109,110,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (109,112,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (110,113,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (110,114,5);


