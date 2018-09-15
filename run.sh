cd ZooReach
cd contrib/docker
docker-compose up -d --build
docker-compose restart ckan
docker-compose logs -f ckan >> ckan.log
docker-compose logs -f solr >> solr.log
docker-compose logs -f redis >> redis.log
docker-compose logs -f db >> db.log
docker-compose logs -f datapusher >> datapusher.log
docker exec -it db psql -U ckan -f postgresql/docker-entrypoint-initdb.d/00_create_datastore.sh
docker exec ckan /usr/local/bin/ckan-paster --plugin=ckan datastore set-permissions -c /etc/ckan/production.ini | docker exec -i db psql -U ckan
