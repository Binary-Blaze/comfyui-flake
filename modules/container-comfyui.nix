    { config, pkgs, lib, ... }: {

  
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          nvidia-vaapi-driver
        ];
      };

      hardware.nvidia = {
        modesetting.enable = true;
        #powerManagement.enable = true;
        #powerManagement.finegrained = false;
        #nvidiaPersistenced = true;
        open = true;
        nvidiaSettings = true;
        datacenter.enable = true;
        #prime.nvidiaBusId = "PCI:41:0:0";
        #package = config.boot.kernelPackages.nvidiaPackages.latest;
      };

      #hardware.nvidia-container-toolkit.enable = true;
      #hardware.nvidia-container-toolkit.mount-nvidia-executables = true;
      #hardware.nvidia-container-toolkit.mount-nvidia-docker-1-directories = true;

      #programs.nix-required-mounts.presets.nvidia-gpu.enable = true;

      programs.fish = {
        enable = true;
        shellInit = "micromamba shell init --shell fish --root-prefix=~/micromamba";
      };
      programs.java.enable = true; 
      users.defaultUserShell = pkgs.fish;
      programs.mtr.enable = true;
      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
      programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
      # ────────────── 🎮 Multimedia & Audio Libraries ──────────────
        SDL
        SDL2
        SDL2_image
        SDL2_mixer
        SDL2_ttf
        SDL_image
        SDL_mixer
        SDL_ttf
        alsa-lib
        flac
        libjack2
        libmikmod
        libogg
        libpulseaudio
        libsamplerate
        libtheora
        libvorbis
        libvlc
        speex
      
      # ────────────── 🖼️ Graphics & Rendering ──────────────
        cairo
        fontconfig
        freeglut
        freetype
        glew
        glew110
        gdk-pixbuf
        harfbuzz
        libGL
        libGLU
        librsvg
        libtiff
        libvdpau
        libvpx
        mesa
        pixman
        skia
        vulkan-loader
      
      # ────────────── 🖥️ GUI & Desktop Integration ──────────────
        at-spi2-atk
        at-spi2-core
        atk
        desktop-file-utils
        gtk2
        gtk3
        libappindicator-gtk2
        libcanberra
        libdbusmenu
        webkit2-sharp
        xorg.libICE
        xorg.libSM
        xorg.libX11
        xorg.libXScrnSaver
        xorg.libXcomposite
        xorg.libXcursor
        xorg.libXdamage
        xorg.libXext
        xorg.libXfixes
        xorg.libXft
        xorg.libXi
        xorg.libXinerama
        xorg.libXmu
        xorg.libXrandr
        xorg.libXrender
        xorg.libXt
        xorg.libXtst
        xorg.libXxf86vm
        xorg.libpciaccess
        xorg.libxcb
        xorg.xcbutil
        xorg.xcbutilimage
        xorg.xcbutilkeysyms
        xorg.xcbutilrenderutil
        xorg.xcbutilwm
        xorg.xkeyboardconfig
        wayland
      
      # ────────────── 🌐 Networking & Security ──────────────
        curl
        curlWithGnuTls
        dbus
        dbus-glib
        libidn
        libssh
        libsodium
        nss
        openssl
        p11-kit
        systemd
        udev
      
      # ────────────── 🧱 Compression & Archiving ──────────────
        bzip2
        xz
        zlib
        zstd
      
      # ────────────── 📦 General Libraries & Utilities ──────────────
        acl
        attr
        bash
        cups
        e2fsprogs
        expat
        fish
        fuse
        fuse3
        gmp
        glibc
        icu
        keyutils.lib
        libcap
        libclang.lib
        libdrm
        libgcrypt
        libgpg-error
        libusb1
        libuuid
        libxcrypt-legacy
        libxkbcommon
        libxml2
        nspr
        python3
        stdenv.cc.cc
        stdenvNoCC
        tbb
        util-linux
      
      # ────────────── 🧰 Development Tools & Runtimes ──────────────
        dotnetCorePackages.sdk_9_0
        upgrade-assistant
        prefetch-npm-deps
        roslyn-ls
        avalonia-ilspy
        ilspycmd
        nodejs
        cmake
        ninja
        m4
      
      # ────────────── 🚀 GPU / Build / AI Tooling ──────────────
        onnxruntime
        cudatoolkit
        cudaPackages.cudatoolkit
        cudaPackages.cuda_opencl
        cudaPackages.cutensor
        cudaPackages.cudnn
        cudaPackages.libnvidia_nscq
        cudaPackages.cuda_nvrtc
      ];            
      package = pkgs.nix-ld-rs;
    };

      nix.settings.experimental-features = [ "nix-command" "flakes" ];

      # services.xserver.videoDrivers = [ "nvidia" ];

      programs.ssh.pubkeyAcceptedKeyTypes = [ "ssh-ed25519" ];
      services.sshd.enable = true;
      services.openssh = {
        enable = true;
        openFirewall = true;
        allowSFTP = true;
        ports = [ 22 ];
        settings = {
          PasswordAuthentication = true;
          AllowUsers = [ "jsampson" ]; # Allows all users by default. Can be [ "user1" "user2" ]
          UseDns = true;
          X11Forwarding = false;
          PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
        };
      };
      # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users.jsampson = {
        initialHashedPassword = "$y$j9T$kLq4Se796ThQt0qi/g9eR0$2wb1Sj9I7rkUcUi4V27XsmyOIVDbeprA1uKlTblati.";
        isNormalUser = true;
        description = "Jeremy M Sampson";
        extraGroups = [ 
          "networkmanager"
          "network"
          "wheel"
          "audio"
          "video"
          "input"
          "mail"
          "ssh"
          "web"
          "libvirtd"
          "qemu-libvirtd"
          "podman"
          "podman-compose"
          "docker"
          "docker-compose"
          "lxd"
          "storage"
          "floppy"
          "disk"
          "cdrom"
          "tape"
          "kvm"
          "render"
          "polkituser"
          "gnome-remote-desktop"
          "users"
        ];
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEYX99JafMm3E1Iscyxnajw81rvWgNaf0os1wvag0BiP jsampson@mimesis3d.com" ];
        packages = with pkgs; [
        #  thunderbird
        ];
      };

      environment.etc."ld.so.conf.d/opengl.conf".text = "/run/opengl-driver/lib";

      environment.sessionVariables = {
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        EXTRA_CCFLAGS ="-I/usr/include";
        EXTRA_LDFLAGS = "-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib";
      };

  
      environment.systemPackages = with pkgs; [ 
        dotnetCorePackages.sdk_9_0-bin
        fish
        brave
        neofetch
        onnxruntime
        conda
        micromamba
        boost
        git
        nano
        wget
        curl
        cmake
        clang
        libgcc
        dlib
        glibc
        ninja
        libgcc
        gawk
        which

        nix-ld
        zlib
        zlib.dev
        udev
        alsa-lib
        fontconfig
        glew
	      openssl

      vscode-runner
      (vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions; [
          bbenoist.nix
          github.copilot
          ms-python.python
          ms-azuretools.vscode-docker
          ms-vscode-remote.remote-ssh
          ms-dotnettools.csdevkit
          ms-dotnettools.vscodeintellicode-csharp
          ms-toolsai.jupyter
          ms-vscode.cpptools-extension-pack
          ms-vscode-remote.remote-containers
          ms-dotnettools.vscode-dotnet-runtime
          ms-dotnettools.csharp
          visualstudioexptteam.vscodeintellicode
          rust-lang.rust-analyzer
          genieai.chatgpt-vscode
          batisteo.vscode-django
          njpwerner.autodocstring
          wholroyd.jinja
          jnoortheen.nix-ide
          mkhl.direnv
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "vscode-avalonia";
            publisher = "avaloniateam";
            version = "0.0.32";
            sha256 = "sha256-2OpZOltD+4i9tUmk0tTDDdEEhffCvHMAQ6BcsA+2Ou8=";
          }
          {
            name = "podmanager";
            publisher = "dreamcatcher45";
            version = "2.0.6";
            sha256 = "sha256-uLC8NszLOSD2Lu3FXvGmOtjE41+mBxkRb1UiecOBB98=";
          }
        ];
      })       

        stdenv.cc.cc.lib
        stdenv.cc
        ncurses5
        binutils

        gpu-viewer
        linuxPackages.nvidia_x11 
        nvidia-modprobe
        nvidia-container-toolkit
        libnvidia-container
        nvtopPackages.nvidia
        glxinfo

        cudatoolkit
        cudaPackages.cudatoolkit
        cudaPackages.cuda_opencl
        cudaPackages.cutensor
        cudaPackages.cudnn
        cudaPackages.libnvidia_nscq
        cudaPackages.cuda_nvrtc
        xorg.libXi 
        xorg.libXmu
        xorg.libXext 
        xorg.libX11 
        xorg.libXv 
        xorg.libXrandr 

        libGLU
        libGL
        freeglut
        
        git
        gitRepo 
        gnupg 
        autoconf 
        curl

        procps 
        gnumake 
        util-linux  
        m4
        gperf 
        unzip

        zlib
        # for xformers
        gcc
      ];

      nixpkgs.config = {
        allowUnfree = true;
        allowBroken = true;
        allowUnsupportedSystem = true;
        nvidia.acceptLicense = true;
      };
        


      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;

      home-manager.users.jsampson = { pkgs, ... }: {
        home.username = "jsampson";
        home.homeDirectory = "/home/jsampson";
    
        programs.home-manager.enable = true;
      };
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      nixpkgs.config.allowUnfreePredicate = _: true;

      networking.firewall.allowedTCPPorts = [ 80 ];
      system.stateVersion = "24.11";
    }
