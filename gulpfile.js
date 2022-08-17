var gulp = require('gulp');
var sass = require('gulp-sass');
var sourcemaps = require('gulp-sourcemaps');
var uglify = require('gulp-uglify');
var exec = require('child_process').execSync;
var runSequence = require('run-sequence');

var conf = {
  node: './node_modules',
  public: './static',
  output: './output',
};

gulp.task('fonts', function() {
  return gulp.src([
    conf.node + '/bootstrap-sass/assets/fonts/**/*',
  ])
  .pipe(gulp.dest(conf.public + '/fonts'));
});

gulp.task('js', function() {
  return gulp.src([
    conf.node + '/jquery/dist/jquery.min.js',
    conf.node + '/bootstrap-sass/assets/javascripts/bootstrap.js',
  ])
  .pipe(uglify())
  .pipe(gulp.dest(conf.public + '/js'));
});

gulp.task('css', function() {
  return gulp.src('content/style.scss')
  .pipe(sourcemaps.init())
  .pipe(sass({
    outputStyle: 'compressed',
    includePaths: [conf.node + '/bootstrap-sass/assets/stylesheets'],
  }))
  .pipe(sourcemaps.write())
  .pipe(gulp.dest(conf.public + '/css'));
});

gulp.task('nanoc', function(cb) {
  exec('bundle exec nanoc', { stdio: 'inherit' }, function (err) {
    cb(err);
  });
  exec('chmod -R a+rX ' + conf.output, { stdio: 'inherit' }, function (err) {
    cb(err);
  });
});

gulp.task('upload', function(cb) {
  var sftp = 'sftp://ftpirtf@ietf.org';
  var opts = '--reverse --delete --parallel=10 --exclude=usagedata' +
             ' --exclude=hotcrp -vvv ';
  exec('lftp -c "open ' + sftp + ';  mirror ' + opts + conf.output + ' www"',
       { stdio: 'inherit' }, function (err) {
    cb(err);
  });
});

gulp.task('default', function(callback) {
  runSequence(['css', 'js', 'fonts'], 'nanoc');
});
