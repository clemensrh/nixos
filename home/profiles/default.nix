# Reference map showing profile structure (not actively used in current flake).
# Profiles are loaded directly by host configs in hosts/default.nix.
# 
# Profile wiring:
# - hosts/default.nix → mkHost → home-manager.users.clemens = import ../home/profiles/{snowflake,raspberry}
# - Each profile imports: ../base + host-specific modules
{
  # "clemens@snowflake" = [ ../.. ./snowflake ];
  # "clemens@raspberry" = [ ../.. ./raspberry ];
}
