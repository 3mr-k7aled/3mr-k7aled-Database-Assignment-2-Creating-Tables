
CREATE TABLE Catalog.Category
(
    CategoryId INT NOT NULL,

    NameEn NVARCHAR(50) NOT NULL,

    NameAr NVARCHAR(50) NULL,

    Commission DECIMAL(5,2) NOT NULL,

    ParentCategoryId INT NULL,

    CONSTRAINT PK_Category
        PRIMARY KEY (CategoryId),

    CONSTRAINT UQ_Category_NameEn
        UNIQUE (NameEn),

    CONSTRAINT CK_Category_Commission
        CHECK (Commission BETWEEN 0 AND 30)
);
GO

CREATE TABLE Catalog.Item
(
    ItemId INT IDENTITY(1,1) NOT NULL,

    Title NVARCHAR(150) NOT NULL,

    Description NVARCHAR(MAX) NULL,

    ConditionScore TINYINT NOT NULL,

    Specifications NVARCHAR(MAX) NOT NULL,

    SellerMemberId UNIQUEIDENTIFIER NOT NULL,

    InspectorMemberId UNIQUEIDENTIFIER NOT NULL,

    CategoryId INT NOT NULL,

    WarehouseId INT NULL,

    ListedAt DATETIME2(3) NOT NULL
        CONSTRAINT DF_Item_ListedAt DEFAULT SYSDATETIME(),

    CONSTRAINT PK_Item
        PRIMARY KEY (ItemId),

    CONSTRAINT CK_Item_ConditionScore
        CHECK (ConditionScore BETWEEN 1 AND 10),

    CONSTRAINT CK_Item_Specifications
        CHECK (ISJSON(Specifications) = 1),

    CONSTRAINT CK_Item_Seller_Inspector
        CHECK (SellerMemberId <> InspectorMemberId)
);
GO

CREATE TABLE Catalog.ItemPhoto
(
    ItemId INT NOT NULL,

    PhotoPosition TINYINT NOT NULL,

    PhotoUrl VARCHAR(500) NOT NULL,

    IsMain BIT NOT NULL
        CONSTRAINT DF_ItemPhoto_IsMain DEFAULT 0,

    CONSTRAINT PK_ItemPhoto
        PRIMARY KEY (ItemId, PhotoPosition),

    CONSTRAINT CK_ItemPhoto_Position
        CHECK (PhotoPosition BETWEEN 1 AND 20)
);
GO