create table Ban(
	SoBan int primary key not null,
	ViTri nvarchar(50) not null,
	TrangThai bit not null
)

create table ChiTietHD(
	MaHD int  not null,
	MaSP int  not null,
	SoLuong int not null
		constraint PK_CTHD primary key(MaHD, MaSP)
)

create table HoaDon(
	MaHD int primary key not null,
	MaKH int,
	SoBan int,
	NgayLapHD date,
	Code_Voucher varchar(10),
	TrangThai bit not null
)

create table DatBan(
	MaDatBan int primary key not null,
	GioBD datetime not null,
	GioKT datetime  not null,
	SoLuong int not null,
	SoBan int not null,
	MaKH int 
)

create table KhachHang(
	MaKH int primary key ,
	TenKH nvarchar(50) not null,
	NgayThamGia date  not null,
	DoanhSo int not null,
	DiemTichLuy int not null,
	UserID int not null,
	LoaiKH int not null
)

create table LoaiKH(
	MaLKH int primary key not null
)

create table NguoiDung(
    UserID int primary key,
    Email varchar(50),
    Matkhau varchar(20),
    Vaitro varchar(20)
);

create table NhaCungCap(
    MaNCC int primary key,
    TenNCC nvarchar(50) not null,
    DiaChi varchar(50) not null,
	SDT char(10) not null,
    TG_HopTac date not null
);

create table NhanVien(
    MaNV int primary key not null,
    TenNV nvarchar(50) not null,
    NgayVaoLam DATE ,
    SDT char(10) not null,
    Chucvu nvarchar(50),
    UserID int 
);

create table SanPham(
    MaSP int primary key,
    TenSP nvarchar(50) not null, 
    Gia int,
    MaNCC int,
    TrangThai bit
);

create table Voucher(
    Code_Voucher varchar(10) primary key not null,
    Mota nvarchar(50) not null,
    Phantram int
		constraint V_PhanTram check (Phantram > 0 AND Phantram <= 100),
    SoLuong int,
	Diem int not null,
	MaHD varchar(10)  
);



