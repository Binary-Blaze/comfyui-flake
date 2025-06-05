{ pkgs, ... }: {
  home.username = "jsampson";
  home.homeDirectory = "/home/jsampson";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  systemd.user.services.my-comfyui = {
    Unit = {
      Description = "ComfyUI User Service";
      After = [ "default.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.fish}/bin/fish -c 'conda-shell && micromamba activate comfyui-01 && python /home/jsampson/ai/ComfyUI/main.py'";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
