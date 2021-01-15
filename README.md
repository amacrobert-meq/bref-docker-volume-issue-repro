
# bref-docker-volume-issue-repro

Reproduction of an issue I'm seeing when using the bref php docker images for local development in conjunction with a volume defined in docker-compose.

## Steps to reproduce

1. Build and run the container: `docker-compose up --build -d`
2. Run index.php: `docker exec -it volume-issue php index.php`
3. In an editor on the host machine, switch the lines that are commented in index.php
4. Run index.php again: `docker exec -it volume-issue php index.php`

### Expected behavior

Step 2 should output
> Hello again, friend of a friend, I knew you when

Step 4 should output
> Our common goal was waiting for the world to end

### Actual behavior

Step 2 outputs
> Hello again, friend of a friend, I knew you when

Step 4 also outputs
> Hello again, friend of a friend, I knew you when

## Notes

Looking at index.php on the machine using `docker exec -it volume-issue cat index.php` shows that the file is correctly getting updated in the container.

The only workaround I've found is to recreate the container: `docker compose up --build -d --force-recreate`

I think this is due to opcache not checking timestamps/invalidating (which would makes sense on prod), but I'm unsure how to address it for dev.
