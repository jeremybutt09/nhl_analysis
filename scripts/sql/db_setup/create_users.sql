prompt>Dropping users
DROP USER JEREMYBUTT CASCADE;

prompt>Creating users
CREATE USER JEREMYBUTT IDENTIFIED BY system DEFAULT TABLESPACE users;

prompt>Granting privileges
GRANT ALL PRIVILEGES TO JEREMYBUTT;