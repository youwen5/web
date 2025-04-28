import postcss from "rollup-plugin-postcss";
import tailwindcss from "@tailwindcss/postcss";
import cssnano from "cssnano";
import path from "path";

export default {
  input: "index.ts",
  output: {
    dir: "dist",
  },
  plugins: [
    postcss({
      plugins: [tailwindcss, cssnano],
      extract: path.resolve("dist/bundle.css"),
    }),
  ],
};
