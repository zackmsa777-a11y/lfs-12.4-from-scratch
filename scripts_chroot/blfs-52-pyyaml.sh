set -e
cd /sources
rm -rf pyyaml-6.0.3
tar xf pyyaml-6.0.3.tar.gz
cd pyyaml-6.0.3
pip3 wheel -w dist --no-build-isolation --no-deps --no-cache-dir $PWD
pip3 install --no-index --find-links dist --no-user PyYAML
cd /sources
rm -rf pyyaml-6.0.3
