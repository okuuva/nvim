local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

local pre_hook = nil
local commentstring_ok, commentstring = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
if commentstring_ok then
  pre_hook = commentstring.create_pre_hook()
end

comment.setup({
  pre_hook = pre_hook,
})
