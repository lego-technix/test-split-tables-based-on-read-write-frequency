
do $$
begin
   for counter in 1..1000 loop
 	update "user-logins" set "lastLoggedAt"=now(), "updatedAt"=now() where "userId"=(select floor (random () * 1000000 + 1) :: int);
      	-- "perform" is for a "select" when the returned values are not used
	perform * from "users" where id=(select floor (random () * 1000000 + 1) :: int);
   end loop;
end; $$
