/*
 1. Person (PersonID(PK), HealthID, DOB, Name, Phone, Email, Profession, BloodType, Address)
 2. Father(FID) fID ref Person
 3. Mother(MID) mID ref Person
 4. Couple (CoupleID(PK), FID, MID) fID ref Father, MID ref Mother
 5. InfoSession (SessionID(PK), Idate, Itime, Lang, PractID, Iid) practID ref Midwife, Iid ref Institution
 6. SessionReg (RegID(PK),SessionID, CoupleID, Status) CoupleID ref couple
 7.InfoSessionAttend(AttendanceID(PK),SessionID,CoupleID, Attended)SessionID ref InfoSession, CoupleID ref Couple
 8. HealthInsti (InstiID(PK), Name, Address, Phone, Email, Web)
 9. CommClinic(InstiID(PK)) InstiID ref HealthInsti
 10. Birthcenter(InstiID) InstiID ref HealthInsti
 11. Midwife (PractID(PK), Name, Phone, Email, InstiID) InstiID ref HealthInsti
 12. LabTech (TechID(PK), Name, Phone)
 13. Pregnancy (CoupleID(WK), Pregtime(WK), PpractID, BpractID, InstiID, Expdueym, Impdued, Ultradued, Estidued, Location, HomeBirth) CoupleID ref Couple, PpractID ref Midwife, BpractID ref Midwife, InstiID ref Institution
 14. Baby (BabyID(PK), DOB, Btime, Gender, Bloodtype, Name, CoupleID,PregTime) (CoupleID,PregTime) ref pregnancy
 15. Tests (TestID(PK), CoupleID, Pregtime BabyID, Refdate, SampleDate, Labdate, Type, Results, PractID, TechID)  PractID ref Midwife, TechID ref LabTech, (CoupleID,Pregtime) ref pregnancy, BabyID ref Baby
 16. Appointment (AppointID, PractID, CoupleID,Pregtime adate, atime ) PractID ref Midwife, (CoupleID,Pregtime) ref Pregnancy
 17. Notes (NoteID, AppointID, DateTime, Content) AppointID ref Appointment
 */

-- 1. Person (PersonID(PK), HealthID, DOB, Name, Phone, Email, Profession, Address)
CREATE TABLE Person (
    PersonID INT PRIMARY KEY,
    HealthID VARCHAR(22),
    DOB DATE NOT NULL,
    Name VARCHAR(25) NOT NULL,
    Phone VARCHAR(22) NOT NULL,
    Email VARCHAR(60),
    Profession VARCHAR(60) NOT NULL,
    BloodType VARCHAR(5),
    Address VARCHAR(20)
);

-- 2. Father (FID) fID ref Person
CREATE TABLE Father (
    FID INT PRIMARY KEY,
    FOREIGN KEY (FID) REFERENCES Person(PersonID)
);

-- 3. Mother (MID) mID ref Person
CREATE TABLE Mother (
    MID INT PRIMARY KEY,
    FOREIGN KEY (MID) REFERENCES Person(PersonID)
);

-- 4. Couple (CoupleID(PK), FID, MID) fID ref Father, MID ref Mother
CREATE TABLE Couple (
    CoupleID INT PRIMARY KEY,
    FID INT,
    MID INT NOT NULL,
    FOREIGN KEY (FID) REFERENCES Father(FID),
    FOREIGN KEY (MID) REFERENCES Mother(MID)
);

-- 5. InfoSession (SessionID(PK), Idate, Itime, Lang, PractID, Iid) practID ref Midwife, Iid ref Institution
CREATE TABLE InfoSession (
    SessionID INT PRIMARY KEY,
    Idate DATE NOT NULL,
    Itime TIME NOT NULL,
    Lang VARCHAR(30) NOT NULL,
    PractID INT NOT NULL,
    Iid INT NOT NULL,
    FOREIGN KEY (PractID) REFERENCES Midwife(PractID),
    FOREIGN KEY (Iid) REFERENCES HealthInsti(InstiID)
);

-- 6. SessionReg (RegID(PK),SessionID, CoupleID, Status) CoupleID ref Couple
CREATE TABLE SessionReg (
    RegID INT PRIMARY KEY,
    SessionID INT NOT NULL,
    CoupleID INT NOT NULL,
    Status VARCHAR(50),
    FOREIGN KEY (SessionID) REFERENCES InfoSession(SessionID),
    FOREIGN KEY (CoupleID) REFERENCES Couple(CoupleID)
);

-- 7. InfoSessionAttend (AttendanceID(PK),SessionID,CoupleID, Attended) SessionID ref InfoSession, CoupleID ref Couple
CREATE TABLE InfoSessionAttend (
    AttendanceID INT PRIMARY KEY,
    SessionID INT NOT NULL,
    CoupleID INT NOT NULL,
    Attended BOOLEAN NOT NULL,
    FOREIGN KEY (SessionID) REFERENCES InfoSession(SessionID),
    FOREIGN KEY (CoupleID) REFERENCES Couple(CoupleID)
);

-- 8. HealthInsti (InstiID(PK), Name, Address, Phone, Email, Web)
CREATE TABLE HealthInsti (
    InstiID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Address VARCHAR(90) NOT NULL,
    Phone VARCHAR(22) NOT NULL,
    Email VARCHAR(75) NOT NULL,
    Web VARCHAR(90)
);

-- 9. CommClinic (InstiID) InstiID ref HealthInsti
CREATE TABLE CommClinic (
    InstiID INT PRIMARY KEY,
    FOREIGN KEY (InstiID) REFERENCES HealthInsti(InstiID)
);

-- 10. BirthCenter (InstiID) InstiID ref HealthInsti
CREATE TABLE BirthCenter (
    InstiID INT PRIMARY KEY,
    FOREIGN KEY (InstiID) REFERENCES HealthInsti(InstiID)
);

-- 11. Midwife (PractID(PK), Name, Phone, Email, InstiID) InstiID ref HealthInsti
CREATE TABLE Midwife (
    PractID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Phone VARCHAR(22) NOT NULL,
    Email VARCHAR(75) NOT NULL UNIQUE,
    InstiID INT NOT NULL,
    FOREIGN KEY (InstiID) REFERENCES HealthInsti(InstiID)
);

-- 12. LabTech (TechID(PK), Name, Phone)
CREATE TABLE LabTech (
    TechID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Phone VARCHAR(22) NOT NULL
);

-- 13. Pregnancy (CoupleID(WK), Pregtime(WK), PpractID, BpractID, InstiID, Expdueym, Impdued, Ultradued, Estidued, Location, HomeBirth) CoupleID ref Couple, PpractID ref Midwife, BpractID ref Midwife, InstiID ref Institution
CREATE TABLE Pregnancy (
    CoupleID INT NOT NULL,
    Pregtime INT NOT NULL,
    PpractID INT NOT NULL,
    BpractID INT NOT NULL,
    InstiID INT NOT NULL,
    Expdueym DATE,
    Impdued DATE,
    Ultradued DATE,
    Estidued DATE,
    Location INT NOT NULL CHECK (Location IN (0, 1)),
    HomeBirth BOOLEAN,
    PRIMARY KEY (CoupleID, Pregtime),
    FOREIGN KEY (CoupleID) REFERENCES Couple(CoupleID),
    FOREIGN KEY (PpractID) REFERENCES Midwife(PractID),
    FOREIGN KEY (BpractID) REFERENCES Midwife(PractID),
    FOREIGN KEY (InstiID) REFERENCES HealthInsti(InstiID),
    CHECK (PpractID <> BpractID)
);

-- 14. Baby (BabyID(PK), DOB, Btime, Gender, Bloodtype, Name, CoupleID, PregTime) (CoupleID, PregTime) ref Pregnancy
CREATE TABLE Baby (
    BabyID INT PRIMARY KEY,
    DOB DATE,
    Btime TIME,
    Gender VARCHAR(10),
    BloodType VARCHAR(5),
    Name VARCHAR(20),
    CoupleID INT,
    Pregtime INT,
    FOREIGN KEY (CoupleID, Pregtime) REFERENCES Pregnancy(CoupleID, Pregtime)
);

-- 15. Tests (TestID(PK), CoupleID, Pregtime, BabyID, Refdate, SampleDate, Labdate, Type, Results, PractID, TechID) PractID ref Midwife, TechID ref LabTech, (CoupleID, Pregtime) ref Pregnancy, BabyID ref Baby
CREATE TABLE Tests (
    TestID INT PRIMARY KEY,
    CoupleID INT,
    Pregtime INT,
    BabyID INT,
    Refdate DATE NOT NULL,
    SampleDate DATE,
    Labdate DATE,
    Type VARCHAR(50),
    Results VARCHAR(50),
    PractID INT,
    TechID INT,
    FOREIGN KEY (CoupleID, Pregtime) REFERENCES Pregnancy(CoupleID, Pregtime),
    FOREIGN KEY (BabyID) REFERENCES Baby(BabyID),
    FOREIGN KEY (PractID) REFERENCES Midwife(PractID),
    FOREIGN KEY (TechID) REFERENCES LabTech(TechID)
);


-- 16. Appointment (AppointID, PractID, CoupleID, Pregtime, Adate, Atime) PractID ref Midwife, (CoupleID, Pregtime) ref Pregnancy
CREATE TABLE Appointment (
    AppointID INT PRIMARY KEY,
    PractID INT NOT NULL,
    CoupleID INT,
    Pregtime INT,
    Adate DATE NOT NULL,
    Atime TIME NOT NULL,
    FOREIGN KEY (PractID) REFERENCES Midwife(PractID),
    FOREIGN KEY (CoupleID, Pregtime) REFERENCES Pregnancy(CoupleID, Pregtime)
);

-- 17. Notes (NoteID, AppointID, DateTime, Content) AppointID ref Appointment
CREATE TABLE Notes (
    NoteID INT PRIMARY KEY,
    AppointID INT NOT NULL,
    DateTime TIMESTAMP NOT NULL,
    Content VARCHAR(90) NOT NULL,
    FOREIGN KEY (AppointID) REFERENCES Appointment(AppointID)
);
