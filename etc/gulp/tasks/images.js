import del from 'del';
import imagemin from 'gulp-imagemin';
import size from 'gulp-size';
import pluginLoader from 'gulp-load-plugins';

var $i = pluginLoader({
    pattern: ['imagemin-*', 'imagemin.*'],
    replaceString: /^imagemin(-|\.)/
});
export default class ImageTask {
    static configure(gulp, config, env) {
        gulp.task('clean:images', () => {
            return del([config.dest + '/img/*']);
        });

        gulp.task('images', ['clean:images'], () => {
            return gulp.src(config.src + '/img/**/*.{png,svg,jpg,gif}')
                .pipe(imagemin({
                    progressive: true,
                    svgoPlugins: [{removeViewBox: false}],
                    use: [
                        $i.gifsicle(),
                        $i.jpegtran(),
                        $i.optipng(),
                        $i.pngquant()
                    ]
                }))
                .pipe(size({title: 'images'}))
                .pipe(gulp.dest(config.dest + '/img'));
        });

    }
}
