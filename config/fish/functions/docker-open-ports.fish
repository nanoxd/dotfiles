function docker-open-ports -d "Open ports 40000 to 49000"
  for i in (seq 40000 49000);
    VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port$i,tcp,,$i,,$i";
    VBoxManage modifyvm "boot2docker-vm" --natpf1 "udp-port$i,udp,,$i,,$i";
  end
end
