DROP VIEW IF EXISTS CREDTURN;

CREATE VIEW CREDTURN AS
SELECT USAIBAN, SUM(USAAMA) AS CRTUR
FROM USAPF
WHERE USATA ='C' AND USADOM BETWEEN 1190701 AND 1190731
GROUP BY USAIBAN;

CREATE TABLE IF NOT EXISTS CUSTCRTUR AS
SELECT USCCPNC AS CPNC, UGFSCUN AS SCUN, USAIBAN AS IBAN, CRTUR, USCCCY AS CCY
FROM CREDTURN
JOIN USCPF ON USAIBAN = USCIBAN
JOIN UGFPF ON UGFCPNC = USCCPNC
ORDER BY USCCPNC;

SELECT * FROM CAMCR
