{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      # Patch qylock to include QtMultimedia and GStreamer video codecs
      qylock = prev.qylock.overrideAttrs (oldAttrs: {
        buildInputs = (oldAttrs.buildInputs or [ ]) ++ [
          final.qt6.qtmultimedia
          final.gst_all_1.gst-plugins-base
          final.gst_all_1.gst-plugins-good
          final.gst_all_1.gst-plugins-bad
          final.gst_all_1.gst-libav
        ];
        nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [
          final.qt6.wrapQtAppsHook
        ];
      });
    })
  ];

  programs.qylock = {
    enable = true;
    theme = "enfield";
    sddm.enable = true;
    quickshell.enable = true;
  };
}
