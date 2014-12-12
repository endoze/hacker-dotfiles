# Hacker Dotfiles

This repo contains a small set of dotfiles to help you build out your own.


## Setup

### Docker Container

If you would like to run these dotfiles in a Docker container and take
everything for a test drive you can.

#### Build Image

```sh
docker build -t hacker/base .
```

#### Run Container

```sh
docker run -i -t --name hacker_dotfiles hacker/base /bin/zsh
```

You can optionally pass the `-v` flag along with a directory to persist
data across containers. The volume is mounted at /root/code.

```sh
docker run -i -t --name hacker_dotfiles -v /path/to/mount:/root/code:rw hacker/base /bin/zsh
```

#### Tools Included in Container

- [Vim](http://vim.org)
- [Pry](http://pryrepl.org)
- [Git](http://git-scm.com)
- [Tmux](http://tmux.sourceforge.net)
- [ZSH](http://zshwiki.org)
- [Antigen](http://zshwiki.org)
- [Rbenv](https://github.com/sstephenson/rbenv)
- [RCM](https://github.com/thoughtbot/rcm)

### Run on your own machine

In order to use these dotfiles outside of Docker, you have a couple options. The simplest is
to just symlink the ones you'd like to try out into your home directory.

If you have [RCM](https://github.com/thoughtbot/rcm) installed, you can use that to manage
taking these for a spin as well.


