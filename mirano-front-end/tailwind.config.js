/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./public/**/*.html', './src/**/*.{vue,js,ts,jsx,tsx}'],
  theme: {
    fontFamily: {
      'arial': ['Arial'],
      'roboto': ['Roboto'],
      'anybody': ['Anybody'],
    },
    colors: {
      transparent: 'transparent',
      current: 'currentColor',
      'blue': '#5D71B5',
      'white': 'white',
    }
  },
  plugins: [],
}
