-- If the tables exits we drop tables in the reverse order of dependencies to avoid foreign key violations

-- 1. Notes
DROP TABLE IF EXISTS Notes;

-- 2. Appointment
DROP TABLE IF EXISTS Appointment;

-- 3. Tests
DROP TABLE IF EXISTS Tests;

-- 4. Baby
DROP TABLE IF EXISTS Baby;

-- 5. Pregnancy
DROP TABLE IF EXISTS Pregnancy;

-- 6. InfoSessionAttend
DROP TABLE IF EXISTS InfoSessionAttend;

-- 7. SessionReg
DROP TABLE IF EXISTS SessionReg;

-- 8. InfoSession
DROP TABLE IF EXISTS InfoSession;

-- 9. Midwife
DROP TABLE IF EXISTS Midwife;

-- 10. BirthCenter
DROP TABLE IF EXISTS BirthCenter;

-- 11. CommClinic
DROP TABLE IF EXISTS CommClinic;

-- 12. HealthInsti
DROP TABLE IF EXISTS HealthInsti;

-- 13. LabTech
DROP TABLE IF EXISTS LabTech;

-- 14. Couple
DROP TABLE IF EXISTS Couple;

-- 15. Mother
DROP TABLE IF EXISTS Mother;

-- 16. Father
DROP TABLE IF EXISTS Father;

-- 17. Person
DROP TABLE IF EXISTS Person;
