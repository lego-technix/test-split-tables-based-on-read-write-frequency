
do $$
begin
   for counter in 1..1000000 loop
 	insert into "users" ("firstName", "lastName", "email", "username", "createdAt", "updatedAt") values('Marcel-' || counter, 'DUCHEMIN-' || counter, counter || '@example.org', counter, now(), now());
   end loop;
end; $$
