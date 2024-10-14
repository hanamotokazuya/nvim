# Installation of Neovim

## Pre-built archives

The Releases page provides pre-built binaries for Linux sysems.

```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
sudo rm nvim-linux64.tar.gz
sudo mv /opt/nvim-linux64 /opt/nvim
```

After this step add this to `~/.bashrc`:

```bash
export PATH="$PATH:/opt/nvim/bin"
```

## Install node

```bash
sudo apt install -y nodejs npm
sudo npm install -n -g
sudo n stable
sudo apt purge -y nodejs npm
sudo apt autoremove -y
```

## Install Neovim Plugin

```bash
cd ~/.config
git clone https://github.com/hanamotokazuya/nvim.git
```

After this step open the nvim once or twice.
