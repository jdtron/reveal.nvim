# reveal.nvim
Markdown slides with [reveal.js](https://revealjs.com/), controlled from Nvim.

## ⚙️ Installation
With [Lazy](https://github.com/folke/lazy.nvim)
```lua
{
    "jdtron/reveal.nvim",
    build = "npm ci && npm run build",
    config = function ()
        require("reveal").setup()
    end,
}
```

## 👾 Usage
When in a markdown buffer, run `:RevealStart` to start the server.  
The slides will be openend automatically in your browser using xdg-open.

To stop the server run `:RevealStop`, close the buffer or quit Nvim.

### 📝 Formatting
By default, assets are loaded from `assets/`.

| Desc              | Format |
|-------------------|--------|
| Separatte slides  | `\n\n` |
| Separate sections | `---`  |

## 🧑‍💻 Roadmap
Please note this plugin is pretty much wip.

- [ ] Replace the Svelte Kit backend with something lighter
- [ ] Configurable theme
- [ ] Configurable reveal settings
