var gulp = require('gulp');
var sass = require('gulp-sass');
var sourcemaps = require('gulp-sourcemaps');
var uglify = require('gulp-uglify');
var exec = require('child_process').execSync;
var runSequence = require('run-sequence');

var conf = {
  bower: './bower_components',
  public: './static',
  output: './output'
};

gulp.task('fonts', function() {
  return gulp.src([
    conf.bower + '/bootstrap-sass/assets/fonts/**/*',
  ])
  .pipe(gulp.dest(conf.public + '/fonts'));
});

gulp.task('js', function() {
  return gulp.src([
    conf.bower + '/jquery/dist/jquery.min.js',
    conf.bower + '/bootstrap-sass/assets/javascripts/bootstrap.js',
  ])
  .pipe(uglify())
  .pipe(gulp.dest(conf.public + '/js'));
});

gulp.task('css', function() {
  return gulp.src('content/style.scss')
  .pipe(sourcemaps.init())
  .pipe(sass({
    outputStyle: 'compressed',
    includePaths: [conf.bower + '/bootstrap-sass/assets/stylesheets'],
  }))
  .pipe(sourcemaps.write())
  .pipe(gulp.dest(conf.public + '/css'));
});

gulp.task('nanoc', function(cb) {
  exec('nanoc co', { stdio: 'inherit' }, function (err) {
    cb(err);
  });
  exec('chmod -R a+rX ' + conf.output, { stdio: 'inherit' }, function (err) {
    cb(err);
  });
});

gulp.task('upload', function(cb) {
  var sftp = 'sftp://ftpirtf@ietf.org';
  exec('lftp -c "open ' + sftp + '; mirror -Rv ' + conf.output + ' www"',
       { stdio: 'inherit' }, function (err) {
    cb(err);
  });
});

gulp.task('default', function(callback) {
  runSequence(['css', 'js', 'fonts'], 'nanoc');
});
