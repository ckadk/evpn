MAC01='00:00:00:01:00:01'
MAC02='00:00:00:01:00:02'
echo "Move ${MAC01} back to leaf1"
sudo docker exec -it host-1-100 ip link set address $MAC01 dev eth1.100
sudo docker exec -it host-1-100 ip addr flush dev eth1.100
sudo docker exec -it host-1-100 ip addr add 192.168.100.1/24 brd 192.168.100.255 dev eth1.100
sudo docker exec -it host-1-100 ip link set dev eth1.100 up
sudo docker exec -it host-2-100 ip link set address $MAC02 dev eth1.100
sudo docker exec -it host-2-100 ip addr flush dev eth1.100
sudo docker exec -it host-2-100 ip addr add 192.168.100.2/24 brd 192.168.100.255 dev eth1.100
echo "DONE"
sudo docker exec -it host-1-100 arping -A -c2 -I eth1.100 192.168.100.1
sudo docker exec -it host-2-100 arping -A -c2 -I eth1.100 192.168.100.2
