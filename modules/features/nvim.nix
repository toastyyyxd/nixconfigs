{ config, pkgs, inputs, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];
  programs.nixvim = {
    enable = true;
    keymaps = [
      {
        mode = "t";
        action = "<C-\\><C-n>";
        key = "<esc>";
        options.silent = true;
      }
      {
        action = "<cmd>ToggleTerm<CR>";
        key = "<C-`>";
        options.silent = true;
      }
      {
        action = "<cmd>TermNew<CR>";
        key = "<C-\\>";
        options.silent = true;
      }
      {
        action = ":IncRename ";
        key = "<leader>r";
      }
    ];
    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
    };

    extraConfigLua = /* lua */ ''
      vim.api.nvim_create_user_command("Setup", function(opts)
        local args = vim.split(opts.args, " ")
        local term_count;
        if #args == 1 and args[1] == "" then
          args = {}
          term_count = nil
        end
        if #args > 0 then
          term_count = tonumber(args[#args])
        end

        local files = {}
        if term_count then
          files = vim.list_slice(args, 1, #args - 1)
        else
          term_count = 2 -- default
          files = args
        end
        
        for i, f in ipairs(files) do
          if i == 1 then
            vim.cmd("edit ".. vim.fn.fnameescape(files[i]))
          else
            vim.cmd("rightbelow vsplit ".. vim.fn.fnameescape(files[i]))
          end
          if i == #files then
            last_file_win = vim.fn.win_getid()
          end
        end -- open files in vsplit
        
        vim.schedule(function() -- language server errors broke everything after it
          require("nvim-tree.api").tree.open()
          -- open tree on the side of the files, terminals below

          for i = 1, term_count do
            vim.cmd("TermNew direction=horizontal")
          end -- open terminals

          if last_file_win then
            vim.fn.win_gotoid(last_file_win)
          end
          vim.cmd("stopinsert");
        end)
      end, { nargs = "*" })
    '';

    plugins = {
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          zls.enable = true;
          nil_ls.enable = true;
          rust_analyzer.enable = true;
        };
      };
      lspconfig.enable = true;

      hmts.enable = true; # nix language fencing
      nix-develop.enable = true;

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          mapping = {
            __raw = ''
              cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
              })
            '';
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
            { name = "nvim_lsp_signature_help"; }
          ];
          window.completion.border = ["┌" "─" "┐" "│" "┘" "─" "└" "│"];
        };
      };
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp-nvim-lsp-signature-help.enable = true;
      inc-rename.enable = true;

      nvim-autopairs.enable = true;
      barbar.enable = true;
      nvim-tree = {
        enable = true;
        settings.view.side = "left";
      };
      toggleterm = {
        enable = true;
        settings.direction = "horizontal";
      };
      lualine = {
        enable = true;
        settings.options.theme = "catppuccin";
      };
      treesitter = {
        enable = true;
        highlight.enable = true;
      };
      whitespace.enable = true;
      sleuth.enable = true;
      indent-blankline.enable = true;
      rainbow-delimiters.enable = true;
      twilight.enable = true;
      web-devicons.enable = true;
      neocord.enable = true;
    };
  };
}
