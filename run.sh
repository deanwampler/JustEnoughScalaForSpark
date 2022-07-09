export DOCKER_CMD=docker
which -s podman > /dev/null
if [[ $? -eq 0 ]]
then
  DOCKER_CMD=podman
  export DOCKER_HOST="unix:///$HOME/.local/share/containers/podman/machine/podman-machine-default/podman.sock"
  export PODMAN_OPTS="--userns=keep-id"
  echo "Using podman..."
  echo "Setting DOCKER_HOST = $DOCKER_HOST"
fi

# If you want to pass other arguments to the container, like a different command to run,
# just pass them to this script.
# To see what's executed without running the command use "NOOP=echo run.sh ..."
$NOOP $DOCKER_CMD run -it --rm \
  -p 8888:8888 -p 4040:4040 -p 4041:4041 -p 4042:4042 \
  --cpus=3.0 --memory=3500M \
  $PODMAN_OPTS \
  -v "$PWD":/home/jovyan/work \
  jupyter/all-spark-notebook:spark-3.2.0 \
  "$@"
