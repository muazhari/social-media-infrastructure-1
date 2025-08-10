# Default action.
all:
	- make run-datastore
	- make run-backend
	- make run-gateway
	- make run-router
	- make run-frontend

# Run dev containers.
run-dev:
	- make run-datastore
	- make run-gateway
	- make run-router

# Remove all containers.
remove-all:
	- docker compose down frontend-1
	- docker compose down router-1
	- docker compose down gateway-1
	- docker compose down backend-1 backend-2
	- docker compose down datastore-1 datastore-2 datastore-3 datastore-4 datastore-5 kafka-ui-1

# Run gateway containers.
run-gateway:
	docker compose -f docker-compose.yml up -d gateway-1

# Run frontend containers.
run-frontend:
	docker compose -f docker-compose.yml up -d frontend-1

# Run router containers.
run-router:
	docker compose -f docker-compose.yml up -d router-1

# Run backend containers.
run-backend:
	docker compose -f docker-compose.yml up -d backend-1 backend-2

# Run datastore containers.
run-datastore:
	docker compose -f docker-compose.yml up -d datastore-1 datastore-2 datastore-3 datastore-4 datastore-5 kafka-ui-1

# create subgraphs.
create-subgraph:
	- npx wgc subgraph create backend-1 --namespace default --routing-url http://172.23.128.1:8081/graphql
	- npx wgc subgraph create backend-2 --namespace default --routing-url http://172.23.128.1:8082/graphql
	- npx wgc subgraph create backend-edg --namespace default --event-driven-graph

# publish subgraphs.
publish-subgraph:
	- npx wgc subgraph publish backend-1 --namespace default --schema ./backend-1-schema.graphqls
	- npx wgc subgraph publish backend-2 --namespace default --schema ./backend-2-schema.graphqls
	- npx wgc subgraph publish backend-edg --namespace default --schema ./backend-edg-schema.graphqls

# delete subgraphs.
delete-subgraph:
	- npx wgc subgraph delete backend-1 --namespace default --force
	- npx wgc subgraph delete backend-2 --namespace default --force
	- npx wgc subgraph delete backend-edg --namespace default --force
