import del from 'del';
import size from 'gulp-size';
import favicons from 'favicons';
import gutil from 'gulp-util';

export default class FaviconTask {
    static configure(gulp, config, env) {
        gulp.task('clean:favicons', () => {
            return del([
                'web/android-chrome-*.png',
                'web/apple-touch-*.png',
                'web/browserconfig.xml',
                'web/coast-*.png',
                'web/favicon.ico',
                'web/favicon-*.png',
                'web/firefox_app_*.png',
                'web/manifest.json',
                'web/manifest.webapp',
                'web/mstile-*.png',
                'web/open-graph.png',
                'web/twitter.png',
                'web/yandex-*.png',
                'web/yandex-browser-manifest.json'
            ]);
        });

        gulp.task('favicons', ['clean:favicons'], () => {
            return gulp.src(config.favicons.src)
                .pipe(favicons.stream(config.favicons.config))
                .on('error', gutil.log)
                .pipe(size({title: 'favicons'}))
                .pipe(gulp.dest('web/'));
        });
    }
}
