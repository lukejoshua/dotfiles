local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

luasnip.add_snippets("all", {
    s("comp", {
        t("const "),
        i(0),
        t(" = computed(() => "),
        i(1),
        t(");"),
    }, {
        desc = "Top level computed value in vue or angular",
    }),
})
