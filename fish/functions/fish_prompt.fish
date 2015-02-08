function fish_prompt
	set -l old_status $status

  if not set -q -g __fish_robbyrussell_functions_defined
    set -g __fish_robbyrussell_functions_defined
    function _git_branch_name
      echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
    end

    function _is_git_dirty
      echo (git status -s --ignore-submodules=dirty ^/dev/null)
    end
  end

  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l red (set_color -o red)
  set -l green (set_color -o green)
  set -l blue (set_color -o blue)
  set -l normal (set_color normal)
  set -l cwd $cyan(basename (prompt_pwd))
  set -l dirty "$yellow X"

  if [ (_git_branch_name) ]
    set -l git_branch $red(_git_branch_name)
		set -l git_sha (git rev-parse --short HEAD)
    set git_info "$blue git:($git_branch$blue:$green$git_sha$blue)"

    if [ (_is_git_dirty) ]
      set git_info "$git_info$dirty"
    end
  end

	if [ $old_status -ne 0 ]
    set arrow " $red$old_status > "
  else
    set arrow "$green > "
  end
  echo -n -s $cwd $git_info $arrow
end
