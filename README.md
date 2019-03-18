# Dabops
> Don't know why this name for a coffee machine!

# How to build your amazing coffee machine
``` bash
# Clone this repository
$ https://github.com/dabops/dabops.git

# Use our tool for initialization
# This will fetch all the repository from 'repository.txt'
# and put them into the microservices
$ tools/init.sh

# Regenerate the .env file for our expresso app
$ cp microservices/expresso/.env.example microservices/expresso/.env

# You just have to run them then !
$ docker-compose up --build
```

Let's see our preparation : [http://mocaccino.docker.localhost](http://mocaccino.docker.localhost)

# How about our infrastructure
##We are using:

**Traefik** as a _reverse proxy_\
**Lumen** as a _API_ (expresso)\
**NuxtJs** as a _Front_ (mocaccino, ristretto)\
**mysql** as _database_\
**CircleCi** for automate our pipeline from commit to deploy\
**Docker** to manage our containers\
**Git** for versionning\
**Sentry** for logging errors\
**Slack** to centralize effort of communication\
**Trello** to manage our works\
**Jsdoc** to generate js documentation\
**OurBrain** to organize\
**Coffee** for motivation

# This is our team !
robin.baillargeaux\
rubie.de-oliveira\
romain.sauvaire-dassac\
alan.thorigny\
fabio.rocco
