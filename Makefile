switch:
# make switch ip=<address>
	nixos-rebuild --flake .?submodules=1#rebost --target-host root@$(ip) switch;