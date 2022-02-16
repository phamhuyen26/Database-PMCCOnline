--Các chức năng chính của hệ thống:
-- admin:
--1:Xem thông tin checkIn, checkOut của Nhan vien: dùng view kết hợp 3 bảng
--Nhập ngày bất kì in ra lịch sử chấm công của tất cả các nhân viên trong ngày đó và tổng thời gian làm trong ngày: dùng thủ tục truyền biết ngày
-- In ra số giờ làm trung bình của nhân viên theo ngày
--In ra danh sách các nhân viên làm <8 tiếng/ ngày

alter view view_LichSuChamCong(MaNV,MaPhongBan,HoTen,ChucVu,Ngay,ThoiGianCheckIn,ThoiGianCheckOut,SoGioLam)
as
select NhanVien.MaNV,MaPhongBan,HoTen,ChucVu,NgayCheckIn,ThoiGianCheckIn,ThoiGianCheckOut,convert(float,datediff(minute,ThoiGianCheckIn,ThoiGianCheckOut))/60  
from Nhanvien,CheckIn,CheckOut
where NhanVien.MaNV=CheckIn.MaNV and CheckIn.NgayCheckIn=CheckOut.NgayCheckOut and NhanVien.MaNV=CheckOut.MaNV


alter view LichSuChamCong(MaNV,MaPhongBan,HoTen,ChucVu,Ngay,ThoiGianCheckIn,ThoiGianCheckOut)
as
select distinct NhanVien.MaNV,MaPhongBan,HoTen,ChucVu,NgayCheckIn,ThoiGianCheckIn,ThoiGianCheckOut
from Nhanvien,CheckIn,CheckOut
where NhanVien.MaNV=CheckIn.MaNV or NhanVien.MaNV=CheckOut.MaNV

select * from LichSuChamCong

--select * from view_LichSuChamCong order by Ngay,MaNV,HoTen;


--tạo thủ tục nhập ngày bất kì trong một tháng của một năm in ra lịch sử chấm công của all nhân viên trong ngày đó
alter proc proc_KiemTraTGLamTheoNgay
@time date
as begin
		select view_LichSuChamCong.*  from view_LichSuChamCong where Ngay=@time
		order by Ngay,MaPhongBan,MaNV
	end
exec proc_KiemTraTGLamTheoNgay '2021-10-10';


--tạo hàm nhập ngày bất kì in ra lịch sử chấm công của all nhân viên trong ngày đó
alter function f_KiemTraTGLamTheoNgay(@time date) returns table
return
(select view_LichSuChamCong.* ,convert(float, datediff(minute,ThoiGianCheckIn,ThoiGianCheckOut))/60 as SoGioLam from 
view_LichSuChamCong 
where Ngay=@time)

select * from f_KiemTraTGLamTheoNgay('2021-10-11');
	
	
--tạo hàm tham số vào là tháng bất kì , in ra thời gian làm trung bình ngày trong tháng của từng nhân viên
alter function f_AvGGioLam_Thang(@thang int,@nam int) 
returns @AvGGioLam_Thang table(MaNV char(10),HoTen nvarchar(30),MaPhongBan char(10),SoGioTrungBinh float)
as begin
		insert into @AvGGioLam_Thang 
		select MaNV,HoTen,MaPhongBan,avg(SoGioLam) from view_LichSuChamCong where month(Ngay)=@thang and year(Ngay)=@nam group by MaPhongBan,MaNV ,HoTen 
return 
end
		
select * from f_AvGGioLam_Thang(10,2021)
				
--select round(avg(con,ert(float, datediff(minute,ThoiGianCheckIn,ThoiGianCheckOut))/60),3) from view_LichSuChamCong where month(Ngay)=10 and MaNV='NV09'



--tạo hàm nhập tháng và năm đếm số ngày nhan vien lam trong thang của một năm nào đó 
alter function f_SoNgayLam(@thang int ,@nam int)
returns @SoNgayLam table(MaNV char(10),HoTen nvarchar(30),MaPhongBan char(10),SoNgayLam int)
as begin
		insert into @SoNgayLam 
		select MaNV,HoTen,MaPhongBan,count(Ngay) from view_LichSuChamCong where month(Ngay)=@thang and year(Ngay)=@nam group by MaPhongBan,MaNV,HoTen
return 
end

select * from f_SoNgayLam(10,2021);


--tạo thủ tục nhập vào tháng đưa ra số ngày làm cộng thời gian làm trung bình trong tháng của nhân viên
--f_AvGGioLam_Thang(@thang,@nam)
--f_SoNgayLam(@thang,@nam)

alter proc proc_SoNgayGioLam
@thang int,
@nam int,
@contro CURSOR VARYING OUTPUT
as begin
	set @contro =Cursor
	for
		select a.MaNV,a.HoTen,a.MaPhongBan,a.SoGioTrungBinh,b.SoNgayLam  from f_AvGGioLam_Thang(@thang,@nam) as a,f_SoNgayLam(@thang,@nam) as b where a.MaNV=b.MaNV
	open @contro;
end

declare @mycursor1 cursor;
exec proc_SoNgayLam 10,2021,@contro=@mycursor1 Output
fetch next from @mycursor1  
while(@@FETCH_STATUS=0)
	fetch next from @mycursor1
close @mycursor1
deallocate @mycursor1


--viết trigger nếu insert vào bảng nhân viên thì sẽ tạo ra bản ghi mới cho bảng taikhoan
-- Khi thêm nhân viên mới sẽ tự động tạo ra một tài khoản mặc định
alter trigger insert_NhanVien
on Nhanvien after insert
as begin
	if(exists(select i.MaPhongBan from inserted as i,PhongBan as p where p.MaPhongBan=i.MaPhongBan ))
	begin 
		declare @manv char(10),@mapb char(10);
		select @manv=MaNV,@mapb=MaPhongBan from inserted;
		update PhongBan set SoNhanVien=SoNhanVien+1 where MaPhongBan=@mapb
		insert into TaiKhoan(MaNV) values (@manv);
	end
	else
	begin
		print N'Lỗi dữ liệu nhập vào.Vui lòng nhập lại!';
		rollback tran;
	end
end




--2:In ra bảng lương của nhânvien
--2.1:hàm Tính ngày làm trong tháng của từng nhân viên: thủ tục kết hợp với con trỏ : checkin, checkout
--2.2: viết trigger update ngày vào lương thì tính tổng lương 
--f_AvGGioLam_Thang(@thang,@nam)
--f_SoNgayLam(@thang,@nam)
--thủ tục Tính tổng lương của 1 nhân viên bất kì theo tháng

--nếu nhân viên đều đi làm đúng giờ 9h00 ,tan ca lúc 5h00 hoặc sau 5 giờ , số ngày làm trong tháng lớn hơn =25 thì sẽ được cộng thêm 2 triệu tiền chuyên cần không phân biệt chức vụ
alter proc p_TongLuong
@manv char(10),
@thang int,
@nam int
as begin	
	declare @LuongMotNgay float,@songaylam int,@thue float;
	select @LuongMotNgay=LuongMotNgay ,@songaylam=SoNgayLam,@thue=Thue from Luong where MaNV=@manv and month(Thang)=@thang and year(Thang)=@nam
	if('9:00:00'>=all(select ThoiGianCheckIn from view_LichSuChamCong where MaNV=@manv and month(Ngay)=@thang and year(Ngay)=@nam)
	and '17:00:00'<=all(select ThoiGianCheckIn from view_LichSuChamCong where MaNV=@manv and month(Ngay)=@thang and year(Ngay)=@nam) and
	@songaylam>1) 
		update Luong set Tongluong=2000000+LuongMotNgay*SoNgayLam*(1-Thue) where MaNV=@manv and month(Thang)=@thang and year(Thang)=@nam
	else
		update Luong set Tongluong=LuongMotNgay*SoNgayLam*(1-Thue) where MaNV=@manv and month(Thang)=@thang and year(Thang)=@nam
end



exec p_TongLuong 'NV05',10,2021;


select * from CheckIn
select * from CheckOut

alter trigger insert_luong
on Luong after insert
as begin
	select * from Luong
	select * from inserted
	if(exists(select inserted.MaNV from inserted ,NhanVien where inserted.MaNV=Nhanvien.MaNV)	)
	begin
		declare @thang date,@manv char(10),@luongmotngay float,@songaylam int ,@thue float;
		select @manv=MaNV,@thang=Thang,@luongmotngay=LuongMotNgay,@thue=Thue from inserted
		set @songaylam=(select SoNgayLam from dbo.f_SoNgayLam(month(@thang),year(@thang)) where MaNV=@manv);
		update Luong set SoNgayLam = @songaylam where month(Thang)=month(@thang) and year(Thang)=year(@thang) and MaNV=@manv
		declare @t int,@m int;
		set @t=month(@thang);
		set @m=year(@thang);
		exec p_TongLuong @manv,@t,@m;
	end
	else
		begin
			print N'Mã NV không hợp lệ !';
			rollback tran;
		end
		
end












-- Mỗi khi nhân viên check in sẽ lấy thời gian thực khi nhân viên checkin, tạo nhiệm vụ cho nhân viên
alter trigger insert_checkin
on CheckIn after insert
as begin
	
	if(exists(select * from inserted as i,Nhanvien as n where i.MaNV=n.MaNV))
	begin
		declare @ngay date,@manv char(10);
		select @ngay=NgayCheckin, @manv=MaNV from inserted;
		insert into Nhiemvu(MaNV,MaDuAn,Ngay) values(@manv,null,@ngay)
	end
	else
		begin
			print N'Lỗi thông tin insert! Vui lòng kiểm tra lại';
			rollback tran;
		end
end




insert into CheckIn
VALUES
('NV01','2021-10-15','9:00:00')
insert into CheckIn
VALUES
('NV02','2021-10-15','10:30:00')

select * from Nhiemvu
delete Nhiemvu


--trigger không cho update mã nhân viên , mã phòng, mã dự án

create trigger update_nhanvien
on NhanVien instead of  update 
as if update(MaNV)
begin 
	print N'Bạn không thể thay đổi mã nhân viên.';
	rollback tran;
end

update Nhanvien set MaNV='NV1' where MaNV='NV01'

select * from PhongBan






--viết thủ tục nhập vào mã của quản lí thì in ra thông tin của nhân viên bao gồm lịch sử checkin, checkout của nhân viên mà người đó quản lý
alter proc DanhSachNhanVien
@manv char(10)
as begin
	if(exists(Select MaNV from NhanVien where MaNV=@manv and ChucVu=N'Quản lí'))
	begin
		declare @mapb char(10);
		select @mapb=(select MaPhongBan from Nhanvien where MaNV=@manv)
		select distinct * from view_LichSuChamCong where MaPhongBan=@mapb and ChucVu!=N'Quản lí'
	end 
	else
		print N'Bạn nhập sai mã quản lý';
end

exec DanhSachNhanVien 'NV06';



--3::kiểm tra xem trong một dự án bất kì nếu ở nhiệm vụ các trạng thái đều là hoàn thành thì update tiến độ lên bảng dự án là đã hoàn thành:
--Thủ tục kiểm tra tiến độ dự án, nếu cho đến hạn bàn giao các nhân viên trong dự án đều hoàn thành công việc thì update tiến độ là hoàn thành

alter proc check_duan
@maduan char(10)
as begin
	if(exists(select * from DuAn where MaDuAn=@maduan))
	begin
		declare @sothanhvien int,@hanbangiao date;
		select @hanbangiao=HanBanGiao  from DuAn;
		select @sothanhvien=count(MaDuAn) from NhiemVu where MaDuAn=@maduan
		if(@sothanhvien=(select count(*) from NhiemVu where MaDuAn=@maduan and TrangThai=N'Đã làm' and Ngay<=@hanbangiao))
		begin
			update DuAn set TienDo=N'Hoàn thành'		
		end 
		else
		begin
			if(@sothanhvien=(select count(*) from NhiemVu where MaDuAn=@maduan and TrangThai=N'Đã làm' and Ngay<=@hanbangiao))
			update DuAn set TienDo=N'Trễ hạn bàn giao'
		end
	end
	else
		print N'Sai mã dự án!';
end

alter proc check_duan
@maduan char(10)
as begin
	if(exists(select * from DuAn where MaDuAn=@maduan))
	begin
		declare @hanbangiao date;
		select @hanbangiao=HanBanGiao  from DuAn;
		if(@hanbangiao=(select count(*) from NhiemVu where MaDuAn=@maduan and TrangThai=N'Đã làm' and Ngay<=@hanbangiao))
		begin
			update DuAn set TienDo=N'Hoàn thành'		
		end 
		else
		begin
			if(@sothanhvien=(select count(*) from NhiemVu where MaDuAn=@maduan and TrangThai=N'Đã làm' and Ngay<=@hanbangiao))
			update DuAn set TienDo=N'Trễ hạn bàn giao'
		end
	end
	else
		print N'Sai mã dự án!';
end




exec check_duan 'DA02';

select * from DuAn









--tạo một user trong csdl
sp_grantdbaccess 'huyen', 'huyenpham'

USE QLSV
exec sp_grantdbaccess 'huyen', 'huyenpham'

sp_revokedbaccess 'huyen'



USE QLSV
exec sp_revokedbaccess 'huyenpham'

--Tạo Window login:
sp_grantlogin huyenpham

--Tạo SQL Server login:
sp_addlogin 'huyenpham', '123456789'







--Phân quyền
-- 1. TẠO LOGIN USER
-- 1.1 TẠO NGƯỜI DÙNG CHO CHỨC NĂNG QUẢN LÝ 
SP_ADDLOGIN 'USLG_QUANLY', 'Lhb12345';
GO
-- 1.2 TẠO NHÂN VIÊN CHO CHỨC NĂNG QUẢN LÝ 
SP_ADDLOGIN 'USLG_NHANVIEN_1', 'Lhb12345';
GO
SP_ADDLOGIN 'USLG_NHANVIEN_2', 'Lhb12345';
GO
SP_ADDLOGIN 'USLG_NHANVIEN_3', 'Lhb12345';
GO
SP_ADDLOGIN 'USLG_NHANVIEN_4', 'Lhb12345';
GO
-- 2. TẠO USER CHO PHÉP TRUY CẬP TỚI CSDL (BTL) QLHTChamCong
SP_GRANTDBACCESS 'USLG_QUANLY', 'US_QUANLY';
GO
SP_GRANTDBACCESS 'USLG_NHANVIEN_1', 'US_NHANVIEN_1';
GO
SP_GRANTDBACCESS 'USLG_NHANVIEN_2', 'US_NHANVIEN_2';
GO
SP_GRANTDBACCESS 'USLG_NHANVIEN_3', 'US_NHANVIEN_3';
GO
SP_GRANTDBACCESS 'USLG_NHANVIEN_4', 'US_NHANVIEN_4';
GO

-- 3. ĐỊNH NGHĨA ROLE CHO QLHTChamCong;
USE QLHTChamCong;
SP_ADDROLE 'ROLE_QUANLY';
SP_ADDROLE 'ROLE_NHANVIEN';

-- CẤP QUYỀN CHO ROLE QUẢN LÝ
GRANT ALL ON PhongBan TO ROLE_QUANLY;
GRANT ALL ON NhanVien TO ROLE_QUANLY;
GRANT ALL ON CheckIn TO ROLE_QUANLY;
GRANT ALL ON TaiKhoan TO ROLE_QUANLY;
GRANT ALL ON CheckOut TO ROLE_QUANLY;
GRANT ALL ON DuAn TO ROLE_QUANLY;
GRANT ALL ON NhiemVu TO ROLE_QUANLY;
GRANT ALL ON Luong TO ROLE_QUANLY;


-- CẤP QUYỀN CHO ROLE NHÂN VIÊN
GRANT SELECT ON NhiemVu TO ROLE_NHANVIEN;
GRANT insert ON NhiemVu TO ROLE_NHANVIEN;
GRANT SELECT ON CheckIn TO ROLE_NHANVIEN;
GRANT insert ON CheckIn TO ROLE_NHANVIEN;
GRANT SELECT ON CheckOut TO ROLE_NHANVIEN;
GRANT insert ON CheckOut TO ROLE_NHANVIEN;




-- GÁN USER VÀO ROLE
SP_ADDROLEMEMBER 'ROLE_QUANLY', 'US_QUANLY';
GO
SP_ADDROLEMEMBER 'ROLE_NHANVIEN', 'US_NHANVIEN_1';
GO
SP_ADDROLEMEMBER 'ROLE_NHANVIEN', 'US_NHANVIEN_2';
GO
SP_ADDROLEMEMBER 'ROLE_NHANVIEN', 'US_NHANVIEN_3';
GO
SP_ADDROLEMEMBER 'ROLE_NHANVIEN', 'US_NHANVIEN_4';

