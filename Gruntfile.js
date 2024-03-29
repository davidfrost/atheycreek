module.exports = function (grunt) {
  'use strict';

  // Load local NPM tasks automagically
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

  grunt.initConfig({

    // JS Hint
    // =====================================================

    jshint : {
      all: [
        'workspace/assets/js/main.js'
      ]
    },

    // Recess
    // =====================================================

    recess: {
      dist: {
        options: {
          compile: true,
          compress: true
        },
        files: {
          'workspace/assets/css/main.css': ['workspace/assets/less/main.less']
        }
      }
    },

    // Concatenation
    // =====================================================

    concat: {
      options: {
        separator: ';'
      },
      dist: {
        src : [
          'workspace/assets/js/jquery.js',
          'workspace/assets/bootstrap/js/combined/2.2.1/bootstrap.min.js ',
          'workspace/assets/js/responsimage.js',
          'workspace/assets/js/mediaelement.js',
          'workspace/assets/js/fitvids.js',
          'workspace/assets/js/main.js'],
        dest: 'workspace/assets/js/application.js'
      }
    },

    // Uglify.js
    // =====================================================

    uglify: {
      options: {
        mangle: false
      },
      main: {
        files: {
          'workspace/assets/js/application.min.js': ['workspace/assets/js/application.js']
        }
      }
    },

    // Clean
    // =====================================================

    clean: [ "manifest/cache/*.jpg" ],

    // Watch
    // =====================================================

    watch: {
      main: {
        files: ['**/*.less','**/*.js','!**/node_modules/**'],
        tasks: ['core'],
        options: {
          livereload: true,
        }
      }
    }


});

// Main task
grunt.registerTask('core', ['jshint', 'concat', 'uglify', 'recess']);
grunt.registerTask('wipe', ['clean']);
grunt.registerTask('build', ['core']);
grunt.registerTask('default', ['build', 'watch'])};
