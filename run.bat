docker run -it --rm -p 8888:8888 -p 4040:4040 --cpus=3.0 --memory=3500M -v "%CD%":/home/jovyan/work jupyter/all-spark-notebook:spark-3.2.0
