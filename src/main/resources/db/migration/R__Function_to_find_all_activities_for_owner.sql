CREATE OR REPLACE FUNCTION find_all_activities_for_owner(owner varchar(30)) RETURNS SETOF activity AS $$
SELECT * 
FROM activity 
WHERE owner_id = ( SELECT id FROM "user"
				 WHERE owner = username);
$$ LANGUAGE SQL ;