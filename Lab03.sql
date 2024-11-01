use master
go

use lab02
go

-- Vật tư
create table VATTU(
	MaVTu char(4) not null primary key,
	TenVTu varchar(100) not null unique,
	DvTinh varchar(10) null default '',
	PhanTram real check(PhanTram between 0 and 100)
)

select * from VATTU
go

-- Nhà cung cấp
create table NHACC (
	MaNhacCc char(3) not null primary key,
	TenNhaCc varchar(100) not null unique,
	SoDh char(4) not null,
	DiaChi varchar(200) not null,
	DienThoai varchar(20) null default 'Chưa có'
)

select * from NHACC
go

-- Đơn đặt hàng
create table DONDH(
	SoDh char(4) not null primary key,
	NgayDh datetime default GETDATE(),
	MaNhaCc char(3) not null
)

select * from DONDH
go

-- Chi tiết đơn đặt hàng
create table CTDONDH(
	SoDh char(4) not null,
	MaVTu char(4) not null,
	SlDat int not null check(SlDat > 0)
)

select * from CTDONDH
go

-- Phiếu nhập hàng
create table PNHAP(
	SoPn char(4) primary key,
)