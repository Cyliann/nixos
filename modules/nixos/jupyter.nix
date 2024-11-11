{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    jupyter.enable = lib.mkEnableOption "enables jupytext module";
  };

  config = lib.mkIf config.jupyter.enable {
    environment.systemPackages = with pkgs; [
      (python311.withPackages (ps:
        with ps; [
          jupyter
          ipython
          jupytext

          numpy
          pandas
          matplotlib
          scikit-learn
          seaborn
          statsmodels
        ]))
    ];
  };
}
