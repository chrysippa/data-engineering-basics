-- SQL queries to investigate and alter a community database in an IBM DB2 instance
-- Relevant tables include:
--     CENSUS
--     CRIME
--     SCHOOLS
-- SQL skills used include joins, views, stored procedures, and transactions

-- What are the attendance rates at schools with a very high hardship score?
SELECT S.NAME, C.COMMUNITY_AREA_NAME, S.AVERAGE_STUDENT_ATTENDANCE 
FROM SCHOOLS AS S
LEFT OUTER JOIN CENSUS AS C ON S.COMMUNITY_AREA_NUMBER = C.COMMUNITY_AREA_NUMBER
WHERE C.HARDSHIP_INDEX = 98;

-- Which specific crimes happened at a school? Where did they happen?
SELECT CASE_NUMBER, CRIME_TYPE, COMMUNITY_AREA_NAME
FROM CRIME AS CRI
LEFT OUTER JOIN CENSUS AS CEN ON CRI.COMMUNITY_AREA_NUMBER = CEN.COMMUNITY_AREA_NUMBER 
WHERE LOCATION_DESCRIPTION LIKE '%SCHOOL%';

-- Creating a view that shows only school names and their ratings on various quality metrics
CREATE OR REPLACE VIEW SCHOOL_RATINGS 
	(School_Name, 
	Safety, 
	Family, 
	Environment, 
	Instruction, 
	Leaders, 
	Teachers) 
AS SELECT 
	NAME,
	SAFETY_ICON,
	FAMILY_INVOLVEMENT_ICON,
	ENVIRONMENT_ICON,
	INSTRUCTION_ICON,
	LEADERS_ICON,
	TEACHERS_ICON
FROM SCHOOLS;

-- Creating a stored procedure to ensure ratings are consistent with the scores they are based on
-- This procedure is for the LEADERS_ICON attribute; similar procedures would modify other ratings

--#SET TERMINATOR @
CREATE OR REPLACE PROCEDURE UPDATE_LEADERS_RATING (
	IN School_ID_arg INTEGER, IN Leader_Score_arg INTEGER)
LANGUAGE SQL
MODIFIES SQL DATA
BEGIN
	UPDATE SCHOOLS
	SET Leaders_Score = Leader_Score_arg
	WHERE SCHOOL_ID = School_ID_arg;

	IF Leader_Score_arg >= 80 AND Leader_Score_arg < 100 THEN
		UPDATE SCHOOLS
		SET LEADERS_ICON = 'Very high'
		WHERE SCHOOL_ID = School_ID_arg;
	ELSEIF Leader_Score_arg >= 60 THEN
		UPDATE SCHOOLS
		SET LEADERS_ICON = 'High'
		WHERE SCHOOL_ID = School_ID_arg;
	ELSEIF Leader_Score_arg >= 40 THEN
		UPDATE SCHOOLS
		SET LEADERS_ICON = 'Medium'
		WHERE SCHOOL_ID = School_ID_arg;
	ELSEIF Leader_Score_arg >= 20 THEN
		UPDATE SCHOOLS
		SET LEADERS_ICON = 'Low'
		WHERE SCHOOL_ID = School_ID_arg;
	ELSEIF Leader_Score_arg >= 0 THEN
		UPDATE SCHOOLS
		SET LEADERS_ICON = 'Very low'
		WHERE SCHOOL_ID = School_ID_arg;
	ELSE -- If passed an invalid score
		ROLLBACK WORK;
	END IF;
	COMMIT WORK;
END
@

-- An example call for the stored procedure
CALL UPDATE_LEADERS_RATING(400018, 50);