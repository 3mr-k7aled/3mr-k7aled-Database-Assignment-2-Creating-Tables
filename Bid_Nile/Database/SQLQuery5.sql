
CREATE TABLE Sales.Auction
(
    AuctionId INT IDENTITY(1,1) NOT NULL,
    ItemId INT NOT NULL,
    StartingPrice DECIMAL(12,2) NOT NULL,
    ReservePrice DECIMAL(12,2) NULL,
    BidIncrement DECIMAL(12,2) NOT NULL
        CONSTRAINT DF_Auction_BidIncrement DEFAULT 50.00,
    StartAt DATETIMEOFFSET NOT NULL,
    EndAt DATETIMEOFFSET NOT NULL,
    Status VARCHAR(20) NOT NULL
        CONSTRAINT DF_Auction_Status DEFAULT 'Draft',

    CONSTRAINT PK_Auction
        PRIMARY KEY (AuctionId),

    CONSTRAINT CK_Auction_StartingPrice
        CHECK (StartingPrice > 0),

    CONSTRAINT CK_Auction_ReservePrice
        CHECK (ReservePrice IS NULL OR ReservePrice >= StartingPrice),

    CONSTRAINT CK_Auction_BidIncrement
        CHECK (BidIncrement > 0),

    CONSTRAINT CK_Auction_StartEnd
        CHECK (EndAt > StartAt),

    CONSTRAINT CK_Auction_Status
        CHECK (Status IN ('Draft', 'Live', 'Ended', 'Cancelled'))
);
GO

CREATE TABLE Sales.Bid
(
    BidId BIGINT IDENTITY(1,1) NOT NULL,
    AuctionId INT NOT NULL,
    MemberId UNIQUEIDENTIFIER NOT NULL,
    Amount DECIMAL(12,2) NOT NULL,
    PlacedAt DATETIME2(3) NOT NULL
        CONSTRAINT DF_Bid_PlacedAt DEFAULT SYSDATETIME(),
    IP VARCHAR(45) NOT NULL,

    CONSTRAINT PK_Bid
        PRIMARY KEY (BidId),

    CONSTRAINT UQ_Bid_Auction_Amount
        UNIQUE (AuctionId, Amount),

    CONSTRAINT CK_Bid_Amount
        CHECK (Amount > 0)
);
GO

CREATE TABLE Sales.AuctionFollow
(
    MemberId UNIQUEIDENTIFIER NOT NULL,
    AuctionId INT NOT NULL,
    FollowedAt DATETIME2(3) NOT NULL
        CONSTRAINT DF_AuctionFollow_FollowedAt DEFAULT SYSDATETIME(),

    CONSTRAINT PK_AuctionFollow
        PRIMARY KEY (MemberId, AuctionId)
);
GO