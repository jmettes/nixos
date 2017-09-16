{
  allowUnfree = true;
  packageOverrides = super: let self = super.pkgs; in with self; rec {

    systemToolsEnv = with super; buildEnv {
        name = "systemToolsEnv";
        paths = [
            file
            gcc
            git
            gnumake
            inetutils
            tree
            unzip
            wget
            which
            xclip
            zip
        ];
    };

    pythonEnv = with super; buildEnv {
        name = "pythonEnv";
        paths = [
            python3
        ];
    };

  };
}
