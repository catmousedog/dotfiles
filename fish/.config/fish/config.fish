if status is-interactive
	set fish_greeting
	function mcdir
		mkdir $argv; cd $argv;
	end

end
