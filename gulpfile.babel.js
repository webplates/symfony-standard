/*
 gulpfile.babel.js
 =================
 Rather than manage one giant configuration file responsible
 for creating multiple tasks, each task has been broken out into
 its own file in gulp/tasks.
 To add a new task, simply add a new task file that directory.
 etc/gulp/tasks/default.js specifies the default set of tasks to run
 when you run `gulp`.
 */

import {config, env, defaultTask} from './etc/gulp/config';
import gulp from 'gulp';
import BuildTask from './etc/gulp/tasks/build';
import CleanTask from './etc/gulp/tasks/clean';
import FaviconTask from './etc/gulp/tasks/favicons';
import FontTask from './etc/gulp/tasks/fonts';
import ImageTask from './etc/gulp/tasks/images';
import ScriptTask from './etc/gulp/tasks/scripts';
import StyleTask from './etc/gulp/tasks/styles';
import WatchTask from './etc/gulp/tasks/watch';

gulp.task('default', [defaultTask]);

BuildTask.configure(gulp, config, env);
CleanTask.configure(gulp, config, env);
FaviconTask.configure(gulp, config, env);
FontTask.configure(gulp, config, env);
ImageTask.configure(gulp, config, env);
ScriptTask.configure(gulp, config, env);
StyleTask.configure(gulp, config, env);
WatchTask.configure(gulp, config, env);
