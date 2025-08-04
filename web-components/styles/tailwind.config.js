const round = (num) =>
	num
		.toFixed(7)
		.replace(/(\.[0-9]+?)0+$/, "$1")
		.replace(/\.0$/, "");
const rem = (px) => `${round(px / 16)}rem`;
const em = (px, base) => `${round(px / base)}em`;

/** @type {import('tailwindcss').Config} */
module.exports = {
	theme: {
		extend: {
			typography: () => ({
				lg: {
					css: [
						{
							lineHeight: 1.6,
							fontSize: rem(17.75),
							h1: {
								fontSize: em(1, 1),
								marginBottom: em(6, 20),
							},
							h2: {
								fontSize: em(1, 1),
								marginBottom: em(6, 20),
							},
							h3: {
								fontSize: em(1, 1),
								marginBottom: em(6, 20),
							},
							h4: {
								fontSize: em(1, 1),
								marginBottom: em(6, 20),
							},
						},
					],
				},
				xl: {
					css: [
						{
							lineHeight: 1.6,
							h1: {
								fontSize: em(1, 1),
								marginBottom: em(6, 20),
							},
							h2: {
								fontSize: em(1, 1),
								marginBottom: em(6, 20),
							},
							h3: {
								fontSize: em(1, 1),
								marginBottom: em(6, 20),
							},
							h4: {
								fontSize: em(1, 1),
								marginBottom: em(6, 20),
							},
						},
					],
				},
			}),
		},
	},
};
