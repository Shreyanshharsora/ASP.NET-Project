
create table tblUsers
(
Uid int identity(1,1) primary key not null,
Username nvarchar(100)Null, 
Password nvarchar(100)Null,
Email nvarchar(100)Null,
Name nvarchar(100)Null,
Usertype nvarchar(50) default 'User'
)
insert into tblUsers Values('ssuthar','Sh@8866178118','shreyanshharsora@gmail.com','Shreyansh Suthar','User')
insert into tblUsers Values('user','123','user@yahoo.com','Test_user','User')

select * from tblUsers







select * from tblUsers 




create table ForgotPass
(
Id nvarchar (500)  not null,
Uid int null,
RequestDateTime DATETIME null,
Constraint [FK_ForgotPass_tblUsers] FOREIGN KEY ([Uid]) REFERENCES [tblUsers] ([Uid])

)

select * from ForgotPass
delete from ForgotPass



create table tblBrands
(
BrandID int identity(1,1) primary key,
Name   nvarchar(500)

)

create table tblCategory
(
CatID int identity(1,1) primary key,
CatName   nvarchar(MAX)

)


create table tblSubCategory
(
SubCatID int identity(1,1) primary key,
SubCatName   nvarchar(MAX),
MainCatID int null,
Constraint [FK_tblSubCategory_tblCategory] FOREIGN KEY ([MainCatID]) REFERENCES [tblCategory] ([CatID])
)

create table tblGender
(
GenderID int identity(1,1) primary key,
GenderName   nvarchar(MAX)

)


create table tblSizes
(
SizeID int identity(1,1) primary key,
SizeName   nvarchar(500),
BrandID int,
CategoryID int,
SubCategoryID int,
GenderID int,
Constraint [FK_tblSizes_ToBrand] FOREIGN KEY ([BrandID]) REFERENCES [tblBrands] ([BrandID]),
Constraint [FK_tblSizes_ToCat] FOREIGN KEY ([CategoryID]) REFERENCES [tblCategory] ([CatID]),
Constraint [FK_tblSizes_SubCat] FOREIGN KEY ([SubCategoryID]) REFERENCES [tblSubCategory] ([SubCatID]),
Constraint [FK_tblSizes_Gender] FOREIGN KEY ([GenderID]) REFERENCES [tblGender] ([GenderID])

)



create table tblProducts
(
PID int identity(1,1) primary key,
PName   nvarchar(MAX),
PPrice money,
PSelPrice money,
PBrandID int,
PCategoryID int,
PSubCatID int,
PGender int,

PDescription nvarchar(MAX),
PProductDetails nvarchar(MAX),
PMaterialCare  nvarchar(MAX),
FreeDelivery int,
[30DayRet]  int,
COD       int,
Constraint [FK_tblProducts_ToTable] FOREIGN KEY ([PBrandID]) REFERENCES [tblBrands] ([BrandID]),
Constraint [FK_tblProducts_ToTable1] FOREIGN KEY ([PCategoryID]) REFERENCES [tblCategory] ([CatID]),
Constraint [FK_tblProducts_ToTable2] FOREIGN KEY ([PSubCatID]) REFERENCES [tblSubCategory] ([SubCatID]),
Constraint [FK_tblProducts_ToTable3] FOREIGN KEY ([PGender]) REFERENCES [tblGender] ([GenderID])


)


create table tblProductImages
(
PIMGID int identity(1,1) primary key,
PID   int,
Name nvarchar(MAX),
Extention nvarchar(500),
Constraint [FK_tblProductImages_ToTable] FOREIGN KEY ([PID]) REFERENCES [tblProducts] ([PID]),
)

create table tblProductSizeQuantity
(
PrdSizeQuantID int identity(1,1) primary key,
PID int,
SizeID int,
Quantity int,
Constraint [FK_tblProductSizeQuantity_ToTable] FOREIGN KEY ([PID]) REFERENCES [tblProducts] ([PID]),
Constraint [FK_tblProductSizeQuantity_ToTable1] FOREIGN KEY ([SizeID]) REFERENCES [tblSizes] ([SizeID])
)












select A.*,B.* from tblSubCategory A with(nolock) inner join tblCategory B on B.CatID  =A.MainCatID 


select A.*,B.*,C.*,D.*,E.* from tblSizes A with(nolock) inner join tblCategory B on B.CatID =a.CategoryID  inner join tblBrands C on C.BrandID =A.BrandID inner join tblSubCategory D on D.SubCatID =A.SubCategoryID inner join tblGender E on E.GenderID =A.GenderID 










select * from tblProducts

Create procedure sp_InsertProduct
(
@PName nvarchar(MAX),
@PPrice money,
@PSelPrice money,
@PBrandID int,
@PCategoryID int,
@PSubCatID int,
@PGender int,
@PDescription nvarchar(MAX),
@PProductDetails nvarchar(MAX),
@PMaterialCare nvarchar(MAX),
@FreeDelivery int,
@30DayRet int,
@COD int
)
AS

insert into tblProducts values(@PName,@PPrice,@PSelPrice,@PBrandID,@PCategoryID,
@PSubCatID,@PGender,@PDescription,@PProductDetails,@PMaterialCare,@FreeDelivery,
@30DayRet,@COD) 
select SCOPE_IDENTITY()
Return 0




select * from tblProductImages
select * from tblProductSizeQuantity
select * from tblProducts

create procedure procBindAllProducts
AS
select A.*,B.*,C.Name ,A.PPrice-A.PSelPrice as DiscAmount,B.Name as ImageName, C.Name as BrandName from tblProducts A
inner join tblBrands C on C.BrandID =A.PBrandID
cross apply(
select top 1 * from tblProductImages B where B.PID= A.PID order by B.PID desc
)B
order by A.PID desc

Return 0


select * from tblProductImages
select * from tblProductSizeQuantity
select * from tblProducts


   
   create function getSizeName
   
   (
   @SizeID int
   )
   RETURNS Nvarchar(10)
   as
   Begin
   Declare @SizeName nvarchar(10)
   select @SizeName=SizeName from tblSizes where SizeID=@SizeID
   RETURN @SizeName
   
   End
   
   
   
   create table tblPurchase
(
PurchaseID int identity(1,1) primary key,
UserID int,
PIDSizeID nvarchar(MAX),
CartAmount money,
CartDiscount money,
TotalPayed money,
PaymentType nvarchar(50),
PaymentStatus nvarchar(50),
DateOfPurchase datetime,
Name nvarchar(200),
Address nvarchar(MAX),
PinCode nvarchar(10),
MobileNumber nvarchar(50),
CONSTRAINT [FK_tblPurchase_ToUser] FOREIGN KEY ([UserID]) REFERENCES [tblUsers]([UID])

)