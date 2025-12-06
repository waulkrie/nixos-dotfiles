{...}: {
  # import the home manager module
  # imports = [inputs.noctalia.homeModules.default];
  # configure options
  programs.noctalia-shell = {
    enable = true;
    settings = {
      # configure noctalia here; defaults will
      # be deep merged with these attributes.
      bar = {
        density = "compact";
        position = "top";
        showCapsule = false;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              id = "SystemMonitor";
              showCpuUsage = true;
              showCpuTemp = true;
              showMemoryUsage = true;
              showNetworkUsage = true;
            }
          ];
          center = [
            {
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "none";
            }
          ];
          right = [
            {
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              id = "Clock";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
          ];
        };
      };
      colorSchemes.predefinedScheme = "Monochrome";

      location = {
        name = "Cantonment, America";
      };
    };
    # this may also be a string or a path to a JSON file,
    # but in this case must include *all* settings.
  };
}
