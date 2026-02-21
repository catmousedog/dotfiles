# Variables
STOW_PKGS := awww backgrounds code fish hypridle hyprland kitty quickshell rofi themes watrix yazi 
SYS_STOW_PKGS := greetd

.PHONY: all install user system clean

# Stow to $HOME and root
user:
	stow --target=$(HOME) --restow $(STOW_PKGS)

system:
	sudo stow --target=/ --restow $(SYS_STOW_PKGS)

user-adopt:
	stow --target=$(HOME) --restow $(STOW_PKGS) --adopt

system-adopt:
	sudo stow --target=/ --restow $(SYS_STOW_PKGS) --adopt

# Unstow everything
clean:
	stow --target=$(HOME) -D $(STOW_PKGS)
	sudo stow --target=/ -D $(SYS_STOW_PKGS)
