CREATE VIEW VAOP06AS400
AS
SELECT * FROM OPENQUERY(LKAS400DESARROLLO, 'SELECT * FROM MAEDES.DB021.AOP06 ') operAS400
where fecha06='200803'