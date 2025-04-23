import postcss from "rollup-plugin-postcss";
import tailwindcss from "@tailwindcss/postcss";
import postcssMinify from "postcss-minify";
import terser from "@rollup/plugin-terser";

export default {
  input: "styles/main.css",
  output: {
    file: "dist/bundle.css",
  },
  plugins: [
    postcss({
      plugins: [tailwindcss, postcssMinify],
      extract: true,
    }),
    terser(),
  ],
};
