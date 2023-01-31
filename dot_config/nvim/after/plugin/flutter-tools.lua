require("flutter-tools").setup {
    ui = {
        border = "rounded",
        notification_style = 'native'
    },
    decorations = {
        statusline = {
            app_version = false,
            device = false,
        }
    },
    debugger = {
        enabled = false,
        run_via_dap = false,
        exception_breakpoints = {},
        register_configurations = nil,
    },
    flutter_path = "/home/shinobu/.local/bin/flutter",
    flutter_lookup_cmd = nil,
    fvm = false,
    widget_guides = {
        enabled = true,
    },
    closing_tags = {
        highlight = "ErrorMsg",
        prefix = "",
        enabled = true
    },
    dev_log = {
        enabled = true,
        open_cmd = "tabedit",
    },
    dev_tools = {
        autostart = false,
        auto_open_browser = false,
    },
    outline = {
        open_cmd = "30vnew",
        auto_open = false
    },
    lsp = {
        color = {
            enabled = true,
            background = true,
            foreground = false,
            virtual_text = false,
            virtual_text_str = "■",
        },
        on_attach = nil,
        capabilities = nil,
        settings = {
            showTodos = true,
            completeFunctionCalls = true,
            analysisExcludedFolders = { "/home/shinobu/.local/share/flutter/packages" },
            renameFilesWithClasses = "prompt",
            enableSnippets = true,
        }
    }
}
