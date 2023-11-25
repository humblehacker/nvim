return {
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      auto_restore_enabled = true,
      auto_session_suppress_dirs = { "~/Downloads", "~/Documents", "~/Desktop" },
      auto_save_enabled = true,
      -- https://github.com/rmagatti/auto-session/issues/259#issuecomment-1812949343
      pre_save_cmds = { "NvimTreeClose" },
      save_extra_cmds = { "NvimTreeOpen" },
      post_restore_cmds = { "NvimTreeOpen" }
    })

    
  end,
}
