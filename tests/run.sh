#!/bin/sh
# Run mapping tests in Podman or Docker.
set -e
cd "$(dirname "$0")"

if command -v podman >/dev/null 2>&1; then
	if podman compose version >/dev/null 2>&1; then
		COMPOSE="podman compose"
	elif command -v podman-compose >/dev/null 2>&1; then
		COMPOSE="podman-compose"
	else
		echo "podman found, but no compose plugin" >&2
		exit 1
	fi
elif command -v docker >/dev/null 2>&1; then
	COMPOSE="docker compose"
else
	echo "need podman or docker" >&2
	exit 1
fi

$COMPOSE -f compose.yml run --rm mappings
