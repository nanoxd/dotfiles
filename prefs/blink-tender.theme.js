const background = '#282828'
const foreground = '#eeeeee'

const black = '#282828'
const red = '#f43753'
const green = '#c9d05c'
const yellow = '#ffc24b'
const blue = '#b3deef'
const magenta = '#d3b987'
const cyan = '#73cef4'
const white = '#eeeeee'

const lightBlack = '#4c4c4c'
const lightRed = '#f43753'
const lightGreen = '#c9d05c'
const lightYellow = '#ffc24b'
const lightBlue = '#b3deef'
const lightMagenta = '#d3b987'
const lightCyan = '#73cef4'
const lightWhite = '#feffff'

t.prefs_.set('color-palette-overrides', [
  black, red, green, yellow, blue, magenta, cyan, white,
  lightBlack, lightRed, lightGreen, lightYellow,
  lightBlue, lightMagenta, lightCyan, lightWhite
]);

t.prefs_.set('cursor-color', 'rgba(0, 0, 0, 0.5)');
t.prefs_.set('foreground-color', foreground);
t.prefs_.set('background-color', background);
