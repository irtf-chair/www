var gulp = require('gulp');
var sass = require('gulp-sass');
var sourcemaps = require('gulp-sourcemaps');
var uglify = require('gulp-uglify');
var exec = require('child_process').execSync;
var runSequence = require('run-sequence');

var config = {
  bowerDir: './bower_components',
  publicDir: './static',
  outputDir: './output'
};

gulp.task('fonts', function() {
  return gulp.src([
    config.bowerDir + '/bootstrap-sass/assets/fonts/**/*',
  ])
  .pipe(gulp.dest(config.publicDir + '/fonts'));
});

gulp.task('js', function() {
  return gulp.src([
    config.bowerDir + '/jquery/dist/jquery.min.js',
    config.bowerDir + '/bootstrap-sass/assets/javascripts/bootstrap.js',
  ])
  .pipe(uglify('app.js', {
    compress: true,
    outSourceMap: true,
  }))
  .pipe(gulp.dest(config.publicDir + '/js'));
});

gulp.task('css', function() {
  return gulp.src('content/style.scss')
  .pipe(sourcemaps.init())
  .pipe(sass({
    outputStyle: 'compressed',
    includePaths: [config.bowerDir + '/bootstrap-sass/assets/stylesheets'],
  }))
  .pipe(sourcemaps.write())
  .pipe(gulp.dest(config.publicDir + '/css'));
});

gulp.task('nanoc', function(cb) {
  exec('nanoc co', function (err, stdout, stderr) {
    console.log(stdout);
    console.log(stderr);
    cb(err);
  });
});

gulp.task('upload', function(cb) {
  exec('lftp -c "open sftp://ftpirtf@ietf.org ; mirror -Rv ' +
       config.outputDir + ' www"', { stdio: 'inherit' },
       function (err, stdout, stderr) {
    console.log(stdout);
    console.log(stderr);
    cb(err);
  });
});

gulp.task('default', function(callback) {
  runSequence(['css', 'js', 'fonts'], 'nanoc');
});
