(local config {})

;; Holds the installation/update instructions.
;;
;; INTERNAL - end users should not have to edit anything in here,
;; if needed, please submit a ticket.
;; The keys, represent the name of the LSP, as defined in nvim-lspconfig:
;; https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
;;
;; The values represent a micro DSL, as follows:
;; {npm,go,pip,gem,etc.}|package1[,package2[,...]]
;; where packageN is a package installable by the corresponding command.

;; fnlfmt: skip
(set config.config {
      :als nil
      :angularls "npm|@angular/language-server"
      :ansiblels "npm|ansible-language-server"
      :bashls "npm|bash-language-server"
      :beancount "npm|@bryall/beancount-langserver"
      :bicep "bin|https://github.com/Azure/bicep/releases/latest/download/bicep-langserver.zip"
      :ccls nil
      :clangd nil
      :clojure_lsp "nix|clojure-lsp"
      :cmake "pip|cmake-language-server"
      :codeqlls "bin|https://github.com/github/codeql-cli-binaries/releases/download/v2.5.7/codeql-{linux,osx,win}64.zip"
      :crystalline nil
      :cssls "npm|vscode-langservers-extracted"
      :dartls nil
      :denols "cargo|deno"
      :dhall_lsp_server "cabal|dhall-lsp-server"
      :diagnosticls "npm|diagnostic-languageserver"
      :dockerls "npm|dockerfile-language-server-nodejs"
      :dotls "npm|dot-language-server"
      :efm "go|github.com/mattn/efm-langserver"
      :elixirls nil
      :elmls "npm|elm,elm-test,elm-format,@elm-tooling/elm-language-server"
      :ember "npm|@lifeart/ember-language-server"
      :erlangls nil
      :flow "npm|flow-bin"
      :fortls "pip|fortran-language-server"
      :fsautocomplete nil
      :gdscript "bin|https://downloads.tuxfamily.org/godotengine/3.3.2/Godot_v3.3.2-stable_{linux_headless.64,osx.64,win64.exe}.zip"
      :ghcide "deprecated|use hls"
      :gopls "go|golang.org/x/tools/gopls@latest"
      :graphql "npm|graphql-language-service-cli"
      :groovyls nil
      :haxe_language_server nil
      :hie "deprecated|use hls"
      :hls "bin|https://github.com/haskell/haskell-language-server/releases/download/1.2.0/haskell-language-server-{Linux,macOS}-1.2.0.tar.gz"
      :html "npm|vscode-langservers-extracted"
      :intelephense "npm|intelephense"
      :java_language_server nil
      :jdtls nil
      :jedi_language_server "pip|jedi-language-server"
      :jsonls "npm|vscode-langservers-extracted"
      :julials "julia|Pkg.add(\"LanguageServer\"); Pkg.add(\"SymbolServer\")"
      :kotlin_language_server nil
      :lean3ls nil
      :leanls "npm|lean-language-server"
      :metals nil
      :mint nil
      :nimls "nim|nimlsp"
      :ocamlls "npm|ocaml-langauge-server"
      :ocamllsp "opam|ocaml-lsp-server"
      :omnisharp "bin|https://github.com/OmniSharp/omnisharp-roslyn/releases/download/v1.37.12/omnisharp-{linux-x64,osx,win-x64}.zip"
      :perlls "perl|Perl::LanguageServer"
      :perlpls "perl|PLS"
      :phpactor nil
      :powershell_es nil
      :prismals "npm|@prisma/language-server"
      :puppet nil
      :purescriptls "npm|purescript-language-server,spago,purescript"
      :pylsp "pip|python-lsp-server[all]"
      :pyright "npm|pyright"
      :r_language_server "r|languageserver"
      :racket_langserver "raco|racket-langserver"
      :rescriptls nil
      :rls "rust|rls,rust-analysis,rust-src"
      :rnix "cargo|rnix-lsp"
      :rome "npm|rome"
      :rust_analyzer "bin|https://github.com/rust-analyzer/rust-analyzer/releases/download/2021-07-12/rust-analyzer-x86_64-{unknown-linux-gnu,apple-darwin,pc-windows-msvc}.gz"
      :scry nil
      :serve_d "bin|https://github.com/Pure-D/serve-d/releases"
      :solargraph "gem|solargraph"
      :sorbet "gem|sorbet"
      :sourcekit nil
      :sqlls "npm|sql-language-server"
      :sqls "go|github.com/lighttiger2505/sqls"
      :stylelint_lsp "npm|stylelint-lsp"
      :sumneko_lua nil
      :svelte "npm|svelte-language-server"
      :svls "cargo|svls"
      :tailwindcss nil
      :terraformls "gh_bin|hashicorp/terraform-ls"
      :texlab "cargogit|https://github.com/latex-lsp/texlab.git"
      :tflint "go|github.com/terraform-linters/tflint"
      :tsserver "npm|typescript,typescript-language-server"
      :vala_ls nil
      :vimls "npm|vim-language-server"
      :vls nil
      :vuels "npm|vls"
      :yamlls "npm|yaml-language-server"
      :zeta_note nil
      :zls "bin|https://github.com/zigtools/zls/releases/download/0.1.0/x86_64-{linux,macos,windows}.tar.xz"})

;; the table defines the actual commands to be run for
;; each type of install. The keys must correspond to those
;; used in the config table above, and the value represents
;; the command to be run.
;;
;; The command MUST embed a %s in it - that will be replaced
;; with the (space separated) list of packages to install.
(let [update_github_releases (require :lspupdate.github)]
  (set config.commands {:bin nil
                        :cabal "cabal install %s"
                        :cargo "cargo install %s"
                        :cargogit "cargo install --locked --git %s"
                        :gem "gem install -q --silent --user-install %s"
                        :gh_bin update_github_releases
                        :go "cd /tmp && GO111MODULE=on go get %s"
                        :julia "julia -e 'using Pkg; %s'"
                        :nim "nimble install %s"
                        :nix "nix-shell -p %s"
                        :npm "npm i --quiet -g %s"
                        :opam "opam install %s"
                        :perl "PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'install %s'"
                        :pip "pip3 install --user -U -q %s"
                        :r "R -q --slave -e \"install.packages(\\\"%s\\\",quiet=T)\""
                        :raco "raco pkg install %s"
                        :rust "rustup component add %s"}))

;; the table holds checks for the various commands,
;; that allow us to determine if the executables are
;; installed or not.
(set config.checks
     {:gem {:gem [:-v "(%d+.%d+.%d+)"]}
      :gh_bin {:unzip [:-v "UnZip (%d+.%d+) of"] :curl [:-V "(%d+.%d+.%d+)"]}
      :go {:go [:version "go(%d+.%d+.%d+) "]}
      :julia {:julia [:-v "(%d+.%d+.%d+)"]}
      :npm {:npm [:-v "(%d+.%d+.%d+)"]}
      :opam {:opam [:--version "(%d+.%d+.%d+)"]}
      :perl {:perl [:-v "v(%d+.%d+.%d+)"]}
      :pip {:pip3 [:-V "pip (%d+.%d+.%d+)"]}
      :r {:R [:--version "R version (%d+.%d+.%d+)"]}})

config

