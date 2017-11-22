



CREATE DATABASE AdventureWorks2012 
    ON (FILENAME = 'E:\AdventureWorks2012_Database\AdventureWorks2012_Data.mdf'),   
    (FILENAME = 'E:\AdventureWorks2012_Database\AdventureWorks2012_log.ldf')   
    FOR ATTACH;  
	
CREATE DATABASE ERPDatabase
    ON (FILENAME = 'E:\ERP\ERPData\ERPDatabase.mdf'),   
    (FILENAME = 'E:\ERP\ERPData\ERPDatabase_log.ldf')   
    FOR ATTACH;  

Use AdventureWorks2012

drop DATABASE SaleACBComputer;
use AdventureWorks2012
select * from Sales.SalesPerson sale
join Person.BusinessEntity bs on  sale.BusinessEntityID = bs.BusinessEntityID
join HumanResources.Employee emp on bs.BusinessEntityID = emp.BusinessEntityID
join Person.Person person on person.BusinessEntityID = bs.BusinessEntityID

CREATE DATABASE SaleACBComputer
use SaleACBComputer
GO;
CREATE SCHEMA [Person]
CREATE SCHEMA [HumanResources]
CREATE SCHEMA [Product]
CREATE SCHEMA [Vendor]
CREATE SCHEMA [Sales]
CREATE SCHEMA [Location]
CREATE SCHEMA [Purchasing]

Use master
EXEC sp_MSforeachtable @command1 = "DROP TABLE ?"
-- DROP TABLE---
 
-- DROP TABLE Person.AddressType;
-- DROP TABLE Person.Address;
-- DROP TABLE Person.ContactType;
-- DROP TABLE Person.BusinessEntity

-- DROP TABLE HumanResources.Employee;
-- DROP TABLE Sales.Customer;
-- DROP TABLE Sales.SalesOrderHeader;
-- DROP TABLE Location.Ward;
-- DROP TABLE Location.District;
-- DROP TABLE Location.Province;

-- DROP TABLE Product.UnitMeasure;
-- DROP TABLE Product.Product;
-- DROP TABLE Purchasing.Vendor
-- DROP TABLE Purchasing.PurchaseOrderHeader;

-- DROP TABLE [Location].Ward

-- -- Drop Schema---
-- Drop Schema Sale
-- --Person--


CREATE TABLE [Person].[BusinessEntity] (
    [BusinessEntityID] INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [rowguid]          UNIQUEIDENTIFIER CONSTRAINT [DF_BusinessEntity_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate]     DATETIME         CONSTRAINT [DF_BusinessEntity_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_BusinessEntity] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC)
);

CREATE TABLE [Person].[Person] (
    [BusinessEntityID]      INT                                                           NOT NULL,
    [PersonType]            NCHAR (2)                                                     NOT NULL,
    [Title]                 NVARCHAR (8)                                                  NULL,
    [FirstName]             NVARCHAR (100)                                                NOT NULL,
    [MiddleName]            NVARCHAR (100)                                                NULL,
    [LastName]              NVARCHAR (100)                                                NOT NULL,
    [Avatar]                NVARCHAR (300)                                                NULL,
    [rowguid]               UNIQUEIDENTIFIER                                              CONSTRAINT [DF_Person_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate]          DATETIME                                                      CONSTRAINT [DF_Person_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Person_BusinessEntityID] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC),
    CONSTRAINT [FK_Person_BusinessEntity_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[BusinessEntity] ([BusinessEntityID]),
    CONSTRAINT [CK_Person_PersonType] CHECK ([PersonType] IS NULL OR (upper([PersonType])='SP' OR upper([PersonType])='GC' OR upper([PersonType])='EM'  OR upper([PersonType])='IN'))
);

 --Location---
 CREATE TABLE [Location].[Province]
 (
	[ProvinceID]	nvarchar(10) NOT NULL,
	[ProvinceName]	nvarchar(50) NOT NULL,
	[EnglishName]	nvarchar(50) NULL,
	[Level]			nvarchar(50) NULL,
	[ModifiedDate]  DATETIME       CONSTRAINT [DF_Province_ModifiedDate] DEFAULT (getdate()) NOT NULL,

	 CONSTRAINT [PK_ProvinceID] PRIMARY KEY CLUSTERED ([ProvinceID] ASC)
 )
  CREATE TABLE [Location].[District]
 (
	[DistrictID]	nvarchar(10) NOT NULL,
	[ProvinceID]	nvarchar(10) NOT NULL,
	[DistrictName]	nvarchar(50) NOT NULL,
	[EnglishName]	nvarchar(50) NULL,
	[Level]			nvarchar(50) NULL,
	[ModifiedDate]          DATETIME       CONSTRAINT [DF_District_ModifiedDate] DEFAULT (getdate()) NOT NULL,
	CONSTRAINT [PK_District_DistrictID] PRIMARY KEY CLUSTERED ([DistrictID] ASC),
	CONSTRAINT [FK_District_ProvinceID] FOREIGN KEY ([ProvinceID]) REFERENCES [Location].[Province] ([ProvinceID]),
 )

   CREATE TABLE [Location].[Ward]
 (
	[WardID]		nvarchar(10) NOT NULL,
	[DistrictID]	nvarchar(10) NOT NULL,
	[WardName]		nvarchar(50) NOT NULL,
	[EnglishName]	nvarchar(50) NULL,
	[Level]			nvarchar(50) NULL,
	[ModifiedDate]          DATETIME       CONSTRAINT [DF_Ward_ModifiedDate] DEFAULT (getdate()) NOT NULL,
	CONSTRAINT [PK_Ward_WradID] PRIMARY KEY CLUSTERED ([WardID] ASC),
	CONSTRAINT [FK_Ward_DistrictID] FOREIGN KEY ([WardID]) REFERENCES [Location].[District] ([DistrictID]),
 )


 -- Person---
CREATE TABLE [Person].[Address] (
    [AddressID]       INT               IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [AddressLine]    NVARCHAR (60)     NOT NULL,
    [WardID]          nvarchar(10)      NULL,
    [PostalCode]      NVARCHAR (15)     NOT NULL,
    [SpatialLocation] [sys].[geography] NULL,
    [rowguid]         UNIQUEIDENTIFIER  CONSTRAINT [DF_Address_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate]    DATETIME          CONSTRAINT [DF_Address_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_PersonAddress_AddressID] PRIMARY KEY CLUSTERED ([AddressID] ASC),
	CONSTRAINT [FK_Ward_WardID] FOREIGN KEY ([WardID]) REFERENCES [Location].[Ward] ([WardID])
);
 CREATE TABLE [Person].[AddressType] (
    [AddressTypeID] INT              IDENTITY (1, 1) NOT NULL,
    [Name]          NVARCHAR (250)   NOT NULL,
    [rowguid]       UNIQUEIDENTIFIER CONSTRAINT [DF_AddressType_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate]  DATETIME         CONSTRAINT [DF_AddressType_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Address_AddressID] PRIMARY KEY CLUSTERED ([AddressTypeID] ASC)	
);


CREATE TABLE [Person].[BusinessEntityAddress] (
    [BusinessEntityID] INT              NOT NULL,
    [AddressID]        INT              NOT NULL,
    [AddressTypeID]    INT              NOT NULL,
    [rowguid]          UNIQUEIDENTIFIER CONSTRAINT [DF_BusinessEntityAddress_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate]     DATETIME         CONSTRAINT [DF_BusinessEntityAddress_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressTypeID] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC, [AddressID] ASC, [AddressTypeID] ASC),
    CONSTRAINT [FK_BusinessEntityAddress_Address] FOREIGN KEY ([AddressID]) REFERENCES [Person].[Address] ([AddressID]),
    CONSTRAINT [FK_BusinessEntityAddress_AddressType] FOREIGN KEY ([AddressTypeID]) REFERENCES [Person].[AddressType] ([AddressTypeID]),
    CONSTRAINT [FK_BusinessEntityAddress_BusinessEntity1] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[BusinessEntity] ([BusinessEntityID])
);

CREATE TABLE [Person].[ContactType] (
    [ContactTypeID] INT            IDENTITY (1, 1) NOT NULL,
    [Name]          NVARCHAR (100) NOT NULL,
    [ModifiedDate]  DATETIME       CONSTRAINT [DF_ContactType_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ContactType_ContactTypeID] PRIMARY KEY CLUSTERED ([ContactTypeID] ASC)
);


CREATE TABLE [Person].[BusinessEntityContact] (
    [BusinessEntityID] INT              NOT NULL,
    [PersonID]         INT              NOT NULL,
    [ContactTypeID]    INT              NOT NULL,
    [rowguid]          UNIQUEIDENTIFIER CONSTRAINT [DF_BusinessEntityContact_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate]     DATETIME         CONSTRAINT [DF_BusinessEntityContact_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeID] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC, [PersonID] ASC, [ContactTypeID] ASC),
    CONSTRAINT [FK_BusinessEntityContact_BusinessEntity] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[BusinessEntity] ([BusinessEntityID]),
    CONSTRAINT [FK_BusinessEntityContact_ContactType] FOREIGN KEY ([ContactTypeID]) REFERENCES [Person].[ContactType] ([ContactTypeID])
);

CREATE TABLE [Person].[Phone] (
    [PhoneID]      INT           IDENTITY (1, 1) NOT NULL,
    [PhoneNumber]  NVARCHAR (25) NOT NULL,
	[Email]  NVARCHAR (25) NOT NULL,
    [ModifiedDate] DATETIME      CONSTRAINT [DF_PersonPhone_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_PersonPhone_BusinessEntityID_EntityPhone_PhoneNumberTypeID] PRIMARY KEY CLUSTERED ([PhoneID] ASC)
);
CREATE TABLE [Person].[PhoneNumberType] (
    [PhoneNumberTypeID] INT           IDENTITY (1, 1) NOT NULL,
    [Name]              NVARCHAR (70) NOT NULL,
    [ModifiedDate]      DATETIME      CONSTRAINT [DF_PhoneNumberType_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_PhoneNumberType_PhoneNumberTypeID] PRIMARY KEY CLUSTERED ([PhoneNumberTypeID] ASC)
);
-- Person---
CREATE TABLE [Person].[Password] (
    [BusinessEntityID] INT              NOT NULL,
    [PasswordHash]     VARCHAR (128)    NOT NULL,
    [PasswordSalt]     VARCHAR (10)     NOT NULL,
    [rowguid]          UNIQUEIDENTIFIER CONSTRAINT [DF_Password_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate]     DATETIME         CONSTRAINT [DF_Password_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Password_BusinessEntityID] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC),
    CONSTRAINT [FK_Password_Person] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[Person] ([BusinessEntityID])
);

-- HumanResources---
CREATE TABLE [HumanResources].[Employee] (
    [BusinessEntityID]  INT                 NOT NULL,
    [NationalIDNumber]  NVARCHAR (15)       NOT NULL,
    [LoginID]           NVARCHAR (256)       NOT NULL,
    [JobTitle]          NVARCHAR (50)       NOT NULL,
    [Position]          NVARCHAR (50)       NOT NULL,
    [BirthDate]         DATE                NOT NULL,
    [MaritalStatus]     NCHAR (1)           NOT NULL,
    [Gender]            NCHAR (1)           NOT NULL,
    [HireDate]          DATE                NOT NULL,
    [LeaveDate]         DATE                NULL,
    [rowguid]           UNIQUEIDENTIFIER    CONSTRAINT [DF_Employee_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate]      DATETIME            CONSTRAINT [DF_Employee_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC),
    CONSTRAINT [FK_Employee_Person] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[Person] ([BusinessEntityID]),
	CONSTRAINT [CK_Employee_BirthDate] CHECK ([BirthDate]>='1930-01-01' AND [BirthDate]<=dateadd(year,(-15),getdate())),
    CONSTRAINT [CK_Employee_MaritalStatus] CHECK (upper([MaritalStatus])='S' OR upper([MaritalStatus])='M'),
    CONSTRAINT [CK_Employee_HireDate] CHECK ([HireDate]>='1996-07-01' AND [HireDate]<=dateadd(day,(1),getdate())),
    CONSTRAINT [CK_Employee_Gender] CHECK (upper([Gender])='F' OR upper([Gender])='M'),
);


-- Product--- 
CREATE TABLE [Product].[UnitMeasure] (
    [UnitMeasureCode] NCHAR (3)    NOT NULL,
    [Name]            NVARCHAR (256) NOT NULL,
    [ModifiedDate]    DATETIME     CONSTRAINT [DF_UnitMeasure_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_UnitMeasure_UnitMeasureCode] PRIMARY KEY CLUSTERED ([UnitMeasureCode] ASC)
);
GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_UnitMeasure_Name]
    ON [Product].[UnitMeasure]([Name] ASC);


-- Drop table Product--
drop table [Product].Product


CREATE TABLE [Product].[ProductCategory] (
    [ProductCategoryID] INT              IDENTITY (1, 1) NOT NULL,
    [Name]              NVARCHAR (256)     NOT NULL,
    [rowguid]           UNIQUEIDENTIFIER CONSTRAINT [DF_ProductCategory_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate]      DATETIME         CONSTRAINT [DF_ProductCategory_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProductCategory_ProductCategoryID] PRIMARY KEY CLUSTERED ([ProductCategoryID] ASC)
);


CREATE TABLE [Product].[Product] (
    [ProductID]             INT              IDENTITY (1, 1) NOT NULL,
    [Name]                  NVARCHAR (256)   NOT NULL,
	[ProductCategoryID]		INT			     NOT NULL,
	[ProductNumber]         NVARCHAR (25)    NULL,
	[Color]                 NVARCHAR (15)    NULL,
    [SafetyStockLevel]      SMALLINT         NOT NULL,
    [Quantity]              INT              NOT NULL,
    [ListPrice]             MONEY            NOT NULL,
    [SizeUnitMeasureCode]   NCHAR (3)        NULL,
    [Descriptions]          NVARCHAR (256)   NULL,
    [Tags]                  NVARCHAR (100)   NULL,
    [rowguid]               UNIQUEIDENTIFIER CONSTRAINT [DF_Product_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate]          DATETIME         CONSTRAINT [DF_Product_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Product_ProductID] PRIMARY KEY CLUSTERED ([ProductID] ASC),
    CONSTRAINT [FK_Product_UnitMeasure_SizeUnitMeasureCode] FOREIGN KEY ([SizeUnitMeasureCode]) REFERENCES [Product].[UnitMeasure] ([UnitMeasureCode]),
	CONSTRAINT [FK_Product_ProductCateogry_ProductCategoryID] FOREIGN KEY ([ProductCategoryID]) REFERENCES [Product].[ProductCategory] ([ProductCategoryID]),
    CONSTRAINT [CK_Product_ListPrice] CHECK ([ListPrice]>=(0.00)),
    CONSTRAINT [CK_Product_SafetyStockLevel] CHECK ([SafetyStockLevel]>(0))
);

CREATE TABLE [Product].[ProductListPriceHistory] (
    [ProductID]    INT      NOT NULL,
	[Name]         NVARCHAR (256) NOT NULL,
    [StartDate]    DATETIME NOT NULL,
    [EndDate]      DATETIME NULL,
    [ListPrice]    MONEY    NOT NULL,
	[Status]	   BIT CONSTRAINT[DF_ProductListHistory_Status] DEFAULT (1) NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_ProductListPriceHistory_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProductListPriceHistory_ProductID_StartDate] PRIMARY KEY CLUSTERED ([ProductID] ASC, [StartDate] ASC),
    CONSTRAINT [FK_ProductListPriceHistory_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Product].[Product] ([ProductID]),
    CONSTRAINT [CK_ProductListPriceHistory_ListPrice] CHECK ([ListPrice]>(0.00)),
    CONSTRAINT [CK_ProductListPriceHistory_EndDate] CHECK ([EndDate]>=[StartDate] OR [EndDate] IS NULL)
);

-- TRANSACTION HISTORY
CREATE TABLE [Production].[TransactionHistory] (
    [TransactionID]        INT       IDENTITY (100000, 1) NOT NULL,
    [ProductID]            INT       NOT NULL,
    [ReferenceOrderID]     INT       NOT NULL,
    [TransactionDate]      DATETIME  CONSTRAINT [DF_TransactionHistory_TransactionDate] DEFAULT (getdate()) NOT NULL,
    [TransactionType]      NCHAR (1) NOT NULL,
    [Quantity]             INT       NOT NULL,
    [ActualCost]           MONEY     NOT NULL,
    [ModifiedDate]         DATETIME  CONSTRAINT [DF_TransactionHistory_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_TransactionHistory_TransactionID] PRIMARY KEY CLUSTERED ([TransactionID] ASC),
    CONSTRAINT [FK_TransactionHistory_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product] ([ProductID]),
    CONSTRAINT [CK_TransactionHistory_TransactionType] CHECK (upper([TransactionType])='P' OR upper([TransactionType])='S')
);


GO
CREATE NONCLUSTERED INDEX [IX_TransactionHistory_ProductID]
    ON [Production].[TransactionHistory]([ProductID] ASC);



---SALE ---
CREATE TABLE [Sales].[Customer] (
    [CustomerID]    INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [PersonID]      INT              NULL,
    [rowguid]       UNIQUEIDENTIFIER CONSTRAINT [DF_Customer_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate]  DATETIME         CONSTRAINT [DF_Customer_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Customer_CustomerID] PRIMARY KEY CLUSTERED ([CustomerID] ASC),
    CONSTRAINT [FK_Customer_Person_PersonID] FOREIGN KEY ([PersonID]) REFERENCES [Person].[Person] ([BusinessEntityID]),
);
--Module bán hàng--
CREATE TABLE [Sales].[SalesOrderHeader] (
    [SalesOrderID]           INT                   IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [OrderDate]              DATETIME              CONSTRAINT [DF_SalesOrderHeader_OrderDate] DEFAULT (getdate()) NOT NULL,
    [DueDate]                DATETIME              NOT NULL, -- Ngày giao khách hàng (Use online) nếu orderDate = DueDate thì bán hàng trực tiếp
    [ShipDate]               DATETIME              NULL,
    [Status]                 TINYINT               CONSTRAINT [DF_SalesOrderHeader_Status] DEFAULT ((1)) NOT NULL,
    [OnlineOrderFlag]        BIT					CONSTRAINT [DF_SalesOrderHeader_OnlineOrderFlag] DEFAULT ((1)) NOT NULL,
    [SalesOrderNumber]       AS                    (isnull(N'SO'+CONVERT([nvarchar](23),[SalesOrderID]),N'*** ERROR ***')),
    [CustomerID]             INT                   NOT NULL,
    [SalesPersonID]          INT                   NULL, -- Mã người bán
    [SubTotal]               MONEY                 CONSTRAINT [DF_SalesOrderHeader_SubTotal] DEFAULT ((0.00)) NOT NULL,
    [TaxAmt]                 MONEY                 CONSTRAINT [DF_SalesOrderHeader_TaxAmt] DEFAULT ((0.00)) NOT NULL,
    [Freight]                MONEY                 CONSTRAINT [DF_SalesOrderHeader_Freight] DEFAULT ((0.00)) NOT NULL, -- Phí vận chuyển
    [TotalDue]               AS                    (isnull(([SubTotal]+[TaxAmt])+[Freight],(0))),
    [Comment]                NVARCHAR (128)        NULL,
    [rowguid]                UNIQUEIDENTIFIER      CONSTRAINT [DF_SalesOrderHeader_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate]           DATETIME              CONSTRAINT [DF_SalesOrderHeader_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_SalesOrderHeader_SalesOrderID] PRIMARY KEY CLUSTERED ([SalesOrderID] ASC),
    CONSTRAINT [FK_SalesOrderHeader_Customer_CustomerID] FOREIGN KEY ([CustomerID]) REFERENCES [Sales].[Customer] ([CustomerID]),
    CONSTRAINT [FK_SalesOrderHeader_Employee_SalesPersonID] FOREIGN KEY ([SalesPersonID]) REFERENCES [HumanResources].[Employee] ([BusinessEntityID]),
    CONSTRAINT [CK_SalesOrderHeader_ShipDate] CHECK ([ShipDate]>=[OrderDate] OR [ShipDate] IS NULL),
    CONSTRAINT [CK_SalesOrderHeader_SubTotal] CHECK ([SubTotal]>=(0.00)),
    CONSTRAINT [CK_SalesOrderHeader_TaxAmt]   CHECK ([TaxAmt]>=(0.00)),
    CONSTRAINT [CK_SalesOrderHeader_Freight] CHECK ([Freight]>=(0.00))
);

CREATE TABLE [Sales].[SalesOrderDetail] (
    [SalesOrderID]          INT              NOT NULL,
    [SalesOrderDetailID]    INT              IDENTITY (1, 1) NOT NULL,
    [OrderQty]              SMALLINT         NOT NULL,
    [ProductID]             INT              NOT NULL,
    [UnitPrice]             MONEY            NOT NULL, -- Nhập từ ProductListPriceHistory
    [UnitPriceDiscount]     MONEY            CONSTRAINT [DF_SalesOrderDetail_UnitPriceDiscount] DEFAULT ((0.0)) NOT NULL, -- Đơn vị tính %
    [LineTotal]             AS               (isnull(([UnitPrice]*((1.0)-[UnitPriceDiscount]))*[OrderQty],(0.0))),
    [rowguid]               UNIQUEIDENTIFIER CONSTRAINT [DF_SalesOrderDetail_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate]          DATETIME         CONSTRAINT [DF_SalesOrderDetail_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID] PRIMARY KEY CLUSTERED ([SalesOrderID] ASC, [SalesOrderDetailID] ASC),
    CONSTRAINT [FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID] FOREIGN KEY ([SalesOrderID]) REFERENCES [Sales].[SalesOrderHeader] ([SalesOrderID]) ON DELETE CASCADE,
    CONSTRAINT [CK_SalesOrderDetail_OrderQty] CHECK ([OrderQty]>(0)),
    CONSTRAINT [CK_SalesOrderDetail_UnitPrice] CHECK ([UnitPrice]>=(0.00)),
    CONSTRAINT [CK_SalesOrderDetail_UnitPriceDiscount] CHECK ([UnitPriceDiscount]>=(0.00))
);

---Vendor----
CREATE TABLE [Purchasing].[Vendor] (
    [BusinessEntityID]        INT                   NOT NULL, -- Sử dụng ID này để lấy ra tên người quản lý, sđt, địa chỉ nhà cung cấp
    [AccountNumber]			  NVARCHAR(20)   		 NOT NULL,
    [Name]                    NVARCHAR (256)          NOT NULL,-- Tên Nhà Cung cấp
    [CreditRating]            TINYINT               NOT NULL, -- Đánh giá nhà cung cấp 
    [ActiveFlag]              BIT          CONSTRAINT [DF_Vendor_ActiveFlag] DEFAULT ((1)) NOT NULL, -- Kiểm tra xem nhà cung cấp còn hoạt động hoặc nhập hàng không
    [PurchasingWebServiceURL] NVARCHAR (1024)       NULL,
    [ModifiedDate]            DATETIME              CONSTRAINT [DF_Vendor_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Vendor_BusinessEntityID] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC),
    CONSTRAINT [FK_Vendor_BusinessEntity_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[BusinessEntity] ([BusinessEntityID]),
    CONSTRAINT [CK_Vendor_CreditRating] CHECK ([CreditRating]>=(1) AND [CreditRating]<=(5))
);

CREATE TABLE [Purchasing].[ProductVendor] (
    [ProductID]        INT       NOT NULL,
    [BusinessEntityID] INT       NOT NULL,
    [StandardPrice]    MONEY     NOT NULL, -- Giá bán nhập hàng
    [OnOrderQty]       INT       NULL, -- Số lượng nhập
    [UnitMeasureCode]  NCHAR (3) NOT NULL,
    [ModifiedDate]     DATETIME  CONSTRAINT [DF_ProductVendor_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProductVendor_ProductID_BusinessEntityID] PRIMARY KEY CLUSTERED ([ProductID] ASC, [BusinessEntityID] ASC),
    CONSTRAINT [FK_ProductVendor_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product] ([ProductID]),
    CONSTRAINT [FK_ProductVendor_UnitMeasure_UnitMeasureCode] FOREIGN KEY ([UnitMeasureCode]) REFERENCES [Production].[UnitMeasure] ([UnitMeasureCode]),
    CONSTRAINT [FK_ProductVendor_Vendor_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Purchasing].[Vendor] ([BusinessEntityID]),
    CONSTRAINT [CK_ProductVendor_StandardPrice] CHECK ([StandardPrice]>(0.00)),
    CONSTRAINT [CK_ProductVendor_OnOrderQty] CHECK ([OnOrderQty]>=(0))
);


CREATE TABLE [Purchasing].[PurchaseOrderHeader] (
    [PurchaseOrderID] INT      IDENTITY (1, 1) NOT NULL,
    [Status]          TINYINT  CONSTRAINT [DF_PurchaseOrderHeader_Status] DEFAULT ((1)) NOT NULL,
    [EmployeeID]      INT      NOT NULL,
    [VendorID]        INT      NOT NULL,
    [OrderDate]       DATETIME CONSTRAINT [DF_PurchaseOrderHeader_OrderDate] DEFAULT (getdate()) NOT NULL,
    [ShipDate]        DATETIME NULL,
    [SubTotal]        MONEY    CONSTRAINT [DF_PurchaseOrderHeader_SubTotal] DEFAULT ((0.00)) NOT NULL,
    [TaxAmt]          MONEY    CONSTRAINT [DF_PurchaseOrderHeader_TaxAmt] DEFAULT ((0.00)) NOT NULL,
    [Freight]         MONEY    CONSTRAINT [DF_PurchaseOrderHeader_Freight] DEFAULT ((0.00)) NOT NULL,
    [TotalDue]        AS       (isnull(([SubTotal]+[TaxAmt])+[Freight],(0))) PERSISTED NOT NULL,
    [ModifiedDate]    DATETIME CONSTRAINT [DF_PurchaseOrderHeader_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_PurchaseOrderHeader_PurchaseOrderID] PRIMARY KEY CLUSTERED ([PurchaseOrderID] ASC),
    CONSTRAINT [FK_PurchaseOrderHeader_Employee_EmployeeID] FOREIGN KEY ([EmployeeID]) REFERENCES [HumanResources].[Employee] ([BusinessEntityID]),
    CONSTRAINT [FK_PurchaseOrderHeader_Vendor_VendorID] FOREIGN KEY ([VendorID]) REFERENCES [Purchasing].[Vendor] ([BusinessEntityID]),
    CONSTRAINT [CK_PurchaseOrderHeader_Status] CHECK ([Status]>=(1) AND [Status]<=(4)),
    CONSTRAINT [CK_PurchaseOrderHeader_ShipDate] CHECK ([ShipDate]>=[OrderDate] OR [ShipDate] IS NULL),
    CONSTRAINT [CK_PurchaseOrderHeader_SubTotal] CHECK ([SubTotal]>=(0.00)),
    CONSTRAINT [CK_PurchaseOrderHeader_Freight] CHECK ([Freight]>=(0.00))
);

CREATE TABLE [Purchasing].[PurchaseOrderDetail] (
    [PurchaseOrderID]       INT            NOT NULL,
    [PurchaseOrderDetailID] INT            IDENTITY (1, 1) NOT NULL,
    [OrderQty]              SMALLINT       NOT NULL,
    [ProductID]             INT            NOT NULL,
    [UnitPrice]             MONEY          NOT NULL,
    [LineTotal]             AS             (isnull([OrderQty]*[UnitPrice],(0.00))),
    [ReceivedQty]           DECIMAL (8, 2) NOT NULL,
    [RejectedQty]           DECIMAL (8, 2) NOT NULL,
    [StockedQty]            AS             (isnull([ReceivedQty]-[RejectedQty],(0.00))),
    [ModifiedDate]          DATETIME       CONSTRAINT [DF_PurchaseOrderDetail_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID] PRIMARY KEY CLUSTERED ([PurchaseOrderID] ASC, [PurchaseOrderDetailID] ASC),
    CONSTRAINT [FK_PurchaseOrderDetail_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Product].[Product] ([ProductID]),
    CONSTRAINT [FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID] FOREIGN KEY ([PurchaseOrderID]) REFERENCES [Purchasing].[PurchaseOrderHeader] ([PurchaseOrderID]),
    CONSTRAINT [CK_PurchaseOrderDetail_UnitPrice] CHECK ([UnitPrice]>=(0.00)),
    CONSTRAINT [CK_PurchaseOrderDetail_OrderQty] CHECK ([OrderQty]>(0)),
    CONSTRAINT [CK_PurchaseOrderDetail_ReceivedQty] CHECK ([ReceivedQty]>=(0.00)),
    CONSTRAINT [CK_PurchaseOrderDetail_RejectedQty] CHECK ([RejectedQty]>=(0.00))
);



CREATE TABLE [Production].[ProductPhoto] (
    [ProductPhotoID]         INT             IDENTITY (1, 1) NOT NULL,
    [ThumbNailPhoto]         VARBINARY (MAX) NULL,
    [ThumbnailPhotoFileName] NVARCHAR (50)   NULL,
    [LargePhoto]             VARBINARY (MAX) NULL,
    [LargePhotoFileName]     NVARCHAR (50)   NULL,
    [ModifiedDate]           DATETIME        CONSTRAINT [DF_ProductPhoto_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProductPhoto_ProductPhotoID] PRIMARY KEY CLUSTERED ([ProductPhotoID] ASC)
);

CREATE TABLE [Production].[ProductProductPhoto] (
    [ProductID]      INT          NOT NULL,
    [ProductPhotoID] INT          NOT NULL,
    [Primary]        [dbo].[Flag] CONSTRAINT [DF_ProductProductPhoto_Primary] DEFAULT ((0)) NOT NULL,
    [ModifiedDate]   DATETIME     CONSTRAINT [DF_ProductProductPhoto_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProductProductPhoto_ProductID_ProductPhotoID] PRIMARY KEY NONCLUSTERED ([ProductID] ASC, [ProductPhotoID] ASC),
    CONSTRAINT [FK_ProductProductPhoto_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product] ([ProductID]),
    CONSTRAINT [FK_ProductProductPhoto_ProductPhoto_ProductPhotoID] FOREIGN KEY ([ProductPhotoID]) REFERENCES [Production].[ProductPhoto] ([ProductPhotoID])
);


-- list all database--

EXEC sp_databases
use MyAdventureWorks;

-- list all tables in Database--
  
SELECT * from [Production].[ProductReview]