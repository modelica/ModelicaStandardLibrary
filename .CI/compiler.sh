DATE=`date +%Y%m%d`
sudo docker build -t modelicastandardlibrary/build-deps:amd64-$DATE compilers
sudo docker build --build-arg ARCH=i386/ -t modelicastandardlibrary/build-deps:i386-$DATE compilers
