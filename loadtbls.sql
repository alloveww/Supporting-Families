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

--1.Person (PersonID, HealthID, DOB, Name, Phone, Email, Profession, BloodType, Address)
 INSERT INTO Person (PersonID, HealthID, DOB, Name, Phone, Email, Profession, BloodType, Address) VALUES
(1, 'H123456', '1980-01-01', 'Alice Johnson', '123-456-7890', 'alice.johnson@example.com', 'Engineer', 'O+', '123 Maple St'),
(2, 'H123457', '1982-02-02', 'Bob Smith', '123-456-7891', 'bob.smith@example.com', 'Doctor', 'A+', '456 Oak St'),
(3, 'H123458', '1985-03-03', 'Carol White', '123-456-7892', 'carol.white@example.com', 'Teacher', 'B+', '789 Pine St'),
(4, 'H123459', '1987-04-04', 'David Brown', '123-456-7893', 'david.brown@example.com', 'Lawyer', 'AB+', '321 Cedar St'),
(5, 'H123460', '1990-05-05', 'Eve Green', '123-456-7894', 'eve.green@example.com', 'Nurse', 'O-', '654 Birch St'),
(6, 'H123461', '1992-06-06', 'Frank Black', '123-456-7895', 'frank.black@example.com', 'Architect', 'A-', '987 Elm St'),
(7, 'H123462', '1994-07-07', 'Grace Blue', '123-456-7896', 'grace.blue@example.com', 'Artist', 'B-', '111 Cherry St'),
(8, 'H123463', '1996-08-08', 'Hank Yellow', '123-456-7897', 'hank.yellow@example.com', 'Scientist', 'AB-', '222 Walnut St'),
(9, 'H123464', '1998-09-09', 'Ivy Purple', '123-456-7898', 'ivy.purple@example.com', 'Writer', 'O+', '333 Ash St'),
(10, 'H123465', '2000-10-10', 'Jack Red', '123-456-7899', 'jack.red@example.com', 'Musician', 'A+', '444 Maple St'),
(11, 'H123466', '1981-01-11', 'Karen Silver', '223-456-7890', 'karen.silver@example.com', 'Engineer', 'O+', '223 Maple St'),
(12, 'H123467', '1983-02-12', 'Leo Gold', '223-456-7891', 'leo.gold@example.com', 'Doctor', 'A+', '223 Oak St'),
(13, 'H123468', '1986-03-13', 'Mona Bronze', '223-456-7892', 'mona.bronze@example.com', 'Teacher', 'B+', '223 Pine St'),
(14, 'H123469', '1988-04-14', 'Nick Amber', '223-456-7893', 'nick.amber@example.com', 'Lawyer', 'AB+', '223 Cedar St'),
(15, 'H123470', '1991-05-15', 'Olivia Grey', '223-456-7894', 'olivia.grey@example.com', 'Nurse', 'O-', '223 Birch St'),
(16, 'H123471', '1993-06-16', 'Paul Green', '223-456-7895', 'paul.green@example.com', 'Architect', 'A-', '223 Elm St'),
(17, 'H123472', '1995-07-17', 'Quincy Blue', '223-456-7896', 'quincy.blue@example.com', 'Artist', 'B-', '223 Cherry St'),
(18, 'H123473', '1997-08-18', 'Rachel Yellow', '223-456-7897', 'rachel.yellow@example.com', 'Scientist', 'AB-', '223 Walnut St'),
(19, 'H123474', '1999-09-19', 'Sam Purple', '223-456-7898', 'sam.purple@example.com', 'Writer', 'O+', '223 Ash St'),
(20, 'H123475', '2001-10-20', 'Tina Red', '223-456-7899', 'tina.red@example.com', 'Musician', 'A+', '223 Maple St'),
(101, 'QH123456780', '1985-01-01', 'Alice Johnson', '123-456-7890', 'alice@example.com', 'Teacher', 'A+', '123 Main St'),
(102, 'QH123456781', '1986-02-02', 'Betty White', '123-456-7891', 'betty@example.com', 'Nurse', 'B+', '456 Elm St');

--2.Father(FID) fID ref Person
INSERT INTO Father (FID) VALUES
(2),
(4),
(6),
(8),
(10),
(12),
(14),
(16),
(18),
(20);

--3.Mother(MID) mID ref Person
INSERT INTO Mother (MID) VALUES
(1),
(3),
(5),
(7),
(9),
(11),
(13),
(15),
(17),
(19)
(101)
(102);

--4.Couple (CoupleID(PK), FID, MID) fID ref Father, MID ref Mother
INSERT INTO Couple (CoupleID, FID, MID) VALUES
(1, 2, 1),
(2, 4, 3),
(3, 6, 5),
(4, 8, 7),
(5, 10, 9),
(6, 12, 11),
(7, 14, 13),
(8, 16, 15),
(9, 18, 17),
(10, 20, 19),
(1,201,101)
(2,202,102);

--5. InfoSession (SessionID(PK), Idate, Itime, Lang, PractID, Iid) practID ref Midwife, Iid ref Institution
INSERT INTO InfoSession (SessionID, Idate, Itime, Lang, PractID, Iid) VALUES
(1, '2024-06-01', '10:00:00', 'English', 1, 1),
(2, '2024-06-02', '11:00:00', 'French', 2, 1),
(3, '2024-06-03', '12:00:00', 'Spanish', 3, 2),
(4, '2024-06-04', '13:00:00', 'German', 4, 2),
(5, '2024-06-05', '14:00:00', 'Chinese', 5, 3),
(6, '2024-06-06', '15:00:00', 'English', 1, 1),
(7, '2024-06-07', '16:00:00', 'French', 2, 1),
(8, '2024-06-08', '17:00:00', 'Spanish', 3, 2),
(9, '2024-06-09', '18:00:00', 'German', 4, 2),
(10, '2024-06-10', '19:00:00', 'Chinese', 5, 3);

--6. SessionReg (RegID(PK),SessionID, CoupleID, Status) CoupleID ref couple
INSERT INTO SessionReg (RegID, SessionID, CoupleID, Status) VALUES
(1, 1, 1, 'Registered'),
(2, 2, 2, 'Registered'),
(3, 3, 3, 'Registered'),
(4, 4, 4, 'Registered'),
(5, 5, 5, 'Registered'),
(6, 6, 6, 'Registered'),
(7, 7, 7, 'Registered'),
(8, 8, 8, 'Registered'),
(9, 9, 9, 'Registered'),
(10, 10, 10, 'Registered');


--7. InfoSessionAttend(AttendanceID(PK),SessionID,CoupleID, Attended)SessionID ref InfoSession, CoupleID ref Couple
INSERT INTO InfoSessionAttend (AttendanceID, SessionID, CoupleID, Attended) VALUES
(1, 1, 1, TRUE),
(2, 2, 2, TRUE),
(3, 3, 3, TRUE),
(4, 4, 4, TRUE),
(5, 5, 5, TRUE),
(6, 6, 6, TRUE),
(7, 7, 7, TRUE),
(8, 8, 8, TRUE),
(9, 9, 9, TRUE),
(10, 10, 10, TRUE),
(11, 1, 11, FALSE),
(12, 2, 12, FALSE),
(13, 3, 13, FALSE),
(14, 4, 14, FALSE),
(15, 5, 15, FALSE),
(16, 6, 16, FALSE),
(17, 7, 17, FALSE),
(18, 8, 18, FALSE),
(19, 9, 19, FALSE),
(20, 10, 20, FALSE);

--8. HealthInsti (InstiID(PK), Name, Address, Phone, Email, Web)
INSERT INTO HealthInsti (InstiID, Name, Address, Phone, Email, Web) VALUES
(1, 'Community Clinic 1', '111 Health St', '333-456-7890', 'clinic1@example.com', 'www.clinic1.com'),
(2, 'Community Clinic 2', '222 Health St', '333-456-7891', 'clinic2@example.com', 'www.clinic2.com'),
(3, 'Birth Center 1', '333 Health St', '333-456-7892', 'center1@example.com', 'www.center1.com'),
(4, 'Birth Center 2', '444 Health St', '333-456-7893', 'center2@example.com', 'www.center2.com'),
(5, 'Community Clinic 3', '555 Health St', '333-456-7894', 'clinic3@example.com', 'www.clinic3.com'),
(6, 'Birth Center 3', '666 Health St', '333-456-7895', 'center3@example.com', 'www.center3.com'),
(7, 'Community Clinic 4', '777 Health St', '333-456-7896', 'clinic4@example.com', 'www.clinic4.com'),
(8, 'Birth Center 4', '888 Health St', '333-456-7897', 'center4@example.com', 'www.center4.com'),
(9, 'Community Clinic 5', '999 Health St', '333-456-7898', 'clinic5@example.com', 'www.clinic5.com'),
(10, 'Birth Center 5', '101 Health St', '333-456-7899', 'center5@example.com', 'www.center5.com');

--9. CommClinic(InstiID(PK)) InstiID ref HealthInsti
INSERT INTO CommClinic (InstiID) VALUES
(1),
(2),
(5),
(7),
(9),
(11),
(13),
(15),
(17),
(19);

--10.Birthcenter(InstiID) InstiID ref HealthInsti
INSERT INTO BirthCenter (InstiID) VALUES
(3),
(4),
(6),
(8),
(10),
(12),
(14),
(16),
(18),
(20);

--11.Midwife (PractID(PK), Name, Phone, Email, InstiID) InstiID ref HealthInsti
(1, 'Midwife A', '444-456-7890', 'midwifeA@example.com', 1),
(2, 'Midwife B', '444-456-7891', 'midwifeB@example.com', 2),
(3, 'Midwife C', '444-456-7892', 'midwifeC@example.com', 3),
(4, 'Midwife D', '444-456-7893', 'midwifeD@example.com', 4),
(5, 'Midwife E', '444-456-7894', 'midwifeE@example.com', 5),
(6, 'Midwife F', '444-456-7895', 'midwifeF@example.com', 6),
(7, 'Midwife G', '444-456-7896', 'midwifeG@example.com', 7),
(8, 'Midwife H', '444-456-7897', 'midwifeH@example.com', 8),
(9, 'Midwife I', '444-456-7898', 'midwifeI@example.com', 9),
(10, 'Midwife J', '444-456-7899', 'midwifeJ@example.com', 10),
(11, 'Midwife K', '444-456-7800', 'midwifeK@example.com', 1),
(12, 'Midwife L', '444-456-7801', 'midwifeL@example.com', 2),
(13, 'Midwife M', '444-456-7802', 'midwifeM@example.com', 3),
(14, 'Midwife N', '444-456-7803', 'midwifeN@example.com', 4),
(15, 'Midwife O', '444-456-7804', 'midwifeO@example.com', 5),
(16, 'Midwife P', '444-456-7805', 'midwifeP@example.com', 6),
(17, 'Midwife Q', '444-456-7806', 'midwifeQ@example.com', 7),
(18, 'Midwife R', '444-456-7807', 'midwifeR@example.com', 5),
(19, 'Midwife S', '444-456-7808', 'midwifeS@example.com', 5),
(20, 'Midwife T', '444-456-7809', 'midwifeT@example.com', 10);

-- 12. LabTech (TechID(PK), Name, Phone)
INSERT INTO LabTech (TechID, Name, Phone) VALUES
(1, 'Tech A', '555-456-7890'),
(2, 'Tech B', '555-456-7891'),
(3, 'Tech C', '555-456-7892'),
(4, 'Tech D', '555-456-7893'),
(5, 'Tech E', '555-456-7894'),
(6, 'Tech F', '555-456-7895'),
(7, 'Tech G', '555-456-7896'),
(8, 'Tech H', '555-456-7897'),
(9, 'Tech I', '555-456-7898'),
(10, 'Tech J', '555-456-7899'),
(11, 'Tech K', '555-456-7800'),
(12, 'Tech L', '555-456-7801'),
(13, 'Tech M', '555-456-7802'),
(14, 'Tech N', '555-456-7803'),
(15, 'Tech O', '555-456-7804'),
(16, 'Tech P', '555-456-7805'),
(17, 'Tech Q', '555-456-7806'),
(18, 'Tech R', '555-456-7807'),
(19, 'Tech S', '555-456-7808'),
(20, 'Tech T', '555-456-7809');

--13. Pregnancy (CoupleID(WK), Pregtime(WK), PpractID, BpractID, InstiID, Expdueym, Impdued, Ultradued, Estidued, Location, HomeBirth) CoupleID ref Couple, PpractID ref Midwife, BpractID ref Midwife, InstiID ref Institution
INSERT INTO Pregnancy (CoupleID, Pregtime, PpractID, BpractID, InstiID, Expdueym, Impdued, Ultradued, Estidued, Location, HomeBirth) VALUES
(1, 1, 1, 2, 1, '2024-07-01', '2024-06-25', '2024-06-20', '2024-07-05', 1, TRUE),
(1, 2, 3, 4, 2, '2025-08-01', '2025-07-25', '2025-07-20', '2025-08-05', 0, FALSE),
(2, 1, 5, 6, 3, '2024-09-01', '2024-08-25', '2024-08-20', '2024-09-05', 1, TRUE),
(3, 1, 7, 8, 4, '2024-10-01', '2024-09-25', '2024-09-20', '2024-10-05', 0, FALSE),
(4, 1, 9, 10, 5, '2024-11-01', '2024-10-25', '2024-10-20', '2024-11-05', 1, TRUE),
(5, 1, 11, 12, 6, '2024-12-01', '2024-11-25', '2024-11-20', '2024-12-05', 0, FALSE),
(6, 1, 13, 14, 7, '2025-01-01', '2024-12-25', '2024-12-20', '2025-01-05', 1, TRUE),
(7, 1, 15, 16, 8, '2025-02-01', '2025-01-25', '2025-01-20', '2025-02-05', 0, FALSE),
(8, 1, 17, 18, 9, '2025-03-01', '2025-02-25', '2025-02-20', '2025-03-05', 1, TRUE),
(9, 1, 19, 20, 10, '2025-04-01', '2025-03-25', '2025-03-20', '2025-04-05', 0, FALSE),
(10, 1, 1, 2, 1, '2025-05-01', '2025-04-25', '2025-04-20', '2025-05-05', 1, TRUE),
(11, 1, 3, 4, 2, '2025-06-01', '2025-05-25', '2025-05-20', '2025-06-05', 0, FALSE),
(12, 1, 5, 6, 3, '2025-07-01', '2025-06-25', '2025-06-20', '2025-07-05', 1, TRUE),
(13, 1, 7, 8, 4, '2025-08-01', '2025-07-25', '2025-07-20', '2025-08-05', 0, FALSE),
(14, 1, 9, 10, 5, '2025-09-01', '2025-08-25', '2025-08-20', '2025-09-05', 1, TRUE),
(15, 1, 11, 12, 6, '2025-10-01', '2025-09-25', '2025-09-20', '2025-10-05', 0, FALSE),
(16, 1, 13, 14, 7, '2025-11-01', '2025-10-25', '2025-10-20', '2025-11-05', 1, TRUE),
(17, 1, 15, 16, 8, '2025-12-01', '2025-11-25', '2025-11-20', '2025-12-05', 0, FALSE),
(18, 1, 17, 18, 9, '2026-01-01', '2025-12-25', '2025-12-20', '2026-01-05', 1, TRUE),
(19, 1, 19, 20, 10, '2026-02-01', '2026-01-25', '2026-01-20', '2026-02-05', 0, FALSE);



--14. Baby (BabyID(PK), DOB, Btime, Gender, Bloodtype, Name, CoupleID,PregTime) (CoupleID,PregTime) ref pregnancy
INSERT INTO Baby (BabyID, DOB, Btime, Gender, BloodType, Name, CoupleID, Pregtime) VALUES
(1, '2024-07-15', '08:00:00', 'Male', 'O+', 'Adam', 1, 1),
(2, '2024-07-15', '09:00:00', 'Female', 'A+', 'Beth', 1, 1),
(3, '2024-09-15', '10:00:00', 'Male', 'B+', 'Carl', 1, 2),
(4, '2024-10-15', '11:00:00', 'Female', 'AB+', 'Diana', 2, 1),
(5, '2024-11-15', '12:00:00', 'Male', 'O-', 'Evan', 2, 1),
(6, '2024-12-15', '13:00:00', 'Female', 'A-', 'Fiona', 5, 1),
(7, '2025-01-15', '14:00:00', 'Male', 'B-', 'George', 6, 1),
(8, '2025-02-15', '15:00:00', 'Female', 'AB-', 'Hannah', 7, 1),
(9, '2025-03-15', '16:00:00', 'Male', 'O+', 'Ian', 8, 1),
(10, '2025-04-15', '17:00:00', 'Female', 'A+', 'Jane', 9, 1),
(11, '2025-07-15', '08:00:00', 'Male', 'O+', 'Kevin', 10, 1),
(12, '2025-08-15', '09:00:00', 'Female', 'A+', 'Luna', 11, 1),
(13, '2025-09-15', '10:00:00', 'Male', 'B+', 'Mike', 12, 1),
(14, '2025-10-15', '11:00:00', 'Female', 'AB+', 'Nina', 13, 1),
(15, '2025-11-15', '12:00:00', 'Male', 'O-', 'Oscar', 14, 1),
(16, '2025-12-15', '13:00:00', 'Female', 'A-', 'Paula', 15, 1),
(17, '2026-01-15', '14:00:00', 'Male', 'B-', 'Quinn', 16, 1),
(18, '2026-02-15', '15:00:00', 'Female', 'AB-', 'Rita', 17, 1),
(19, '2026-03-15', '16:00:00', 'Male', 'O+', 'Steve', 18, 1),
(20, '2026-04-15', '17:00:00', 'Female', 'A+', 'Tina', 19, 1);


--15. Tests (TestID(PK), CoupleID, Pregtime BabyID, Refdate, SampleDate, Labdate, Type, Results, PractID, TechID)  PractID ref Midwife, TechID ref LabTech, (CoupleID,Pregtime) ref pregnancy, BabyID ref Baby
INSERT INTO Tests (TestID, CoupleID, Pregtime, BabyID, Refdate, SampleDate, Labdate, Type, Results, PractID, TechID) VALUES
(1, 1, 2, NULL, '2025-03-01', '2025-03-05', '2025-03-10', 'Blood Iron', 'Normal', 2, 1),
(2, 1, 2, NULL, '2025-04-01', '2025-04-05', '2025-04-10', 'Blood Iron', 'Low', 2, 1),
(3, 1, 1, NULL, '2024-02-01', '2024-02-05', '2024-02-10', 'Blood Iron', 'Normal', 1, 2),
(4, 2, 1, NULL, '2024-03-01', '2024-03-05', '2024-03-10', 'Blood Iron', 'Normal', 2, 3),
(5, 3, 1, NULL, '2024-04-01', '2024-04-05', '2024-04-10', 'Blood Iron', 'Normal', 3, 4),
(6, 4, 1, NULL, '2024-05-01', '2024-05-05', '2024-05-10', 'X-ray', 'Normal', 4, 5),
(7, 5, 1, NULL, '2024-06-01', '2024-06-05', '2024-06-10', 'X-ray', 'Normal', 5, 6),
(8, 6, 1, NULL, '2024-07-01', '2024-07-05', '2024-07-10', 'Blood Iron', 'Normal', 6, 7),
(9, 7, 1, NULL, '2024-08-01', '2024-08-05', '2024-08-10', 'Blood Iron', 'Normal', 7, 8),
(10, 8, 1, NULL, '2024-09-01', '2024-09-05', '2024-09-10', 'Blood Iron', 'Normal', 8, 9),
(11, 9, 1, NULL, '2024-10-01', '2024-10-05', '2024-10-10', 'Blood Iron', 'Normal', 9, 10),
(12, 10, 1, NULL, '2025-02-01', '2025-02-05', '2025-02-10', 'Brain', 'Normal', 10, 11),
(13, 11, 1, NULL, '2025-03-01', '2025-03-05', '2025-03-10', 'Urine', 'Normal', 11, 12),
(14, 12, 1, NULL, '2025-04-01', '2025-04-05', '2025-04-10', 'Blood Iron', 'Normal', 12, 13),
(15, 13, 1, NULL, '2025-05-01', '2025-05-05', '2025-05-10', 'Blood Iron', 'Normal', 13, 14),
(16, 14, 1, NULL, '2025-06-01', '2025-06-05', '2025-06-10', 'Urine', 'Normal', 14, 15),
(17, 15, 1, NULL, '2025-07-01', '2025-07-05', '2025-07-10', 'White cell', 'Normal', 15, 16),
(18, 16, 1, NULL, '2025-08-01', '2025-08-05', '2025-08-10', 'Blood Iron', 'Normal', 16, 17),
(19, 17, 1, NULL, '2025-09-01', '2025-09-05', '2025-09-10', 'Blood Iron', 'Normal', 17, 18),
(20, 18, 1, NULL, '2025-10-01', '2025-10-05', '2025-10-10', 'Blood Iron', 'Normal', 18, 19);


--16.Appointment (AppointID, PractID, CoupleID,Pregtime adate, atime ) PractID ref Midwife, (CoupleID,Pregtime) ref Pregnancy
INSERT INTO Appointment (AppointID, PractID, CoupleID, Pregtime, Adate, Atime) VALUES
(1, 1, 1, '2024-01', '2024-02-01', '10:00:00'),
(2, 2, 2, '2024-02', '2024-03-01', '11:00:00'),
(3, 3, 3, '2024-03', '2024-04-01', '12:00:00'),
(4, 4, 4, '2024-04', '2024-05-01', '13:00:00'),
(5, 5, 5, '2024-05', '2024-06-01', '14:00:00'),
(6, 6, 6, '2024-06', '2024-07-01', '15:00:00'),
(7, 7, 7, '2024-07', '2024-08-01', '16:00:00'),
(8, 8, 8, '2024-08', '2024-09-01', '17:00:00'),
(9, 9, 9, '2024-09', '2024-10-01', '18:00:00'),
(10, 10, 10, '2024-10', '2024-11-01', '19:00:00'),
(11, 11, 11, '2025-01', '2025-02-01', '10:00:00'),
(12, 12, 12, '2025-02', '2025-03-01', '11:00:00'),
(13, 13, 13, '2025-03', '2025-04-01', '12:00:00'),
(14, 14, 14, '2025-04', '2025-05-01', '13:00:00'),
(15, 15, 15, '2025-05', '2025-06-01', '14:00:00'),
(16, 16, 16, '2025-06', '2025-07-01', '15:00:00'),
(17, 17, 17, '2025-07', '2025-08-01', '16:00:00'),
(18, 18, 18, '2025-08', '2025-09-01', '17:00:00'),
(19, 19, 19, '2025-09', '2025-10-01', '18:00:00'),
(20, 20, 20, '2025-10', '2025-11-01', '19:00:00'),
(21, 18, 11, '2025-01', '2024-03-21', '10:00:00'),
(22, 18, 12, '2025-02', '2024-03-22', '11:00:00'),
(23, 18, 13, '2025-03', '2024-03-23', '12:00:00'),
(24, 18, 14, '2025-04', '2024-03-24', '13:00:00'),
(25, 18, 15, '2025-05', '2024-03-25', '14:00:00');;

--17.Notes (NoteID, AppointID, DateTime, Content) AppointID ref Appointment
INSERT INTO Notes (NoteID, AppointID, DateTime, Content) VALUES
(1, 1, '2024-02-01 10:15:00', 'Initial check-up'),
(2, 2, '2024-03-01 11:15:00', 'Routine appointment'),
(3, 3, '2024-04-01 12:15:00', 'Blood test results reviewed'),
(4, 4, '2024-05-01 13:15:00', 'Ultrasound scheduled'),
(5, 5, '2024-06-01 14:15:00', 'Glucose test administered'),
(6, 6, '2024-07-01 15:15:00', 'Follow-up appointment'),
(7, 7, '2024-08-01 16:15:00', 'Routine check-up'),
(8, 8, '2024-09-01 17:15:00', 'Blood test results reviewed'),
(9, 9, '2024-10-01 18:15:00', 'Ultrasound scheduled'),
(10, 10, '2024-11-01 19:15:00', 'Glucose test administered'),
(11, 11, '2025-02-01 10:15:00', 'Initial check-up'),
(12, 12, '2025-03-01 11:15:00', 'Routine appointment'),
(13, 13, '2025-04-01 12:15:00', 'Blood test results reviewed'),
(14, 14, '2025-05-01 13:15:00', 'Ultrasound scheduled'),
(15, 15, '2025-06-01 14:15:00', 'Glucose test administered'),
(16, 16, '2025-07-01 15:15:00', 'Follow-up appointment'),
(17, 17, '2025-08-01 16:15:00', 'Routine check-up'),
(18, 18, '2025-09-01 17:15:00', 'Blood test results reviewed'),
(19, 19, '2025-10-01 18:15:00', 'Ultrasound scheduled'),
(20, 20, '2025-11-01 19:15:00', 'Glucose test administered');
