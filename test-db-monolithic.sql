
do $$
begin
   for counter in 1..1000000 loop
 	update "users" set "lastLoggedAt"=now(), "updatedAt"=now() where id=(select floor (random () * 1000000 + 1) :: int);
	 -- "perform" is for a "select" when the returned values are not used
 	perform * from "users" where id=(select floor (random () * 1000000 + 1) :: int);
   end loop;
end; $$
