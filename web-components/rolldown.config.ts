import tailwindcss from "@tailwindcss/postcss";
import cssnano from "cssnano";
import path from "path";
import postcss from "rollup-plugin-postcss";
import { minify } from "rollup-plugin-swc3";

export default {
	input: ["index.ts", "icons.ts"],
	output: {
		dir: "dist",
	},
	plugins: [
		minify({ module: true, mangle: {}, compress: {} }),
		postcss({
			plugins: [tailwindcss, cssnano],
			extract: path.resolve("dist/bundle.css"),
		}),
	],
};
