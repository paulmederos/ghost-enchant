module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    sass:
      dist:
        files:
          "assets/css/styles.css": "assets/sass/core.scss"
    coffee:
      compile:
        expand: true
        flatten: true
        cwd: 'assets/js/'
        src: ["*.coffee"]
        dest: "assets/js/"
        ext: ".js"

    watch:
      css:
        files: "assets/sass/*.scss"
        tasks: ["sass"]

      js:
        files: "assets/js/*.coffee"
        tasks: ["coffee:compile"]

  grunt.loadNpmTasks "grunt-contrib-sass"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-watch"

  grunt.registerTask "default", ["watch"]
