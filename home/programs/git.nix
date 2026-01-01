{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Clemens";
      user.email = "clemens@clemensh.me";
      core.editor = "nvim";
      pull.rebase = true;
    };
  };
}
