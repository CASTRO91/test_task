     H
     FSELCUSTLF IF   E           K Disk
      *
     D COUNT           S              2S 0
     D KEY             S                   LIKE(UGFCPNC)
      *
     C
      /Free
       EXEC SQL
         Set option commit = *NONE;
       EXEC SQL
         DROP TABLE  CUSTCRTUR;
       EXEC SQL
         CREATE TABLE CUSTCRTUR AS
          (SELECT UGFCPNC AS CPNC,
          USAIBAN AS IBAN,
          USATA AS TA,
          USADOM AS DOM,
          USACCY AS CCY,
          USAAMA AS AMA
          FROM  SELCUSTLF) WITH NO DATA;
        KEY = 'UR2C8A';
        Setll KEY SELCUSTLF;
        READE KEY SELCUSTLF;
        DoW Not %Eof(SELCUSTLF);
          EXEC SQL
          SELECT count(*) into : COUNT
           FROM CUSTCRTUR
           WHERE IBAN = :USAIBAN;
          IF COUNT = 0;
           EXEC SQL
            INSERT INTO CUSTCRTUR VALUES
             (:UGFCPNC,:USAIBAN,:USATA,:USADOM,:USACCY,:USAAMA) ;
          ELSE;
            EXEC SQL
             UPDATE CUSTCRTUR
              SET AMA = AMA + :USAAMA
              WHERE IBAN = :USAIBAN;
          ENDIF;
          READE KEY SELCUSTLF;
        EndDo;
        DSPLY 'success';
       *inlr = *on;
      /End-Free
