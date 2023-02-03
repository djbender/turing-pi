# syntax=docker/dockerfile:1
FROM ubuntu:jammy

RUN bash <<EOT
  set -exu -o pipefail
  apt-get update
  apt-get install --yes --no-install-recommends \
    nala
  yes | nala fetch --auto -c US -c CA -c MX
  nala install --assume-yes --no-install-recommends \
    bc \
    build-essential \
    bzr \
    cpio \
    cvs \
    ecj \
    file \
    flex \
    gawk \
    git \
    lib32stdc++6 \
    lib32z1 \
    lib32z1-dev \
    libncurses-dev \
    libncurses5-dev \
    libssl-dev \
    libxml-parser-perl \
    mercurial \
    mkbootimg \
    quilt \
    rsync \
    subversion \
    u-boot-tools \
    unzip \
    wget \
    xsltproc \
    xxd \
    zlib1g-dev
EOT

WORKDIR /usr/src/app/
COPY . /usr/src/app/

# notes for me
# RUN --mount=type=cache,target=/usr/src/app/buildroot set -exu; \
# --mount=type=cache,target=/usr/src/app/buildroot/output,sharing=locked \

# RUN \
#   --mount=type=cache,target=/usr/src/app/buildroot/dl \
#   set -exu; \
#   \
#   cd buildroot \
#   && make -j $(nproc) BR2_EXTERNAL="../br2t113pro" 100ask_t113-pro_spinand_core_defconfig \
#   && make -j $(nproc) cjson V=1 \
#   && make -j $(nproc) uboot V=1 \
#   && make -j $(nproc) V=1 \
#   && cd ../ \
#   && mkdir -p buildroot/output/images \
#   && mkdir -p buildroot/output/build/linux-5112fdd843715f1615703ca5ce2a06c1abe5f9ee/arch/arm/boot/dts/ \
#   && mkdir -p buildroot/output/build/linux-5112fdd843715f1615703ca5ce2a06c1abe5f9ee/.config \
#   && mkdir -p buildroot/output/build/swupdate-2021.11/.config \
#   && cp bmc4tpi/config/sun8iw20p1* buildroot/output/build/linux-5112fdd843715f1615703ca5ce2a06c1abe5f9ee/arch/arm/boot/dts/ \
#   && cp bmc4tpi/config/kernelconfig buildroot/output/build/linux-5112fdd843715f1615703ca5ce2a06c1abe5f9ee/.config \
#   && cp bmc4tpi/config/swupdateconfig buildroot/output/build/swupdate-2021.11/.config \
#   && cp bmc4tpi/swupdate/sw-description buildroot/output/images/ \
#   && cp bmc4tpi/swupdate/genSWU.sh buildroot/output/images/ \
#   && cp bmc4tpi/swupdate/env0.fex buildroot/output/images/ \
#   && cp bmc4tpi/swupdate/env1.fex buildroot/output/images/ \
#   && cd buildroot \
#   && make linux-rebuild
#
# RUN set -exu; \
#   \
#   cd buildroot \
#   && make swupdate-rebuild
#
# RUN set -exu; \
#   \
#   cd buildroot \
#   && make V=1
#
# RUN set -exu; \
#   \
#   cd buildroot/output/images/ \
#   && ./genSWU.sh 1.0.0
#
# CMD ["bash"]
