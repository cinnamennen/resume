FROM texlive/texlive:latest

RUN apt-get update && apt-get install -y \
    fonts-roboto \
    fonts-adobe-sourcesans3 \
    && rm -rf /var/lib/apt/lists/*

# Pre-generate the LuaTeX font cache as the texlive user (UID 1000)
# so it's found when running with --user $(id -u):$(id -g)
USER texlive
RUN luaotfload-tool --update
USER root

WORKDIR /doc
