Twitter clone follow instructions in [rails-tutorial ver 4.0](https://rails-4-0.railstutorial.org/)

I re-write its front-end by using React instead of rails rendered app.

To start app:
1. Run `psql postgres` to connect to psql.
2. Check if role named `postgres` exists & its privileges by running `\du`
3a. Create if doesn't exist `CREATE ROLE postgres WITH SUPERUSER CREATEDB LOGIN`
3b. Alter role if exist `ALTER ROLE postgres WITH SUPERUSER CREATEDB LOGIN`
4. Run `bin/boot_dev`
5. Navigate to `localhost:8080`
