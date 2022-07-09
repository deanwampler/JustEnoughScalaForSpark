podman run -it --rm -p 8888:8888 -p 4040:4040 -p 4041:4041 -p 4042:4042 --cpus=3.0 --memory=3500M --userns=keep-id -v "%CD%":/home/jovyan/work jupyter/all-spark-notebook:spark-3.2.0
