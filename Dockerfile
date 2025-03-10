# Basis-Image als Argument
ARG BASE_IMAGE=ubuntu:latest
FROM ${BASE_IMAGE}

# Argumente für Benutzer und Home-Verzeichnis
ARG USERNAME=user
ARG USER_HOME=/home/${USERNAME}

# Umgebungsvariablen
ENV ZSH_CUSTOM=${USER_HOME}/.oh-my-zsh/custom

# System-Updates und Installation von notwendigen Paketen
RUN apt-get update && apt-get install -y \
    curl \
    git \
    sudo \
    zsh \
    locales \
    && rm -rf /var/lib/apt/lists/*

# UTF-8 locales installieren und konfigurieren
RUN locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

# Benutzer erstellen und Berechtigungen setzen
RUN useradd -ms /bin/bash ${USERNAME} && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${USERNAME}
WORKDIR ${USER_HOME}

# Oh My Zsh installieren
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# zsh-autosuggestions Plugin installieren
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting Plugin installieren
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting

# fzf installieren
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ${USER_HOME}/.fzf && \
    ${USER_HOME}/.fzf/install --all

# Starship prompt installieren
RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes

# Starship-Konfigurationsdatei kopieren
COPY starship.toml ${USER_HOME}/.config/starship.toml
COPY .zshrc ${USER_HOME}/.zshrc
# Symlink für die Zsh-Verlaufsdatei erstellen
RUN ln -s /mnt/host-home/.zsh_history ${USER_HOME}/.zsh_history

# Zsh als Standard-Shell setzen
USER root
RUN chsh -s $(which zsh) ${USERNAME}
USER ${USERNAME}

################
## User setup
################

## Register new script as container start point -- this allows the container
#  to block attempts to start it directly via "docker run"
ENTRYPOINT ["/bin/bash", "/makeuser.sh"]