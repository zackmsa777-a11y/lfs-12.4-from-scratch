set -e
cd /sources
tar xf texinfo-7.2.tar.xz
cd texinfo-7.2
sed 's/! $output_file eq/$output_file ne/' -i tp/Texinfo/Convert/*.pm
./configure --prefix=/usr
make
make install
make TEXMF=/usr/share/texmf install-tex
cd /sources
