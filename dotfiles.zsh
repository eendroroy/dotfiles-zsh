#!/usr/bin/env zsh

__list(){
	pushd ${HOME}/.dotfiles-zsh
	ls -d * | xargs -L1 -I{} echo "      ==> {}"
	popd
}

__help(){
  echo "
	Usage: dotfiles <command> [candidate]

	   commands:
	       install   or i    <candidate>
	       uninstall or rm   <candidate>
	       list      or ls   [candidate]
	       use       or u    <candidate>
	       current   or c    [candidate]
	       upgrade   or ug   [candidate]
	       help      or h
	"
}

__use(){
	pushd ${HOME}/.dotfiles-zsh/${1}
	./install
	popd
	echo $1 > ${HOME}/.dotfiles-zsh/current
}

__install(){
	# echo "git clone https://github.com/${1}.git ${HOME}/.dotfiles-zsh/`echo $1 | tr '/' '_'`"
	git clone https://github.com/${1}.git ${HOME}/.dotfiles-zsh/`echo $1 | tr "/" "_"`
}

__uninstall(){
	pushd ${HOME}/.dotfiles-zsh/
	rm -rf ${1}
	popd
}

__current(){
	pushd ${HOME}/.dotfiles-zsh/
	cat current
	popd
}

__upgrade(){
	pushd ${HOME}/.dotfiles-zsh/${1}
	git pull origin master
	popd
}

__evaluate(){
	eval "__${1} $2"
}

dotfiles(){
	COMMAND="$1"
	QUALIFIER="$2"
	case "$COMMAND" in
		(l) COMMAND="list"  ;;
		(ls) COMMAND="list"  ;;
		(h) COMMAND="help"  ;;
		(u) COMMAND="use"  ;;
		(i) COMMAND="install"  ;;
		(rm) COMMAND="uninstall"  ;;
		(c) COMMAND="current"  ;;
		(ug) COMMAND="upgrade"  ;;
	esac
	
	mkdir -p "${HOME}/.dotfiles-zsh"
	
	__evaluate $COMMAND $QUALIFIER
}