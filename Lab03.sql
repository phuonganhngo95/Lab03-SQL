use master
go

use Lab03
go

-- Danh mục Vật tư
create table VATTU(
	MaVTu nchar(4) not null primary key,
	TenVTu nvarchar(100) not null unique,
	DvTinh nvarchar(10) null default '',
	PhanTram real check(PhanTram between 0 and 100)
)

insert into VATTU(MaVTu, TenVTu, DvTinh, PhanTram) values
(N'DD01', N'Đầu DVD Hitachi 1 đĩa', N'Bộ', 40),
(N'DD02', N'Đầu DVD Hitachi 3 đĩa', N'Bộ', 40),
(N'TL15', N'Tủ lạnh Sanyo 150 lít', N'Cái', 25),
(N'TL90', N'Tủ lạnh Sanyo 90 lít', N'Cái', 20),
(N'TV14', N'Tivi Sony 14 inches', N'Cái', 15),
(N'TV21', N'Tivi Sony 21 inches', N'Cái', 10),
(N'TV29', N'Tivi Sony 29 inches', N'Cái', 10),
(N'VD01', N'Đầu VCD Sony 1 đĩa', N'Bộ', 30),
(N'VD02', N'Đầu VCD Sony 3 đĩa', N'Bộ', 30)

select * from VATTU
go

-- Danh mục Nhà cung cấp
create table NHACC(
	MaNhaCc char(3) not null primary key,
	TenNhaCc varchar(100) not null,
	DiaChi varchar(200) not null,
	DienThoai varchar(20) null default 'Chưa có'
)

insert into NHACC(MaNhaCc, TenNhaCc, DiaChi, DienThoai) values
('C01', 'Lê Minh Thành', '54 Kim Mã, Cầu Giấy, Hà Nội,', '8781024'),
('C02', 'Trần Quang Anh', '145, Hùng Vương, Hải Dương', '7698154'),
('C03', 'Bùi Hồng Phương', '154/85 Lê Chân, Hải Phòng', '9600125'),
('C04', 'Vũ Nhật Thắng', '194/40 Hương Lộ 14 QTB HCM', '8757757'),
('C05', 'Nguyễn Thị Thúy', '178 Nguyễn Văn Luông, Đà Lạt', '7964251'),
('C07', 'Cao Minh Trung', '125 Lê Quang Sung, Nha Trang', 'Chưa có')

select * from NHACC
go

-- Đơn đặt hàng
create table DONDH(
	SoDh nchar(4) not null primary key,
	NgayDh datetime default GETDATE(),
	MaNhaCc nchar(3) not null,
	foreign key (MaNhaCc) references NHACC(MaNhaCc)
)

insert into DONDH(SoDh, NgayDh, MaNhaCc) values
(N'D001', 2012-01-15, N'C03'),
(N'D002', 2012-01-30, N'C01'),
(N'D003', 2012-02-10, N'C02'),
(N'D004', 2012-02-17, N'C05'),
(N'D005', 2012-03-01, N'C02'),
(N'D006', 2012-03-12, N'C05')

select * from DONDH
go

-- Chi tiết Đơn đặt hàng
create table CTDONDH(
	SoDh nchar(4) not null,
	MaVTu nchar(4) not null,
	SlDat int not null check(SlDat > 0),
	primary key (SoDh, MaVTu),
	foreign key (SoDh) references DONDH(SoDh),
	foreign key (MaVTu) references VATTU(MaVTu)
)

insert into CTDONDH(SoDh, MaVTu, SlDat) values
(N'D001', N'DD01', 10),
(N'D001', N'DD02', 15),
(N'D002', N'VD02', 30),
(N'D003', N'TV14', 10),
(N'D003', N'TV29', 20),
(N'D004', N'TL90', 10),
(N'D005', N'TV14', 10),
(N'D006', N'TV29', 20),
(N'D006', N'VD01', 20)

select * from CTDONDH
go

-- Phiếu Nhập hàng
create table PNHAP(
	SoPn nchar(4) primary key,
	NgayNhap datetime default GETDATE(),
	SoDh nchar(4) not null,
	foreign key (SoDh) references DONDH(SoDh)
)

insert into PNHAP(SoPn, NgayNhap, SoDh) values
(N'N001', '2012-17-01', N'D001'),
(N'N002', '2012-01-20', N'D001'),
(N'N003', '2012-01-31', N'D002')

select * from PNHAP
go

-- Chi tiết nhập hàng
create table CTPNHAP(
	SoPn nchar(4) not null,
	MaVTu nchar(4) not null,
	SlNhap int not null check(SlNhap > 0),
	DgNhap money not null check(DgNhap > 0),
	primary key (SoPn, MaVTu),
	foreign key (MaVTu) references VATTU(MaVTu),
	foreign key (SoPn) references PNHAP(SoPn)
)

insert into CTPNHAP(SoPn, MaVTu, SlNhap, DgNhap) values
(N'N001', N'DD01', 8, 2500000),
(N'N001', N'DD02', 10, 3500000),
(N'N002', N'DD01', 2, 2500000),
(N'N002', N'DD02', 5, 3500000),
(N'N003', N'VD02', 30, 2500000),
(N'N004', N'TV14', 5, 2500000),
(N'N004', N'TV29', 12, 3500000)

select * from CTPNHAP
go

-- Phiếu xuất hàng
create table PXUAT(
	SoPx nchar(4) not null primary key,
	NgayXuat datetime default GETDATE(),
	TenKh nvarchar(100) not null
)

insert into PXUAT(SoPx, NgayXuat, TenKh) values
(N'X001', '2012-01-17', N'Nguyễn Ngọc Phương Nhi'),
(N'X002', '2012-01-25', N'Nguyễn Hồng Phương'),
(N'X003', '2012-01-31', N'Nguyễn Tuấn Tú')

select * from PXUAT
go

-- Chi tiết xuất hàng
create table CTPXUAT(
	SoPx nchar(4) not null,
	MaVTu nchar(4) not null,
	SlXuat int not null check(SlXuat > 0),
	DgXuat money not null check(DgXuat > 0),
	primary key (SoPx, MaVTu),
	foreign key (MaVTu) references VATTU(MaVTu),
	foreign key (SoPx) references PXUAT(SoPx)
)

insert into CTPXUAT(SoPx, MaVTu, SlXuat, DgXuat) values
(N'X001', N'DD01', 2, 3500000),
(N'X002', N'DD01', 1, 3500000),
(N'X002', N'DD02', 5, 4900000),
(N'X003', N'DD01', 3, 3500000),
(N'X003', N'DD02', 2, 4900000),
(N'X003', N'VD02', 10, 3250000)

select * from CTPXUAT
go

-- Tồn kho
create table TONKHO(
	NamThang nchar(6) not null,
	MaVTu nchar(4) not null,
	SLDau int not null check(SLDau > 0),
	TongSLN int not null check(TongSLN > 0),
	TongSLX int not null check(TongSLX > 0),
	SLCuoi as(SLDau + TongSLN - TongSLX),
	primary key (NamThang, MaVTu),
	foreign key (MaVTu) references VATTU(MaVTu)
)

insert into TONKHO(NamThang, MaVTu, SLDau, TongSLN, TongSLX, SLCuoi) values
(N'201201', N'DD01', 0, 10, 6, 4),
(N'201201', N'DD02', 0, 15, 7, 8),
(N'201201', N'VD02', 0, 30, 10, 20),
(N'201202', N'DD01', 4, 0, 0, 4),
(N'201202', N'DD02', 8, 0, 0, 8),
(N'201202', N'VD02', 20, 0, 0, 20),
(N'201202', N'TV14', 5, 0, 0, 5),
(N'201202', N'TV29', 12, 0, 0, 12)

select * from TONKHO
go
