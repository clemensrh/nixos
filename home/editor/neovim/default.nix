{
  lib,
  config,
  inputs,
  ...
}:

let
  cfg = config.my.neovim;

  baseNixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    globals.mapleader = " ";

    opts = {
      number = true;
      relativenumber = true;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      smartindent = true;
      wrap = false;
      ignorecase = true;
      smartcase = true;
      termguicolors = true;
      signcolumn = "yes";
      updatetime = 300;
      timeoutlen = 400;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>w";
        action = "<cmd>w<cr>";
        options = {
          silent = true;
          desc = "Save buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>q";
        action = "<cmd>q<cr>";
        options = {
          silent = true;
          desc = "Quit window";
        };
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<cr>";
        options = {
          silent = true;
          desc = "Find files";
        };
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<cr>";
        options = {
          silent = true;
          desc = "Live grep";
        };
      }
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Oil<cr>";
        options = {
          silent = true;
          desc = "Open file explorer";
        };
      }
    ];

    clipboard.providers.wl-copy.enable = true;

    colorschemes.catppuccin.enable = true;

    plugins = {
      web-devicons.enable = true;
      lualine.enable = true;

      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };

      telescope.enable = true;
      which-key.enable = true;
      oil.enable = true;

      gitsigns.enable = true;
      comment.enable = true;

      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
          ts_ls.enable = true;
          pyright.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
        };
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
      };
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp-cmdline.enable = true;
      cmp-nvim-lsp.enable = true;
      luasnip.enable = true;
      friendly-snippets.enable = true;
    };

    extraConfigLua = ''
      			vim.diagnostic.config({
      				virtual_text = true,
      				update_in_insert = false,
      				severity_sort = true,
      			})
      		'';
  };

  mergedNixvim = lib.recursiveUpdate baseNixvim cfg.settings;
in
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  options.my.neovim = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to enable Neovim configuration powered by nixvim.";
    };

    settings = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      example = {
        opts.shiftwidth = 4;
        plugins.lualine.enable = false;
      };
      description = "Attribute set recursively merged into programs.nixvim.";
    };

    extraPlugins = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
      description = "Additional Neovim plugins to append to programs.nixvim.extraPlugins.";
    };

    extraLuaConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Additional Lua appended to programs.nixvim.extraConfigLua.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = mergedNixvim // {
      extraPlugins = (mergedNixvim.extraPlugins or [ ]) ++ cfg.extraPlugins;
      extraConfigLua = lib.concatStringsSep "\n" [
        (mergedNixvim.extraConfigLua or "")
        cfg.extraLuaConfig
      ];
    };
  };
}
