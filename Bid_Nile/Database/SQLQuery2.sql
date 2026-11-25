
USE BidNile;
GO

CREATE TABLE Core.City
(
    CityId INT IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(60) NOT NULL,
    CountryCode CHAR(2) NOT NULL,

    CONSTRAINT PK_City
        PRIMARY KEY (CityId),

    CONSTRAINT UQ_City_Name_CountryCode
        UNIQUE (Name, CountryCode),

    CONSTRAINT CK_City_CountryCode
        CHECK (CountryCode IN ('EG', 'SA', 'AE'))
);
GO

CREATE TABLE Core.Member
(
    MemberId UNIQUEIDENTIFIER NOT NULL
        CONSTRAINT DF_Member_MemberId DEFAULT NEWID(),

    FullName NVARCHAR(100) NOT NULL,

    Email VARCHAR(254) NOT NULL,

    Mobile VARCHAR(16) NOT NULL,

    NationalId VARCHAR(20) NOT NULL,

    BirthDate DATE NOT NULL,

    IsVerified BIT NOT NULL
        CONSTRAINT DF_Member_IsVerified DEFAULT 0,

    RegisteredAt DATETIME2(3) NOT NULL
        CONSTRAINT DF_Member_RegisteredAt DEFAULT SYSDATETIME(),

    CityId INT NOT NULL,

    InvitedByMemberId UNIQUEIDENTIFIER NULL,

    CONSTRAINT PK_Member
        PRIMARY KEY (MemberId),

    CONSTRAINT UQ_Member_Email
        UNIQUE (Email),

    CONSTRAINT UQ_Member_NationalId
        UNIQUE (NationalId),

    CONSTRAINT CK_Member_BirthDate
        CHECK (BirthDate <= DATEADD(YEAR, -18, CONVERT(DATE, GETDATE())))
);
GO

CREATE TABLE Core.Wallet
(
    MemberId UNIQUEIDENTIFIER NOT NULL,

    Balance DECIMAL(12,2) NOT NULL
        CONSTRAINT DF_Wallet_Balance DEFAULT 0,

    HeldAmount DECIMAL(12,2) NOT NULL
        CONSTRAINT DF_Wallet_HeldAmount DEFAULT 0,

    Currency CHAR(3) NOT NULL
        CONSTRAINT DF_Wallet_Currency DEFAULT 'EGP',

    LastUpdated DATETIME2(3) NOT NULL
        CONSTRAINT DF_Wallet_LastUpdated DEFAULT SYSDATETIME(),

    CONSTRAINT PK_Wallet
        PRIMARY KEY (MemberId),

    CONSTRAINT CK_Wallet_Balance
        CHECK (Balance >= 0),

    CONSTRAINT CK_Wallet_HeldAmount
        CHECK (HeldAmount >= 0 AND HeldAmount <= Balance)
);
GO