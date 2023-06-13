const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    "./app/helpers/**/*.rb",
    "./config/initializers/simple_form.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*",
    "./app/views/**/**/*",
    "./app/components/**/*",
    "./app/components/*.rb",
    "./app/components/**/*.rb",
    "./app/forms/scoped_form_builder.rb",
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
