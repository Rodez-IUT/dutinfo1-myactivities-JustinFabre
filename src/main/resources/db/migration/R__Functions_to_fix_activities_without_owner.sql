CREATE OR REPLACE FUNCTION get_default_owner() RETURNS "user" AS $$

DECLARE 

defaultOwner "user"%rowtype;
defaultOwnerUsername varchar(500) := "Default Owner";

BEGIN
        
SELECT * into defaultOwner
FROM "user"
WHERE username = defaultOwnerUsername;


IF not found THEN

INSERT INTO "user"
VALUES(nextval('id_generator'), defaultOwnerUsername);

SELECT * into defaultOwner
FROM "user" 
WHERE username = defaultOwnerUsername;

END IF;

RETURN defaultOwner ;

END;

$$ language plpgsql;





