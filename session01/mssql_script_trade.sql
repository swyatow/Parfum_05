use master;
create database Parfum
go
use Parfum
go
create table [Role]
(
	RoleID int primary key identity,
	RoleName nvarchar(100) not null
)
go
insert into [Role] values('Клиент');
insert into [Role] values('Менеджер');
insert into [Role] values('Администратор');
go
create table [User]
(
	UserID int primary key identity,
	UserSurname nvarchar(100) not null,
	UserName nvarchar(100) not null,
	UserPatronymic nvarchar(100) not null,
	UserLogin nvarchar(max) not null,
	UserPassword nvarchar(max) not null,
	UserRole int foreign key references [Role](RoleID) not null
)
go
create table PickupPoint(
	ppID int primary key identity,
	ppAdress nvarchar(100) not null,
);
create table OrderStatus(
	osID int primary key identity,
	osName nvarchar(100) not null,
);
insert into OrderStatus values('Новый');
insert into OrderStatus values('Завершен');
create table [Order]
(
	OrderID int primary key identity,
	OrderOrderDate datetime not null,
	OrderDeliveryDate datetime not null,
	OrderPickupPoint int foreign key references PickupPoint(ppId) not null,
	OrderClient int foreign key references [User](UserID) null,
	OrderPickupCode int not null,
	OrderStatus int foreign key references OrderStatus(osID) not null,
)
go
create table Manufacturer(
	mfID int primary key identity,
	mfName nvarchar(100) not null,
);
create table [Provider](
	pvID int primary key identity,
	pvName nvarchar(100) not null,
);
create table Category(
	ctID int primary key identity,
	ctName nvarchar(100) not null,
);
create table Product
(
	ProductArticle nvarchar(100) primary key,
	ProductName nvarchar(max) not null,
	ProductEdIzm nvarchar(max) not null,
	ProductPrice decimal(19,4) not null,
	ProductMaxSale int not null,
	ProductManufacturer int foreign key references Manufacturer(mfID) not null,
	ProductProvider int foreign key references [Provider](pvID) not null,
	ProductCategory int foreign key references [Category](ctID) not null,
	ProductCurrentSale int not null,
	ProductCount int not null,
	ProductDescription nvarchar(max) not null,
	ProductImage nvarchar(max) null
)
go
create table OrderProduct
(
	opID int primary key identity,
	OrderID int foreign key references [Order](OrderID) not null,
	ProductArticle nvarchar(100) foreign key references Product(ProductArticle) not null,
	ProductAmount int not null,
)
