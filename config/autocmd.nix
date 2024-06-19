{
  autoCmd = [
    {
      desc = "Highlight on yank";
      event = ["TextYankPost"];
      callback = {
        __raw = ''
          function()
            vim.highlight.on_yank()
          end
        '';
      };
    }
    {
      desc = "Close these type of File";
      event = ["FileType"];
      pattern = [
        "PlenaryTestPopup"
        "help"
        "lspinfo"
        "man"
        "notify"
        "qf"
        "query"
        "spectre_panel"
        "startuptime"
        "tsplayground"
        "neotest-output"
        "checkhealth"
        "neotest-summary"
        "neotest-output-panel"
      ];

      callback = {
        __raw = ''
          function(event)
            vim.bo[event.buf].buflisted = false
            vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
          end
        '';
      };
    }
    {
      desc = "Auto create dir when save file, in case some intermediate directory is missing";
      event = ["BufWritePre"];
      callback = {
        __raw = ''
          function(event)
            if event.match:match("^%w%w+://") then
              return
            end
            local file = vim.loop.fs_realpath(event.match) or event.match
            vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
          end
        '';
      };
    }
  ];
}
