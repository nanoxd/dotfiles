function docker-ip -d "Docker: Get IP address"
  docker inspect (dl) | grep IPAddress | cut -d '""' -f 4
end
