if test -f /etc/profile.d/git-sdk.sh; then
	TITLEPREFIX=SDK-${MSYSTEM#MINGW}
else
	TITLEPREFIX=$MSYSTEM
fi

if test -f ~/.config/git/git-prompt.sh; then
	. ~/.config/git/git-prompt.sh
else
	PS1='\n'
	PS1="$PS1"'\[\033[1;30m\][\@]'

	if test -z "$WINELOADERNOEXEC"; then
		GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
		COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
		COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
		COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
		if test -f "$COMPLETION_PATH/git-prompt.sh"; then
			. "$COMPLETION_PATH/git-completion.bash"
			. "$COMPLETION_PATH/git-prompt.sh"
			PS1="$PS1"'\[\033[31m\]`__git_ps1`' # bash function
		fi
	fi
	PS1="$PS1"'\n'
	PS1="$PS1"'\[\033[1;32m\]\w'
	PS1="$PS1"'\n'
	PS1="$PS1"'\[\033[1;31m\]$ '
	PS1="$PS1"'\[\033[00m\]'
fi

MSYS2_PS1="$PS1" # for detection by MSYS2 SDK's bash.basrc

# Evaluate all user-specific Bash completion scripts (if any)
if test -z "$WINELOADERNOEXEC"; then
	for c in "$HOME"/bash_completion.d/*.bash; do
		# Handle absence of any scripts (or the folder) gracefully
		test ! -f "$c" ||
			. "$c"
	done
fi
