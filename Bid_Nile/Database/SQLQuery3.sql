
CREATE TABLE Logistics.Warehouse
(
    WarehouseId INT IDENTITY(1,1) NOT NULL,

    Name NVARCHAR(80) NOT NULL,

    Capacity INT NOT NULL,

    CityId INT NOT NULL,

    Latitude FLOAT NOT NULL,

    Longitude FLOAT NOT NULL,

    ManagerMemberId UNIQUEIDENTIFIER NOT NULL,

    ManagerSince DATE NOT NULL,

    CONSTRAINT PK_Warehouse
        PRIMARY KEY (WarehouseId),

    CONSTRAINT UQ_Warehouse_Name
        UNIQUE (Name),

    CONSTRAINT UQ_Warehouse_Manager
        UNIQUE (ManagerMemberId),

    CONSTRAINT CK_Warehouse_Capacity
        CHECK (Capacity > 0),

    CONSTRAINT CK_Warehouse_Latitude
        CHECK (Latitude BETWEEN -90 AND 90),

    CONSTRAINT CK_Warehouse_Longitude
        CHECK (Longitude BETWEEN -180 AND 180)
);
GO

CREATE TABLE Logistics.Employee
(
    MemberId UNIQUEIDENTIFIER NOT NULL,

    WarehouseId INT NOT NULL,

    CONSTRAINT PK_Employee
        PRIMARY KEY (MemberId)
);
GO