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

  END

$$ language plpgsql;

CREATE OR REPLACE FUNCTION fix_activities_without_owner() RETURNS SETOF activity AS $$

  DECLARE 

	defaultOwner "user"%rowtype;
	nowDate date = now();

  BEGIN

	defaultOwner := get_default_owner();
	return query
	update activity
	SET owner_id = defaultOwner.id,
	    modification_date = nowDate
	    where owner_id is null
	    returning *;
	    
  END
 $$ language plpgsql;

	
	
	