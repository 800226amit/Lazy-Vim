-- =============================================
-- File Templates — Naya file banaate hi boilerplate auto-insert ho jaata hai
-- =============================================

local autocmd = vim.api.nvim_create_autocmd

-- Helper: lines insert karo aur cursor position set karo
local function insert_template(lines, cursor_row, cursor_col)
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  if cursor_row then
    vim.schedule(function()
      pcall(vim.api.nvim_win_set_cursor, 0, { cursor_row, cursor_col or 0 })
    end)
  end
end

-- Java: package auto-detect karo directory structure se
-- src/main/java/com/example/myapp/MyClass.java → package com.example.myapp
local function java_package()
  local path = vim.fn.expand("%:p")
  -- Maven/Gradle structure: src/main/java/ ke baad wala part
  local pkg = path:match("src[/\\]main[/\\]java[/\\](.+)[/\\][^/\\]+%.java$")
    or path:match("src[/\\](.+)[/\\][^/\\]+%.java$")
  if pkg then
    return pkg:gsub("[/\\]", ".")
  end
  -- Fallback: parent folder name
  return vim.fn.expand("%:p:h:t")
end

-- ── Java ──────────────────────────────────────────────────────────────────
autocmd("BufNewFile", {
  pattern = "*.java",
  callback = function()
    local class_name = vim.fn.expand("%:t:r")
    local pkg = java_package()
    insert_template({
      "package " .. pkg .. ";",
      "",
      "public class " .. class_name .. " {",
      "",
      "    public " .. class_name .. "() {",
      "        // constructor",
      "    }",
      "",
      "}",
    }, 4, 4)
  end,
  desc = "Java class template",
})

-- Java Interface
autocmd("BufNewFile", {
  pattern = "*Interface.java",
  callback = function()
    local name = vim.fn.expand("%:t:r")
    local pkg = java_package()
    insert_template({
      "package " .. pkg .. ";",
      "",
      "public interface " .. name .. " {",
      "",
      "}",
    }, 4, 0)
  end,
  desc = "Java interface template",
})

-- ── Python ────────────────────────────────────────────────────────────────
autocmd("BufNewFile", {
  pattern = "*.py",
  callback = function()
    local name = vim.fn.expand("%:t:r")
    if name == "__init__" then
      insert_template({ '"""Package init."""', "" }, 1, 0)
      return
    end
    insert_template({
      "#!/usr/bin/env python3",
      '"""',
      name .. " module.",
      '"""',
      "",
      "",
      "def main() -> None:",
      "    pass",
      "",
      "",
      'if __name__ == "__main__":',
      "    main()",
    }, 8, 4)
  end,
  desc = "Python module template",
})

-- ── TypeScript ────────────────────────────────────────────────────────────
autocmd("BufNewFile", {
  pattern = "*.ts",
  callback = function()
    local name = vim.fn.expand("%:t:r")
    -- Check if it's a service/class file by name
    if name:match("Service$") or name:match("Controller$") or name:match("Repository$") then
      insert_template({
        "export class " .. name .. " {",
        "",
        "  constructor() {}",
        "",
        "}",
      }, 2, 2)
    else
      insert_template({ "" }, 1, 0)
    end
  end,
  desc = "TypeScript template",
})

-- ── React Component (TSX) ─────────────────────────────────────────────────
autocmd("BufNewFile", {
  pattern = "*.tsx",
  callback = function()
    local name = vim.fn.expand("%:t:r")
    insert_template({
      'import React from "react";',
      "",
      "interface " .. name .. "Props {",
      "  // props yahan define karo",
      "}",
      "",
      "const " .. name .. ": React.FC<" .. name .. "Props> = ({}) => {",
      "  return (",
      "    <div>",
      "      ",
      "    </div>",
      "  );",
      "};",
      "",
      "export default " .. name .. ";",
    }, 10, 6)
  end,
  desc = "React TSX component template",
})

-- ── JSX ───────────────────────────────────────────────────────────────────
autocmd("BufNewFile", {
  pattern = "*.jsx",
  callback = function()
    local name = vim.fn.expand("%:t:r")
    insert_template({
      "const " .. name .. " = () => {",
      "  return (",
      "    <div>",
      "      ",
      "    </div>",
      "  );",
      "};",
      "",
      "export default " .. name .. ";",
    }, 4, 6)
  end,
  desc = "React JSX component template",
})

-- ── HTML ──────────────────────────────────────────────────────────────────
autocmd("BufNewFile", {
  pattern = "*.html",
  callback = function()
    local name = vim.fn.expand("%:t:r")
    insert_template({
      "<!DOCTYPE html>",
      '<html lang="en">',
      "  <head>",
      '    <meta charset="UTF-8" />',
      '    <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
      "    <title>" .. name .. "</title>",
      '    <link rel="stylesheet" href="style.css" />',
      "  </head>",
      "  <body>",
      "",
      "    ",
      "",
      '    <script src="main.js"></script>',
      "  </body>",
      "</html>",
    }, 11, 4)
  end,
  desc = "HTML5 template",
})

-- ── CSS ───────────────────────────────────────────────────────────────────
autocmd("BufNewFile", {
  pattern = "*.css",
  callback = function()
    insert_template({
      "/* === Reset === */",
      "*, *::before, *::after {",
      "  box-sizing: border-box;",
      "  margin: 0;",
      "  padding: 0;",
      "}",
      "",
      "/* === Variables === */",
      ":root {",
      "  --primary: #3b82f6;",
      "  --bg: #ffffff;",
      "  --text: #1a1a1a;",
      "}",
      "",
      "/* === Styles === */",
      "",
    }, 16, 0)
  end,
  desc = "CSS template",
})

-- ── Go ────────────────────────────────────────────────────────────────────
autocmd("BufNewFile", {
  pattern = "*.go",
  callback = function()
    local dir = vim.fn.expand("%:p:h:t")
    local name = vim.fn.expand("%:t:r")
    if name == "main" then
      insert_template({
        "package main",
        "",
        'import "fmt"',
        "",
        "func main() {",
        '\tfmt.Println("Hello, World!")',
        "}",
      }, 6, 1)
    else
      insert_template({
        "package " .. dir,
        "",
        "",
      }, 3, 0)
    end
  end,
  desc = "Go template",
})

-- ── Rust ──────────────────────────────────────────────────────────────────
autocmd("BufNewFile", {
  pattern = "*.rs",
  callback = function()
    local name = vim.fn.expand("%:t:r")
    if name == "main" then
      insert_template({
        "fn main() {",
        "    println!(\"Hello, World!\");",
        "}",
      }, 2, 14)
    else
      insert_template({
        "#[allow(dead_code)]",
        "",
        "pub struct " .. name:gsub("^%l", string.upper) .. " {",
        "    // fields yahan",
        "}",
        "",
        "impl " .. name:gsub("^%l", string.upper) .. " {",
        "    pub fn new() -> Self {",
        "        Self {}",
        "    }",
        "}",
      }, 4, 4)
    end
  end,
  desc = "Rust template",
})

-- ── C ─────────────────────────────────────────────────────────────────────
autocmd("BufNewFile", {
  pattern = "*.c",
  callback = function()
    local name = vim.fn.expand("%:t:r")
    if name == "main" then
      insert_template({
        "#include <stdio.h>",
        "#include <stdlib.h>",
        "",
        "int main(int argc, char *argv[]) {",
        "    ",
        "    return 0;",
        "}",
      }, 5, 4)
    else
      insert_template({
        '#include "' .. name .. '.h"',
        "",
        "",
      }, 3, 0)
    end
  end,
  desc = "C source template",
})

-- ── C++ ───────────────────────────────────────────────────────────────────
autocmd("BufNewFile", {
  pattern = "*.cpp",
  callback = function()
    local name = vim.fn.expand("%:t:r")
    if name == "main" then
      insert_template({
        "#include <iostream>",
        "#include <string>",
        "#include <vector>",
        "",
        "using namespace std;",
        "",
        "int main() {",
        "    ",
        "    return 0;",
        "}",
      }, 8, 4)
    else
      insert_template({
        '#include "' .. name .. '.hpp"',
        "",
        "",
      }, 3, 0)
    end
  end,
  desc = "C++ source template",
})

-- ── C/C++ Header ──────────────────────────────────────────────────────────
autocmd("BufNewFile", {
  pattern = { "*.h", "*.hpp" },
  callback = function()
    local guard = vim.fn.expand("%:t"):upper():gsub("[^A-Z0-9]", "_")
    insert_template({
      "#ifndef " .. guard,
      "#define " .. guard,
      "",
      "#ifdef __cplusplus",
      'extern "C" {',
      "#endif",
      "",
      "/* declarations yahan */",
      "",
      "#ifdef __cplusplus",
      "}",
      "#endif",
      "",
      "#endif /* " .. guard .. " */",
    }, 8, 0)
  end,
  desc = "C/C++ header template",
})

-- ── Bash Script ───────────────────────────────────────────────────────────
autocmd("BufNewFile", {
  pattern = "*.sh",
  callback = function()
    local name = vim.fn.expand("%:t:r")
    insert_template({
      "#!/usr/bin/env bash",
      "# " .. name .. " - description here",
      "set -euo pipefail",
      "",
      "# === Constants ===",
      'SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"',
      "",
      "# === Functions ===",
      "main() {",
      "    echo 'Starting " .. name .. "'",
      "}",
      "",
      "main \"$@\"",
    }, 10, 10)
    vim.fn.system("chmod +x " .. vim.fn.shellescape(vim.fn.expand("%:p")))
  end,
  desc = "Bash script template",
})

-- ── Makefile ──────────────────────────────────────────────────────────────
autocmd("BufNewFile", {
  pattern = { "Makefile", "makefile" },
  callback = function()
    insert_template({
      ".PHONY: all build clean test",
      "",
      "all: build",
      "",
      "build:",
      "\t@echo 'Building...'",
      "",
      "test:",
      "\t@echo 'Testing...'",
      "",
      "clean:",
      "\t@echo 'Cleaning...'",
    }, 6, 1)
  end,
  desc = "Makefile template",
})

-- ── Dockerfile ────────────────────────────────────────────────────────────
autocmd("BufNewFile", {
  pattern = "Dockerfile",
  callback = function()
    insert_template({
      "FROM ubuntu:22.04",
      "",
      "WORKDIR /app",
      "",
      "COPY . .",
      "",
      "RUN apt-get update && apt-get install -y \\",
      "    && rm -rf /var/lib/apt/lists/*",
      "",
      'CMD ["bash"]',
    }, 8, 4)
  end,
  desc = "Dockerfile template",
})
