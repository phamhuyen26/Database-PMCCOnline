
create database QLHTChamCong


create table PhongBan(
    MaPhongBan char(10) primary key,
    TenPhongBan char(50) not null,
    SoNhanVien INT not null
)
insert into PhongBan
VALUES
('PB01','NOS1',5),
('PB02','NOS2',5),
('PB03','NOS3',5),
('PB04','NOS4',5),
('PB05','NOS5',10)

create table Nhanvien
(
    MaNV char(10) ,
    MaPhongBan char(10),
    HoTen nvarchar(30) not null,
    GioiTinh nvarchar(5),
    NgaySinh date,
    DiaChi nvarchar(30),
    Email nvarchar(50) unique check (Email like '%@%'),
    SDT char(10),
    ChucVu nvarchar(100),
    primary key (MaNV),
    FOREIGN key (MaPhongBan) REFERENCES PhongBan(MaPhongBan)
)


insert into Nhanvien
VALUES
('NV01','PB01',N'Nguyễn Công Bính',N'Nam','1998-03-02',N'Hà Nội',N'binh123@gmail.com','0367231400',N'Quản lí'),
('NV02','PB01',N'Phạm Thị Huyền',N'Nữ','2001-03-12',N'Nam Định',N'huyen2611@gmail.com','0362301402',N'Nhân viên'),
('NV03','PB01',N'Đinh Thị Bình',N'Nữ','1998-12-29',N'Hà Nội',N'binhthi23@gmail.com','0367502330',N'Nhân viên'),
('NV04','PB01',N'Mai Văn Đức',N'Nam','1989-12-07',N'Thanh Hoá',N'ducmaivan@gmail.com','0978236789',N'Nhân viên'),
('NV05','PB01',N'Nguyễn Thị Linh Chi',N'Nữ','1995-12-20',N'Thái Bình',N'linhchi@gmail.com','0236755188',N'Nhân viên'),
('NV06','PB02',N'Phạm Thị Lan',N'Nữ','1988-03-12',N'Nam Định',N'lan232@gmail.com','0368501407',N'Quản lí'),
('NV07','PB02',N'Đăng Mai Lĩnh',N'Nam','1994-03-07',N'Hà Nam',N'linhnamdang12@gmail.com','0943275078',N'Nhân viên'),
('NV08','PB02',N'Đinh Thị Phương Anh',N'Nữ','1998-02-28',N'Hà Nội',N'phuongAnh@gmail.com','0367501230',N'Nhân viên'),
('NV09','PB02',N'Hoàng Văn Đức',N'Nam','1989-01-07',N'Thanh Hoá',N'ducvan12@gmail.com','0978723789',N'Nhân viên'),
('NV010','PB02',N'Nguyễn Linh Chi',N'Nữ','1995-12-20',N'Thái Bình',N'linhchi12@gmail.com','0936755188',N'Nhân viên'),
('NV011','PB03',N'Phạm Thị Mai',N'Nữ','2000-03-12',N'Nam Định',N'maithi@gmail.com','0368501472',N'Quản lí'),
('NV012','PB03',N'Nguyễn Lan Hương',N'Nữ','1996-03-12',N'Hà Nội',N'huongnguyen@gmail.com','0967501400',N'Nhân viên'),
('NV013','PB03',N'Mai Thị Bình',N'Nữ','1999-12-29',N'Hà Nội',N'binhthimai23@gmail.com','0367801230','Nhân viên'),
('NV014','PB03',N'Mai Văn Quang',N'Nam','1980-12-07',N'Thanh Hoá',N'quangmai@gmail.com','0978123789',N'Nhân viên'),
('NV015','PB03',N'Nguyễn Thị Loan',N'Nữ','1995-11-20',N'Thái Bình',N'loannguyen293@gmail.com','0838755188',N'Nhân viên'),
('NV016','PB04',N'Nguyễn Thị Hoa',N'Nữ','2000-01-12',N'Nam Định',N'hoanguyen@gmail.com','0368501402',N'Quản lí'),
('NV017','PB04',N'Đăng Quang Tuấn',N'Nam','1994-09-07',N'Hà Nam',N'quangtuan@gmail.com','0943285078',N'Nhân viên'),
('NV018','PB04',N'Đinh Thị Cúc',N'Nữ','1998-12-09',N'Hà Nội',N'cucdinh@gmail.com','0367506237',N'Nhân viên'),
('NV019','PB04',N'Nguyễn Văn Đức',N'Nam','1989-02-07',N'Thanh Hoá',N'nguyenduc@gmail.com','0978723789',N'Nhân viên'),
('NV020','PB04',N'Hà Linh Chi',N'Nữ','1995-12-21',N'Thái Bình',N'linhchiha@gmail.com','0336775188',N'Nhân viên'),
('NV021','PB05',N'Phạm Thị Quế',N'Nữ','2001-03-16',N'Nam Định',N'quequadi@gmail.com','0368591402',N'Quản lí'),
('NV022','PB05',N'Nguyễn Quang Hoàng',N'Nam','1988-03-02',N'Hà Nội',N'quanghoang12@gmail.com','0387501400',N'Nhân viên'),
('NV023','PB05',N'Đinh Thị Châu',N'Nữ','1998-12-19',N'Hà Nội',N'emlachaubau12@gmail.com','0367401230',N'Nhân viên'),
('NV024','PB05',N'Hà Văn Đức',N'Nam','1999-12-07',N'Thanh Hoá',N'haduc12345@gmail.com','0978193789',N'Nhân viên'),
('NV025','PB05',N'Ngô Thị Linh Chi',N'Nữ','1999-12-20',N'Thái Bình',N'linhchingo@gmail.com','0856755188',N'Nhân viên'),
('NV026','PB05',N'Đặng Hồng Phong',N'Nam','1984-03-07',N'Hà Nam',N'phonggiangho@gmail.com','0903275078',N'Nhân viên'),
('NV027','PB05',N'Cẩm Tú Cầu',N'Nữ','2001-03-22',N'Nam Định',N'camtucau@gmail.com','0367501402',N'Nhân viên'),
('NV028','PB05',N'Nguyễn Thúy Kiều',N'Nữ','1998-02-09',N'Hà Nội',N'kieunguyen@gmail.com','0367581230',N'Nhân viên'),
('NV029','PB05',N'Mai Thúy Vân',N'Nữ','1989-12-17',N'Thanh Hoá',N'thuyvanni@gmail.com','0975123789',N'Nhân viên'),
('NV030','PB05',N'Ngô Danh Dự',N'Nam','1995-10-20',N'Thái Bình',N'danhduqua@gmail.com','0835755188',N'Nhân viên');

create table TaiKhoan
(
    MaNV char(10) primary key,
    MatKhau char(200) not NULL default '12345678',
    FOREIGN key (MaNV) REFERENCES Nhanvien(MaNV)
)


insert into TaiKhoan(MaNV)
VALUES
('NV01'),
('NV02'),
('NV03'),
('NV04'),
('NV05'),
('NV06'),
('NV07'),
('NV08'),
('NV09'),
('NV010'),
('NV011'),
('NV012'),
('NV013'),
('NV014'),
('NV015'),
('NV016'),
('NV017'),
('NV018'),
('NV019'),
('NV020'),
('NV021'),
('NV022'),
('NV023'),
('NV024'),
('NV025'),
('NV026'),
('NV027'),
('NV028'),
('NV029'),
('NV030')

create table CheckIn(
MaNV char(10) ,
NgayCheckin date,
ThoiGianCheckIn time,
primary key (MaNV,NgayCheckin),
FOREIGN key (MaNV) REFERENCES Nhanvien(MaNV)
)
delete CheckIn
insert into CheckIn
VALUES
('NV01','2021-10-10','10:00:00'),
('NV02','2021-10-10','9:00:00'),
('NV03','2021-10-10','9:00:00'),
('NV04','2021-10-10','9:00:00'),
('NV05','2021-10-10','11:00:00'),
('NV06','2021-10-10','9:00:00'),
('NV07','2021-10-10','9:00:00'),
('NV08','2021-10-10','9:00:00'),
('NV09','2021-10-10','9:00:00'),
('NV010','2021-10-10','9:10:00'),

('NV01','2021-10-11','9:01:00'),
('NV02','2021-10-11','9:00:00'),
('NV03','2021-10-11','9:30:00'),
('NV04','2021-10-11','9:00:00'),
('NV05','2021-10-11','9:00:00'),
('NV06','2021-10-11','9:20:00'),
('NV07','2021-10-11','9:00:00'),
('NV08','2021-10-11','9:00:00'),
('NV09','2021-10-11','9:40:00'),
('NV010','2021-10-11','9:00:00'),

('NV01','2021-10-12','9:00:00'),
--('NV02','2021-10-12','9:00:00'),
('NV03','2021-10-12','9:00:00'),
('NV04','2021-10-12','9:00:00'),
('NV05','2021-10-12','9:00:00'),
('NV06','2021-10-12','9:00:00'),
('NV07','2021-10-12','9:00:00'),
('NV08','2021-10-12','9:00:00'),
('NV09','2021-10-12','9:00:00'),
('NV010','2021-10-12','9:00:00'),

('NV01','2021-10-13','9:00:00'),
('NV02','2021-10-13','9:00:00'),
('NV03','2021-10-13','9:00:00'),
--('NV04','2021-10-13','9:00:00'),
('NV05','2021-10-13','9:00:00'),
('NV06','2021-10-13','9:00:00'),
('NV07','2021-10-13','9:00:00'),
('NV08','2021-10-13','9:00:00'),
('NV09','2021-10-13','9:00:00'),
('NV010','2021-10-13','9:00:00'),

('NV01','2021-10-14','9:00:00'),
('NV02','2021-10-14','9:00:00'),
('NV03','2021-10-14','9:00:00'),
--('NV04','2021-10-14','9:00:00'),
('NV05','2021-10-14','9:00:00'),
('NV06','2021-10-14','9:00:00'),
('NV07','2021-10-14','9:00:00'),
('NV08','2021-10-14','9:00:00'),
('NV09','2021-10-14','9:00:00')
--('NV010','2021-10-14','9:00:)00'

drop trigger Trig_Update_NgayLam_Luong



create table CheckOut(
MaNV char(10) ,
NgayCheckout date,
ThoiGianCheckout time,
primary key (MaNV,NgayCheckout),
FOREIGN key (MaNV) REFERENCES Nhanvien(MaNV)
)

insert into CheckOut
VALUES
('NV01','2021-10-10','17:00:00'),
('NV02','2021-10-10','17:00:00'),
('NV03','2021-10-10','17:00:00'),
('NV04','2021-10-10','17:00:00'),
('NV05','2021-10-10','17:00:00'),
('NV06','2021-10-10','17:00:00'),
('NV07','2021-10-10','17:00:00'),
('NV08','2021-10-10','17:00:00'),
('NV09','2021-10-10','17:00:00'),
('NV010','2021-10-10','17:00:00'),

('NV01','2021-10-11','17:00:00'),
('NV02','2021-10-11','17:00:00'),
('NV03','2021-10-11','17:00:00'),
('NV04','2021-10-11','17:00:00'),
('NV05','2021-10-11','17:00:00'),
('NV06','2021-10-11','17:00:00'),
('NV07','2021-10-11','17:00:00'),
('NV08','2021-10-11','17:00:00'),
('NV09','2021-10-11','17:00:00'),
('NV010','2021-10-11','17:00:00'),

('NV01','2021-10-12','17:00:00'),
--('NV02','2021-10-12','17:00:00'),
('NV03','2021-10-12','17:00:00'),
('NV04','2021-10-12','17:00:00'),
('NV05','2021-10-12','17:00:00'),
('NV06','2021-10-12','17:00:00'),
('NV07','2021-10-12','17:00:00'),
('NV08','2021-10-12','17:00:00'),
('NV09','2021-10-12','17:00:00'),
('NV010','2021-10-12','17:00:00'),

('NV01','2021-10-13','17:00:00'),
('NV02','2021-10-13','17:00:00'),
('NV03','2021-10-13','17:00:00'),
--('NV04','2021-10-13','17:00:00'),
('NV05','2021-10-13','17:00:00'),
('NV06','2021-10-13','17:00:00'),
('NV07','2021-10-13','17:00:00'),
('NV08','2021-10-13','17:00:00'),
('NV09','2021-10-13','17:00:00'),
('NV010','2021-10-13','17:00:00'),

('NV01','2021-10-14','17:00:00'),
('NV02','2021-10-14','17:00:00'),
('NV03','2021-10-14','17:00:00'),
--('NV04','2021-10-14','17:00:00'),
('NV05','2021-10-14','17:00:00'),
('NV06','2021-10-14','17:00:00'),
('NV07','2021-10-14','17:00:00'),
('NV08','2021-10-14','17:00:00'),
('NV09','2021-10-14','17:00:00'),
--('NV010','2021-10-14','17:00:00'),



create table DuAn
(
    MaDuAn  char(10) primary key,
    TenDuAn  nvarchar(500),
	TienDo nvarchar(200),
	NgayNhan date not null,
	HanBanGiao date not null
)

insert into DuAn
values
('DA01',N'Chạy quảng cáo cho xe honda',N'Mới nhận','2021-10-8','2021-11-14'),
('DA02',N'Thiết kế phần mềm cho quán bán quần áo',N'Chuẩn bị bàn giao','2021-10-9','2021-11-14'),
('DA03',N'Thiết kế phần mềm cho quán bán bán mỹ phẩm',N'Thiết kế hệ thống ','2021-10-9','2021-11-14'),
('DA04',N'Thiết kế phần mềm quản lý thư viện',N'Kiểm thử phần mềm','2021-10-14','2021-11-7'),
('DA05',N'Thiết kế phần mềm nhận diện khuôn mặt',N'Xây dựng database','2021-10-14','2021-11-8')



create table Nhiemvu (
MaNV char(10) ,
MaDuAn char(10),
Ngay date not null,
TrangThai nvarchar(200) not null default N'Chưa làm',
NhiemVuCV ntext,
primary key(MaNV,Ngay),
FOREIGN key (MaNV) REFERENCES Nhanvien(MaNV),
FOREIGN key (MaDuAn) REFERENCES DuAn(MaDuAn)
)

delete Nhiemvu
insert into Nhiemvu
VALUES
('NV01','DA01','2021-10-10',N'Đã làm',N'design'),
('NV02','DA01','2021-10-10',N'Chưa làm',N'backend'),
('NV03','DA01','2021-10-10',N'Đã làm',N'frontend'),
('NV04','DA01','2021-10-10',N'Đã làm',N'testing'),
('NV05','DA01','2021-10-10',N'Chưa làm',N'testing'),
('NV01','DA05','2021-11-11',N'Đã làm',N'design'),
('NV02','DA05','2021-11-11',N'Chưa làm',N'backend'),
('NV03','DA05','2021-11-11',N'Đã làm',N'frontend'),
('NV04','DA05','2021-11-11',N'Đã làm',N'backend'),
('NV05','DA05','2021-11-11',N'Chưa làm',N'backend'),
('NV06','DA02','2021-10-10',N'Đã làm',N'backend'),
('NV07','DA02','2021-10-10',N'Chưa làm',N'frontend'),
('NV08','DA02','2021-10-10',N'Đã làm',N'design'),
('NV09','DA02','2021-10-10',N'Đã làm',N'design'),
('NV010','DA02','2021-10-10',N'Chưa làm',N'design'),
('NV011','DA03','2021-10-10',N'Đã làm',N'frontend'),
('NV012','DA03','2021-10-10',N'Chưa làm',N'frontend'),
('NV013','DA03','2021-10-10',N'Đã làm',N'frontend'),
('NV014','DA03','2021-10-10',N'Đã làm',N'design'),
('NV015','DA03','2021-10-10',N'Chưa làm',N'design'),
('NV016','DA04','2021-10-10',N'Đã làm',N'design'),
('NV017','DA04','2021-10-10',N'Chưa làm',N'frontend'),
('NV018','DA04','2021-10-10',N'Đã làm',N'frontend'),
('NV019','DA04','2021-10-10',N'Đã làm',N'testing'),
('NV020','DA04','2021-10-10',N'Chưa làm',N'testing')



create table Luong
(
    MaNV char(10),
	Thang date,
	LuongMotNgay  float,
    SoNgayLam float,
    Thue float default 0.105,
    TongLuong float,
	primary key (MaNV,Thang),
    FOREIGN key (MaNV) REFERENCES Nhanvien(MaNV)
)

delete Luong

insert into Luong(MaNV,Thang,SoNgayLam,LuongMotNgay)
VALUES
('NV01','2021-10-30',null,400000),
('NV02','2021-10-30',null,500000),
('NV03','2021-10-30',null,300000),
('NV04','2021-10-30',null,270000),
('NV01','2021-11-30',null,350000),
('NV02','2021-11-30',null,290000),
('NV03','2021-11-30',null,250000),
('NV04','2021-11-30',null,300000)

SELECT * from luong where id='NV01' and Thang='2021-10-30'



select * from PhongBan
select * from Nhanvien
select * from TaiKhoan
Select * from DuAn
select * from CheckIn
select * from CheckOut
select * from Nhiemvu
select * from Luong

--PhongBan(MaPhongban, TenPhongBan, SoNhanVien) 
--Nhanvien(MaNV, MaPhongBan, HoTen,GioiTinh, NgaySinh, DiaChi,Email, SDT,ChucVu) 
--TaiKhoan(MaNV,MatKhau) 
--DuAn(MaDuAn, TenDuAn, TienDo,NgayNhanDuAn,HanBanGiao) 
--CheckIn(MaNV, NgayCheckin,ThoiGianCheckIn) 
--CheckOut(MaNV, NgayCheckout ,ThoiGianCheckOut) 
--Luong(MaNV, Thang, LuongMotNgay,SoNgayLam,Thue, TongLuong)  
--Nhiemvu(MaNV ,MaDuAn ,Ngay ,TrangThai,NhiemVuCV )




