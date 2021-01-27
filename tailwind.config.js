module.exports = {
  purge: [],
  theme: {
    borderWidth: {
      default: '1px',
      '0': '0',
      '1': '1px',
      '2': '2px',
      '3': '3px',
      '4': '4px',
      '6': '6px',
      '8': '8px',
    },
    extend: {
      colors: {
        'regal-blue': '#243c5a',
        'very-light-gray': 'rgb(245, 245, 245)',
        'light-gray': 'rgb(230, 230, 230)',
        'content-color': 'rgb(85, 88, 90)',
        'title-color': 'rgb(43, 43, 43)',
        'nav-color': 'rgb(164, 158, 152)',
      }
    },
    fontFamily: {
      'sans': 'Open Sans',
      'serif': 'Merriweather',
      'title': 'Merriweather',
      'body': 'Open Sans',
    },
    inset: {
      '50': '50%',
      '-50': '-50%',
    }
  },
  variants: {},
  plugins: [],
}
