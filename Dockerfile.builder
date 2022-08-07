FROM fablol/build-lede-env 
LABEL maintainer "ffqi <ffqi@outlook.com>"

WORKDIR /lede
ADD --chown=lede:lede . /lede
USER lede
RUN   whoami \
    && echo "$USER" \
    && sed -i 's/#src-git helloworld/src-git helloworld/g' ./feeds.conf.default \
    && ./scripts/feeds update -a \
    && ./scripts/feeds install -a \
    && git config --global --add safe.directory /lede \
    && git restore .config \
    && make defconfig \
    && make download -j$(nproc) \
    && find dl -size -1024c -exec rm -f {} \; \
    && make -j$(nproc) || make -j1 V=s 
VOLUME  /release

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["cp","/lede/bin/targets/x86/64/*","/release"]
