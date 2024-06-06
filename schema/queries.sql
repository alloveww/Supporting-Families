/* 
1. List Upcoming Appointments for Midwife R
*/
SELECT
    a.Adate AS AppointmentDate,
    a.Atime AS AppointmentTime,
    p.HealthID AS HealthCareCard,
    p.Name AS MotherName,
    p.Phone AS MotherPhoneNumber
FROM
    Appointment a 
JOIN Pregnancy pr ON a.CoupleID = pr.CoupleID AND a.Pregtime = pr.Pregtime
JOIN Couple c ON pr.CoupleID = c.CoupleID
JOIN Mother mo ON c.MID = mo.MID
JOIN Person p ON mo.MID = p.PersonID
WHERE
    a.PractID = (SELECT PractID FROM Midwife WHERE Name = 'Midwife R')
    AND a.Adate >= CURDATE()
ORDER BY a.Adate, a.Atime;

/*
2. List All Midwives and the Number of Pregnancies they Are Managing order by number of pregancies from high to low
*/
SELECT
    m.Name AS MidwifeName,
    COUNT(p.CoupleID) AS NumberOfPregnancies
FROM
    Midwife m JOIN Pregnancy p ON m.PractID = p.PpractID
GROUP BY m.Name
ORDER BY NumberOfPregnancies DESC;

/*
3.Calculate the Average Number of Babies Per Pregnancy
*/
--with cte
WITH PregnancyBabyCounts AS (
    SELECT
        pr.CoupleID,
        pr.Pregtime,
        COUNT(b.BabyID) AS BabyCount
    FROM 
        Pregnancy pr JOIN Baby b ON pr.CoupleID = b.CoupleID AND pr.Pregtime = b.Pregtime
    GROUP BY
        pr.CoupleID, pr.Pregtime
)
SELECT
    AVG(BabyCount) AS AverageBabiesPerPregnancy
FROM
    PregnancyBabyCounts;
--without cte
SELECT
    AVG(BabyCount) AS AverageBabiesPerPregnancy
FROM
    (SELECT
        pr.CoupleID,
        pr.Pregtime,
        COUNT(b.BabyID) AS BabyCount
    FROM 
        Pregnancy pr JOIN Baby b ON pr.CoupleID = b.CoupleID AND pr.Pregtime = b.Pregtime
    GROUP BY
        pr.CoupleID, pr.Pregtime) AS PregnancyBabyCounts;


/*Calculate the Average Number of Tests Conducted by Each Lab Technician Per Month*/
--average number of tests conducted by each lab technician per month : counting the tests per month and then averaging those counts.
WITH MonthlyTestCounts AS (
    SELECT
        lt.TechID,
        lt.Name AS LabTechnicianName,
        EXTRACT(YEAR FROM t.Labdate) AS TestYear,
        EXTRACT(MONTH FROM t.Labdate) AS TestMonth,
        COUNT(t.TestID) AS TestCount
    FROM
        LabTech lt JOIN Tests t ON lt.TechID = t.TechID
    GROUP BY
        lt.TechID, lt.Name, EXTRACT(YEAR FROM t.Labdate), EXTRACT(MONTH FROM t.Labdate)
)
SELECT
    LabTechnicianName,
    AVG(TestCount) AS AverageTestsPerMonth
FROM MonthlyTestCounts
GROUP BY LabTechnicianName
ORDER BY AverageTestsPerMonth DESC;

/*
list all the appointments for the midwife R for the week March 21 - March 25 of this year (2024).
The output will include the date and time of the appointment, health care card, name, and phone number of the mother.
*/

SELECT
    a.Adate AS AppointmentDate,
    a.Atime AS AppointmentTime,
    p.HealthID AS MotherHealthID,
    p.Name AS MotherName,
    p.Phone AS MotherPhoneNumber
FROM
    Appointment a 
JOIN Midwife m ON a.PractID = m.PractID
JOIN Pregnancy preg ON a.CoupleID = preg.CoupleID AND a.Pregtime = preg.Pregtime
JOIN Couple c ON preg.CoupleID = c.CoupleID
JOIN Mother mo ON c.MID = mo.MID
JOIN Person p ON mo.MID = p.PersonID
WHERE
    m.Name = 'Midwife R'
    AND a.Adate BETWEEN '2024-03-21' AND '2024-03-25';

/*
Query to List Blood Iron Test Results for Alice Johnson's Second Pregnancy
*/
SELECT
    t.Labdate,
    t.Results
FROM
    Tests t 
JOIN Pregnancy p ON t.CoupleID = p.CoupleID AND t.Pregtime = p.Pregtime
JOIN Couple c ON p.CoupleID = c.CoupleID
JOIN Mother mo ON c.MID = mo.MID
JOIN Person pe ON mo.MID = pe.PersonID
WHERE
    pe.Name = 'Alice Johnson'
    AND t.Type = 'Blood Iron'
    AND t.Pregtime = 2;

/*list the names of each birthing center/community clinic and the number of pregnancies 
that are due in July 2024.
The query will count a pregnancy towards a facility 
if the primary midwife is from that facility and will use the final agreed upon due date if available, otherwise it will use the expected time frame for birth.
*/
SELECT
    hi.Name AS FacilityName,
    COUNT(p.CoupleID) AS NumberOfPregnancies
FROM
    Pregnancy p
JOIN Midwife m ON p.PpractID = m.PractID
JOIN HealthInsti hi ON m.InstiID = hi.InstiID
WHERE
    (p.Estidued IS NOT NULL AND EXTRACT(MONTH FROM p.Estidued) = 7 AND EXTRACT(YEAR FROM p.Estidued) = 2024)
    OR (p.Estidued IS NULL AND EXTRACT(MONTH FROM p.Expdueym) = 7 AND EXTRACT(YEAR FROM p.Expdueym) = 2024)
GROUP BY hi.Name;

/*
list the health care card, name, and phone number of the mothers 
who are currently pregnant, have not yet given birth, 
under the care of a midwife employed by Community Clinic 5
*/
SELECT
    p.HealthID AS HealthCareCard,
    p.Name AS MotherName,
    p.Phone AS MotherPhoneNumber
FROM Pregnancy pr
JOIN Couple c ON pr.CoupleID = c.CoupleID
JOIN Mother mo ON c.MID = mo.MID
JOIN Person p ON mo.MID = p.PersonID
JOIN Midwife m ON pr.PpractID = m.PractID
JOIN HealthInsti hi ON m.InstiID = hi.InstiID
WHERE
    hi.Name = 'Community Clinic 5'
    AND (pr.Estidued >= CURDATE() OR pr.Expdueym >= CURDATE());

/*list the health care card and name of mothers 
who have had more than one baby in a single pregnancy, 
we can use a query that joins the relevant tables and groups by the mother's health care card and name.
List them only once even if they had multiple pregnancies where they had more than one baby. 
Count the babies whether they are born or not (yet)
*/
SELECT
    p.HealthID AS HealthCareCard,
    p.Name AS MotherName
FROM
    Pregnancy pr
JOIN Couple c ON pr.CoupleID = c.CoupleID
JOIN Mother mo ON c.MID = mo.MID
JOIN Person p ON mo.MID = p.PersonID
JOIN Baby b ON pr.CoupleID = b.CoupleID AND pr.Pregtime = b.Pregtime
GROUP BY p.HealthID, p.Name
HAVING COUNT(b.BabyID) > 1;

/*
create a view named `midwifeinfo` that shows the
practitioner ID, name, phone, and email of all the midwives, along with the name of the clinic/birthing center that employs them and the address of the facility
*/
CREATE VIEW midwifeinfo(PractitionerID, MidwifeName, MidwifePhone, MidwifeEmail, FacilityName, FacilityAddress) AS
SELECT
    m.PractID,
    m.Name,
    m.Phone,
    m.Email,
    hi.Name,
    hi.Address
FROM
    Midwife m
JOIN
    HealthInsti hi ON m.InstiID = hi.InstiID;
