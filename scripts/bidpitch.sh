PATH=$(pwd)/bin:$PATH
git clone https://github.com/tlicata/bidpitch.git
cd bidpitch
lein uberjar
