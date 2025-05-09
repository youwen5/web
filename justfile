default: typst-install-deps webbundle build
    cp web/dist/* dist

release: webbundle build-release

fresh-init: install-web-deps
    cargo build

preview:
    caddy run

browse: && preview
    zen localhost:8080

install-fonts:
    git clone https://github.com/youwen5/valkyrie.git valkyrie
    mkdir -p public/fonts
    cp valkyrie/WOFF2/OT-family/Valkyrie-OT/*.woff2 public/fonts
    rm -rf valkyrie

[working-directory: 'web']
install-web-deps:
    pnpm install

[working-directory: 'web']
webbundle:
    pnpm build

build:
    cargo run -- -v build

build-release:
    cargo run --release -- build --minify

typst-install-deps:
    rm -rf ~/.cache/typst/packages/luminite/html-shim
    mkdir -p ~/.cache/typst/packages/luminite
    cp -r ./typst/lib/html-shim ~/.cache/typst/packages/luminite
