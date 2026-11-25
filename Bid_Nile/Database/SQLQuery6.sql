
USE BidNile;
GO


ALTER TABLE Core.Member
ADD CONSTRAINT FK_Member_City
FOREIGN KEY (CityId) REFERENCES Core.City(CityId);
GO

ALTER TABLE Core.Member
ADD CONSTRAINT FK_Member_InvitedByMember
FOREIGN KEY (InvitedByMemberId) REFERENCES Core.Member(MemberId);
GO


ALTER TABLE Core.Wallet
ADD CONSTRAINT FK_Wallet_Member
FOREIGN KEY (MemberId) REFERENCES Core.Member(MemberId);
GO


ALTER TABLE Logistics.Warehouse
ADD CONSTRAINT FK_Warehouse_City
FOREIGN KEY (CityId) REFERENCES Core.City(CityId);
GO

ALTER TABLE Logistics.Warehouse
ADD CONSTRAINT FK_Warehouse_Manager
FOREIGN KEY (ManagerMemberId) REFERENCES Logistics.Employee(MemberId);
GO


ALTER TABLE Logistics.Employee
ADD CONSTRAINT FK_Employee_Member
FOREIGN KEY (MemberId) REFERENCES Core.Member(MemberId);
GO

ALTER TABLE Logistics.Employee
ADD CONSTRAINT FK_Employee_Warehouse
FOREIGN KEY (WarehouseId) REFERENCES Logistics.Warehouse(WarehouseId);
GO


ALTER TABLE Catalog.Category
ADD CONSTRAINT FK_Category_ParentCategory
FOREIGN KEY (ParentCategoryId) REFERENCES Catalog.Category(CategoryId);
GO


ALTER TABLE Catalog.Item
ADD CONSTRAINT FK_Item_Seller
FOREIGN KEY (SellerMemberId) REFERENCES Core.Member(MemberId);
GO

ALTER TABLE Catalog.Item
ADD CONSTRAINT FK_Item_Inspector
FOREIGN KEY (InspectorMemberId) REFERENCES Logistics.Employee(MemberId);
GO

ALTER TABLE Catalog.Item
ADD CONSTRAINT FK_Item_Category
FOREIGN KEY (CategoryId) REFERENCES Catalog.Category(CategoryId);
GO

ALTER TABLE Catalog.Item
ADD CONSTRAINT FK_Item_Warehouse
FOREIGN KEY (WarehouseId) REFERENCES Logistics.Warehouse(WarehouseId);
GO

ALTER TABLE Catalog.ItemPhoto
ADD CONSTRAINT FK_ItemPhoto_Item
FOREIGN KEY (ItemId) REFERENCES Catalog.Item(ItemId)
ON DELETE CASCADE;
GO


ALTER TABLE Sales.Auction
ADD CONSTRAINT FK_Auction_Item
FOREIGN KEY (ItemId) REFERENCES Catalog.Item(ItemId);
GO


ALTER TABLE Sales.Bid
ADD CONSTRAINT FK_Bid_Auction
FOREIGN KEY (AuctionId) REFERENCES Sales.Auction(AuctionId);
GO

ALTER TABLE Sales.Bid
ADD CONSTRAINT FK_Bid_Member
FOREIGN KEY (MemberId) REFERENCES Core.Member(MemberId);
GO

ALTER TABLE Sales.AuctionFollow
ADD CONSTRAINT FK_AuctionFollow_Member
FOREIGN KEY (MemberId) REFERENCES Core.Member(MemberId);
GO

ALTER TABLE Sales.AuctionFollow
ADD CONSTRAINT FK_AuctionFollow_Auction
FOREIGN KEY (AuctionId) REFERENCES Sales.Auction(AuctionId);
GO


ALTER TABLE Core.Member
ADD AppLanguage CHAR(2) NOT NULL
    CONSTRAINT DF_Member_AppLanguage DEFAULT 'ar',
    CONSTRAINT CK_Member_AppLanguage
        CHECK (AppLanguage IN ('ar', 'en'));
GO

ALTER TABLE Catalog.Item
ADD Featured BIT NOT NULL
    CONSTRAINT DF_Item_Featured DEFAULT 0;
GO


ALTER TABLE Core.Member
ALTER COLUMN FullName NVARCHAR(150) NOT NULL;
GO

ALTER TABLE Logistics.Warehouse
ALTER COLUMN MaxItems SMALLINT NOT NULL;
GO


ALTER TABLE Catalog.Category
DROP CONSTRAINT CK_Category_Commission;
GO

ALTER TABLE Catalog.Category
ADD CONSTRAINT CK_Category_Commission
CHECK (Commission BETWEEN 0 AND 25);
GO

ALTER TABLE Sales.Auction
DROP CONSTRAINT CK_Auction_Status;
GO

ALTER TABLE Sales.Auction
ADD CONSTRAINT CK_Auction_Status
CHECK (Status IN ('PendingReview', 'Draft', 'Live', 'Ended', 'Cancelled'));
GO

ALTER TABLE Sales.Auction
DROP CONSTRAINT DF_Auction_Status;
GO

ALTER TABLE Sales.Auction
ADD CONSTRAINT DF_Auction_Status
DEFAULT 'PendingReview' FOR Status;
GO

ALTER TABLE Sales.Auction
ADD BuyNowPrice DECIMAL(18,2) NULL;
GO

ALTER TABLE Sales.Auction
WITH CHECK
ADD CONSTRAINT CK_Auction_BuyNowPrice
CHECK (
    BuyNowPrice IS NULL
    OR BuyNowPrice > StartingPrice
);
GO

ALTER TABLE Core.Member
ADD CONSTRAINT UQ_Member_Mobile
UNIQUE (Mobile);
GO

ALTER TABLE Core.Member
ADD VerifiedAt DATETIME2 NULL;
GO


ALTER TABLE Core.Member
DROP CONSTRAINT DF_Member_IsVerified;
GO

ALTER TABLE Core.Member
DROP COLUMN IsVerified;
GO