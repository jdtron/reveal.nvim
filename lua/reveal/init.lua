local M = {}

---Start server and open markdown file in browser
---@param file string
M.start = function (file)
    if M.node_proc == nil then
        local stdout = vim.uv.new_pipe()

        if M.node_proc == nil then
            local _, pid = vim.uv.spawn(
                "/usr/sbin/node",
                { stdout = stdout, args = { M.plugin_path("build/index.js") } },
                function (code)
                    print("Reveal stopped with code", code)
                end
            )

            print("Reveal started with pid", pid)
            M.node_proc = pid
        end

        io.popen("xdg-open http://localhost:3000?file=" .. file)
    end
end

---Stop server
M.stop = function ()
    if M.node_proc == nil then
        return
    end

    vim.uv.kill(M.node_proc)
    M.node_proc = nil
end

---Get path to a file of this plugin
---@param path string
---@return string
M.plugin_path = function (path)
    local pdir = debug.getinfo(1).source
    pdir = string.sub(pdir, 2, string.len("/lua/reveal/init.lua") * -1)

    return pdir .. path
end

M.setup = function ()
    vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
        pattern = "*.md",
        callback = function ()
            vim.api.nvim_buf_create_user_command(0, "RevealStart", function ()
                local file = vim.fn.expand("%")
                M.start(file)
            end, { nargs = 0 })

            vim.api.nvim_buf_create_user_command(0, "RevealStop", function ()
                M.stop()
            end, { nargs = 0 })
        end,
    })

    vim.api.nvim_create_autocmd({ "BufDelete", "ExitPre" }, {
        pattern = "*.md",
        callback = function ()
            M.stop()
        end,
    })
end

return M
