#!/usr/bin/env bash

help() {
  cat <<EOF
  $0: Run Jupyter (or BeakerX) for JustEnoughScalaForSpark

  usage: $0 [-h | --help] [-b | --beakerx] [docker_options]

  where:
  -h | --help      Print this message and exit.
  -b | --beakerx   Use BeakerX (http://beakerx.com) instead of Jupyter, the default.
  docker_options   All other arguments are passed as arguments to the docker command.

EOF
}

home=/home/jovyan
image=jupyter/all-spark-notebook
docker_options=()
while [ $# -gt 0 ]
do
  case $1 in
    -h|--h*)
      help
      exit 0
      ;;
    -b|--beak*)
      home=/home/beakerx
      image=beakerx/beakerx
      echo "Using BeakerX"
      ;;
    *)
      docker_options=(${docker_options[@]} $1)
      ;;
  esac
  shift
done

# Invoke this script with NOOP=echo run.sh ... to see the command but not run it:
$NOOP docker run -it --rm -p 8888:8888 -p 4040:4040 --cpus=2.0 --memory=2500M \
  -v "$PWD":$home/$(basename $PWD) "${docker_options[@]}" $image
