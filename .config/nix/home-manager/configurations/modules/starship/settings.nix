{
  character = {
    success_symbol = "[❯❯](bold fg:183)";
    error_symbol = "[❯❯](bold red)";
  };

  username = {
    show_always = true;
    style_user = "fg:112";
    format = "[$user]($style)[@](fg:116)";
  };

  hostname = {
    ssh_only = false;
    style = "fg:36";
  };

  directory = {
    truncate_to_repo = false;
    truncation_length = 0;
    style = "fg:30";
  };

  git_branch = {
    style = "bold fg:183";
  };
}
