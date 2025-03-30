# Default action.
all:
	- make compose
	- make run

# Compose graph.
compose:
	npx wgc router compose -i graphs.yaml -o config.json

# Run the router container.
run:
	docker run \
		--rm \
		--name cosmo-router \
		-p 3002:3002 \
  		--net=host \
		-v ./config.json:/app/config.json \
		--env-file ./.env \
		ghcr.io/wundergraph/cosmo/router:latest



