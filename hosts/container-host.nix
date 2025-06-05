{ config, pkgs, ... }:

{
  containers.ComfyUI-01 = {
    autoStart = true;
    ephemeral = false;
    privateNetwork = false;
    hostAddress = "192.168.100.11";
    localAddress = "192.168.100.20";

    forwardPorts = [
      {
        containerPort = 8188;
        hostPort = 8198;
      }
    ];

    extraFlags = [ "-E DISPLAY=:0" "--resolv-conf=replace-uplink" ];

bindMounts = {
      "/home/jsampson/ai/ComfyUI" = {
        hostPath = "/home/jsampson/ComfyUI/ComfyUI-01";
        isReadOnly = false;
      };
      "/home/jsampson/ai/ComfyUI/models" = {
        hostPath = "/home/jsampson/ComfyUI/models";
        isReadOnly = false;
      };
      "/home/jsampson/ai/ComfyUI/input" = {
        hostPath = "/home/jsampson/ComfyUI/Input";
        isReadOnly = false;
      };
      "/home/jsampson/ai/ComfyUI/output" = {
        hostPath = "/home/jsampson/ComfyUI/Output";
        isReadOnly = false;
      };
      "/home/jsampson/micromamba" = {
        hostPath = "/home/jsampson/micromamba";
        isReadOnly = false;
      };
      "/home/jsampson/ai/ComfyUI/custom_nodes" = {
        hostPath = "/home/jsampson/ComfyUI/Containers/ComfyUI-01/CustomNodes";
        isReadOnly = false;
      };
      "/dev/nvidia0" = {
        hostPath = "/dev/nvidia0";
        isReadOnly = false;
      };
      "/dev/nvidiactl" = {
        hostPath = "/dev/nvidiactl";
        isReadOnly = false;
      };
      "/dev/nvidia-modeset" = {
        hostPath = "/dev/nvidia-modeset";
        isReadOnly = false;
      };
      "/dev/nvidia-uvm" = {
        hostPath = "/dev/nvidia-uvm";
        isReadOnly = false;
      };
      "/dev/nvidia-uvm-tools" = {
        hostPath = "/dev/nvidia-uvm-tools";
        isReadOnly = false;
      };
      "/run/opengl-driver" = {
        hostPath = "/run/opengl-driver";
        isReadOnly = true;
      };
      "/run/opengl-driver-32" = {
        hostPath = "/run/opengl-driver-32";
        isReadOnly = true;
      }; 
    };

    allowedDevices = [
      {
        modifier = "rw";
        node = "/dev/dri";
      }
      {
        modifier = "rw";
        node = "/dev/shm";
      }
      {
        modifier = "rw";
        node = "/dev/nvidia0";
      }
      {
        modifier = "rw";
        node = "/dev/nvidiactl";
      }
      {
        modifier = "rw";
        node = "/dev/nvidia-caps*";
      }
      {
        modifier = "rw";
        node = "/dev/nvidia-modeset";
      }
      {
        modifier = "rw";
        node = "/dev/nvidia-uvm";
      }
            {
        modifier = "rw";
        node = "/dev/nvidia-uvm-tools";
      }
    ];

    config = { config, pkgs, ... }: {
      imports = [ ../modules/container-comfyui.nix ];
    };
  };
}
