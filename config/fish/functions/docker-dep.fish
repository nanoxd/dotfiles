function docker-dep -d "Docker: Show image dependencies"
  docker images -viz | dot -Tpng -o docker.png
end
