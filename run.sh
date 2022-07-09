which -s podman > /dev/null && \
  export DOCKER_HOST="unix:///$HOME/.local/share/containers/podman/machine/podman-machine-default/podman.sock" && \
  echo "Using DOCKER_HOST = $DOCKER_HOST"
docker run -it --rm \
  -p 8888:8888 -p 4040:4040 \
  --cpus=3.0 --memory=3500M \
  -v "$PWD":/home/jovyan/work \
  "$@" \
  jupyter/all-spark-notebook:spark-3.2.0
