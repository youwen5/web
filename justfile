default: sync-typst-package
    cabal run rednoise -- rebuild

dev:
    cabal run rednoise -- watch

install-fonts:
    git clone https://github.com/youwen5/valkyrie.git valkyrie
    rsync valkyrie/WOFF2/OT-family/Valkyrie-OT/*.woff2 fonts
    rsync valkyrie/concourse-index/WOFF2/concourse_index_regular.woff2 fonts
    rm -rf valkyrie

sync-typst-package:
    rsync -a ./typst/pkgs/html-shim ~/.cache/typst/packages/preview

# Run hoogle
hoogle:
    echo http://127.0.0.1:8888
    hoogle serve -p 8888 --local

# Run cabal repl
repl *ARGS:
    cabal repl {{ ARGS }}

test-prod:
    nix run .#preview-full
