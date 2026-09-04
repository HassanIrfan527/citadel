{ pkgs, ... }:
{
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "https";
    };
  };

  programs.git = {
    enable = true;

    # Main/default profile
    settings = {

      user = {
        email = "harryed525@gmail.com";
        name = "HassanIrfan527";
      };

      core = {
        editor = "nvim";
        hooksPath = "/home/dweller/.git-hooks";
      };

      "credential \"https://github.com\"" = {
        helper = "!${pkgs.gh}/bin/gh auth git-credential";
      };

      "credential \"https://gist.github.com\"" = {
        helper = "!${pkgs.gh}/bin/gh auth git-credential";
      };
    };

    # Conditional includes for work directories
    includes = [
      {
        condition = "gitdir:~/Development/pixiecode/";
        path = "~/.gitconfig-work";
      }
      {
        condition = "gitdir:~/Development/app-aie/";
        path = "~/.gitconfig-work";
      }
    ];
  };

  # Creating the ~/.gitconfig-work file directly in Home Manager
  home.file.".gitconfig-work".text = ''
    [user]
    	name = Hassan GPT
    	email = hassan@closegpt.ai
  '';
}
