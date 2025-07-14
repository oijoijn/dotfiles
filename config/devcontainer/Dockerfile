# ────────── Stage 1: builder ──────────
FROM debian:stable-slim AS builder

ARG NVIM_VERSION=latest        # 例: v0.11.3
ARG NODE_VERSION=20.x          # 22.x などにも変更可
ENV DEBIAN_FRONTEND=noninteractive

# 基本ツール + Node.js + Neovim を取得
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl ca-certificates gnupg xz-utils \
        build-essential \
        python3 python3-pip \
        apt-transport-https && \
    \
    # ----- Node.js (binary repo) -----
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
      | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_VERSION} nodistro main" \
      > /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && apt-get install -y --no-install-recommends nodejs && \
    \
    # ----- Neovim -----
    curl -LO https://github.com/neovim/neovim/releases/${NVIM_VERSION}/download/nvim-linux-x86_64.tar.gz && \
    tar -C /opt -xzf nvim-linux-x86_64.tar.gz && \
    rm nvim-linux-x86_64.tar.gz && \
    \
    # ----- Clean builder -----
    apt-get purge -y build-essential && \
    apt-get autoremove -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/*


# ────────── Stage 2: runtime ──────────
FROM debian:stable-slim
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /workspace

# 最小依存 + zsh + git + python3
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates curl gnupg \
        python3 python3-pip \
        git \
        zsh && \
    # python → python3 のエイリアスを用意
    ln -s /usr/bin/python3 /usr/local/bin/python && \
    rm -rf /var/lib/apt/lists/*

# ----- Node.js -----
COPY --from=builder /usr/bin/node /usr/bin/
COPY --from=builder /usr/lib/node_modules /usr/lib/node_modules
COPY --from=builder /usr/lib/x86_64-linux-gnu/libnode* /usr/lib/x86_64-linux-gnu/
ENV PATH="/usr/lib/node_modules/npm/bin:/usr/bin:$PATH"

# ----- Neovim -----
COPY --from=builder /opt/nvim-linux-x86_64 /opt/nvim
RUN ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim

# ----- デフォルト CMD -----
CMD ["tail", "-F", "/dev/null"]
