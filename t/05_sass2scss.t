# -*- perl -*-

# Usefult for debugging the xs with prints:
# cd text-sass-xs && ./Build && perl -Mlib=blib/arch -Mlib=blib/lib t/04_perl_functions.t

use strict;
use warnings;

use Test::More tests => 45;

use CSS::Sass;
use File::Slurp;
use Data::Dumper;

my $sass = read_file('t/inc/sass/pretty.sass');
my $pretty0 = read_file('t/inc/scss/pretty-0.scss');
my $pretty1 = read_file('t/inc/scss/pretty-1.scss');
my $pretty2 = read_file('t/inc/scss/pretty-2.scss');
my $pretty3 = read_file('t/inc/scss/pretty-3.scss');

my $ignore_whitespace = 1;

my ($r, $err);

($r, $err) = CSS::Sass::sass2scss($sass);
$r =~ s/[\r\n]+/\n/g if $ignore_whitespace;
$pretty1 =~ s/[\r\n]+/\n/g if $ignore_whitespace;
chomp($pretty1) if $ignore_whitespace;
chomp($r) if $ignore_whitespace;
is    ($r,   $pretty1,                                  "Default pretty print");

($r, $err) = CSS::Sass::sass2scss($sass, SASS2SCSS_PRETTIFY_0);
$r =~ s/[\r\n]+/\n/g if $ignore_whitespace;
$pretty0 =~ s/[\r\n]+/\n/g if $ignore_whitespace;
chomp($pretty0) if $ignore_whitespace;
chomp($r) if $ignore_whitespace;
is    ($r,   $pretty0,                                 "Pretty print option 0");

($r, $err) = CSS::Sass::sass2scss($sass, SASS2SCSS_PRETTIFY_1);
$pretty1 =~ s/[\r\n]+/\n/g if $ignore_whitespace;
$r =~ s/[\r\n]+/\n/g if $ignore_whitespace;
chomp($pretty1) if $ignore_whitespace;
chomp($r) if $ignore_whitespace;
is    ($r,   $pretty1,                                 "Pretty print option 1");

($r, $err) = CSS::Sass::sass2scss($sass, SASS2SCSS_PRETTIFY_2);
$pretty2 =~ s/[\r\n]+/\n/g if $ignore_whitespace;
$r =~ s/[\r\n]+/\n/g if $ignore_whitespace;
chomp($pretty2) if $ignore_whitespace;
chomp($r) if $ignore_whitespace;
is    ($r,   $pretty2,                                 "Pretty print option 2");

($r, $err) = CSS::Sass::sass2scss($sass, SASS2SCSS_PRETTIFY_3);
$r =~ s/[\r\n]+/\n/g if $ignore_whitespace;
$pretty3 =~ s/[\r\n]+/\n/g if $ignore_whitespace;
chomp($pretty3) if $ignore_whitespace;
chomp($r) if $ignore_whitespace;
is    ($r,   $pretty3,                                 "Pretty print option 3");


my ($src, $expect);

# \/\/\/ -- https://github.com/ArnaudRinquin/sass2scss/blob/master/test/ -- \/\/\/

$src = read_file('t/inc/sass/t-01.sass');
($r, $err) = CSS::Sass::sass2scss($src);
$r =~ s/[\r\n]+/\n/g if $ignore_whitespace;
$expect = read_file('t/inc/scss/t-01.scss');
$expect =~ s/[\r\n]+/\n/g if $ignore_whitespace;
chomp($expect) if $ignore_whitespace;
chomp($r) if $ignore_whitespace;

is    ($r, $expect,                                    "Very basic convertion");
is    ($err, undef,                                    "Very basic convertion");

$src = read_file('t/inc/sass/t-02.sass');
($r, $err) = CSS::Sass::sass2scss($src);
$r =~ s/[\r\n]+/\n/g if $ignore_whitespace;
$expect = read_file('t/inc/scss/t-02.scss');
$expect =~ s/[\r\n]+/\n/g if $ignore_whitespace;
chomp($expect) if $ignore_whitespace;
chomp($r) if $ignore_whitespace;

is    ($r, $expect,                                    "Converts sass mixin and include aliases");
is    ($err, undef,                                    "Converts sass mixin and include aliases");

$src = read_file('t/inc/sass/t-03.sass');
($r, $err) = CSS::Sass::sass2scss($src);
$r =~ s/[\r\n]+/\n/g if $ignore_whitespace;
$expect = read_file('t/inc/scss/t-03.scss');
$expect =~ s/[\r\n]+/\n/g if $ignore_whitespace;
chomp($expect) if $ignore_whitespace;
chomp($r) if $ignore_whitespace;

is    ($r, $expect,                                    "Ignore comments on block last line");
is    ($err, undef,                                    "Ignore comments on block last line");

$src = read_file('t/inc/sass/t-04.sass');
($r, $err) = CSS::Sass::sass2scss($src);
$r =~ s/[\r\n]+/\n/g if $ignore_whitespace;
$expect = read_file('t/inc/scss/t-04.scss');
$expect =~ s/[\r\n]+/\n/g if $ignore_whitespace;
chomp($expect) if $ignore_whitespace;
chomp($r) if $ignore_whitespace;

is    ($r, $expect,                                    "Handle selectors not containing alphanumeric characters");
is    ($err, undef,                                    "Handle selectors not containing alphanumeric characters");

# /\/\/\ -- https://github.com/ArnaudRinquin/sass2scss/blob/master/test/ -- /\/\/\

$src = read_file('t/inc/sass/t-05.sass');
($r, $err) = CSS::Sass::sass2scss($src);
$r =~ s/[\r\n]+/\n/g if $ignore_whitespace;
$expect = read_file('t/inc/scss/t-05.scss');
$expect =~ s/[\r\n]+/\n/g if $ignore_whitespace;
chomp($expect) if $ignore_whitespace;
chomp($r) if $ignore_whitespace;

is    ($r, $expect,                                    "Handle strange comment indentation");
is    ($err, undef,                                    "Handle strange comment indentation");

$src = read_file('t/inc/sass/t-06.sass');
($r, $err) = CSS::Sass::sass2scss($src);
$r =~ s/[\r\n]+/\n/g if $ignore_whitespace;
$expect = read_file('t/inc/scss/t-06.scss');
$expect =~ s/[\r\n]+/\n/g if $ignore_whitespace;
chomp($expect) if $ignore_whitespace;
chomp($r) if $ignore_whitespace;

is    ($r, $expect,                                    "Handle not closed multiline comments");
is    ($err, undef,                                    "Handle not closed multiline comments");

$src = read_file('t/inc/sass/t-07.sass');
($r, $err) = CSS::Sass::sass2scss($src);
$r =~ s/[\r\n]+/\n/g if $ignore_whitespace;
$expect = read_file('t/inc/scss/t-07.scss');
$expect =~ s/[\r\n]+/\n/g if $ignore_whitespace;
chomp($expect) if $ignore_whitespace;
chomp($r) if $ignore_whitespace;

is    ($r, $expect,                                    "Handle self closing multiline comments");
is    ($err, undef,                                    "Handle self closing multiline comments");

$src = read_file('t/inc/sass/t-08.sass');
($r, $err) = CSS::Sass::sass2scss($src, SASS2SCSS_PRETTIFY_1 | SASS2SCSS_KEEP_COMMENT);
$r =~ s/[\r\n]+/\n/g if $ignore_whitespace;
$expect = read_file('t/inc/scss/t-08.scss');
$expect =~ s/[\r\n]+/\n/g if $ignore_whitespace;
chomp($expect) if $ignore_whitespace;
chomp($r) if $ignore_whitespace;

is    ($r, $expect,                                    "Handle \"keep_comments\" option");
is    ($err, undef,                                    "Handle \"keep_comments\" option");

$src = read_file('t/inc/sass/t-09.sass');
($r, $err) = CSS::Sass::sass2scss($src, SASS2SCSS_PRETTIFY_1 | SASS2SCSS_CONVERT_COMMENT);
$r =~ s/[\r\n]+/\n/g if $ignore_whitespace;
$expect = read_file('t/inc/scss/t-09.scss');
$expect =~ s/[\r\n]+/\n/g if $ignore_whitespace;
chomp($expect) if $ignore_whitespace;
chomp($r) if $ignore_whitespace;

is    ($r, $expect,                                    "Handle \"convert_comment\" option");
is    ($err, undef,                                    "Handle \"convert_comment\" option");

$src = read_file('t/inc/sass/t-10.sass');
($r, $err) = CSS::Sass::sass2scss($src, SASS2SCSS_PRETTIFY_1 | SASS2SCSS_CONVERT_COMMENT | SASS2SCSS_STRIP_COMMENT);
$r =~ s/[\r\n]+/\n/g if $ignore_whitespace;
$expect = read_file('t/inc/scss/t-10.scss');
$expect =~ s/[\r\n]+/\n/g if $ignore_whitespace;
chomp($expect) if $ignore_whitespace;
chomp($r) if $ignore_whitespace;

is    ($r, $expect,                                    "Handle \"strip_comment\" option");
is    ($err, undef,                                    "Handle \"strip_comment\" option");

$src = read_file('t/inc/sass/t-11.sass');
($r, $err) = CSS::Sass::sass2scss($src, SASS2SCSS_PRETTIFY_1 | SASS2SCSS_CONVERT_COMMENT | SASS2SCSS_STRIP_COMMENT);
$r =~ s/[\r\n]+/\n/g if $ignore_whitespace;
$expect = read_file('t/inc/scss/t-11.scss');
$expect =~ s/[\r\n]+/\n/g if $ignore_whitespace;
chomp($expect) if $ignore_whitespace;
chomp($r) if $ignore_whitespace;

is    ($r, $expect,                                    "Handle unquoted import statements");
is    ($err, undef,                                    "Handle unquoted import statements");

$src = read_file('t/inc/sass/t-12.sass');
($r, $err) = CSS::Sass::sass2scss($src, SASS2SCSS_PRETTIFY_1);
$r =~ s/[\r\n]+/\n/g if $ignore_whitespace;
$expect = read_file('t/inc/scss/t-12.scss');
$expect =~ s/[\r\n]+/\n/g if $ignore_whitespace;
chomp($expect) if $ignore_whitespace;
chomp($r) if $ignore_whitespace;

is    ($r, $expect,                                    "Handle comma separated selctors");
is    ($err, undef,                                    "Handle comma separated selctors");

$src = read_file('t/inc/sass/t-13.sass');
($r, $err) = CSS::Sass::sass2scss($src, SASS2SCSS_PRETTIFY_1);
$r =~ s/[\r\n]+/\n/g if $ignore_whitespace;
$expect = read_file('t/inc/scss/t-13.scss');
$expect =~ s/[\r\n]+/\n/g if $ignore_whitespace;
chomp($expect) if $ignore_whitespace;
chomp($r) if $ignore_whitespace;

is    ($r, $expect,                                    "Handle pseudo-selectors and sass property syntax");
is    ($err, undef,                                    "Handle pseudo-selectors and sass property syntax");

$src = read_file('t/inc/sass/t-14.sass');
($r, $err) = CSS::Sass::sass2scss($src, SASS2SCSS_PRETTIFY_1);
$r =~ s/[\r\n]+/\n/g if $ignore_whitespace;
$expect = read_file('t/inc/scss/t-14.scss');
$expect =~ s/[\r\n]+/\n/g if $ignore_whitespace;
chomp($expect) if $ignore_whitespace;
chomp($r) if $ignore_whitespace;

is    ($r, $expect,                                    "Handle empty selectors");
is    ($err, undef,                                    "Handle empty selectors");

$src = read_file('t/inc/sass/t-15.sass');
($r, $err) = CSS::Sass::sass2scss($src, SASS2SCSS_PRETTIFY_1);
$r =~ s/[\r\n]+/\n/g if $ignore_whitespace;
$expect = read_file('t/inc/scss/t-15.scss');
$expect =~ s/[\r\n]+/\n/g if $ignore_whitespace;
chomp($expect) if $ignore_whitespace;
chomp($r) if $ignore_whitespace;

is    ($r, $expect,                                    "Handle \@content keyword");
is    ($err, undef,                                    "Handle \@content keyword");

$src = read_file('t/inc/sass/t-16.sass');
($r, $err) = CSS::Sass::sass2scss($src, SASS2SCSS_PRETTIFY_1);
$r =~ s/[\r\n]+/\n/g if $ignore_whitespace;
$expect = read_file('t/inc/scss/t-16.scss');
$expect =~ s/[\r\n]+/\n/g if $ignore_whitespace;
chomp($expect) if $ignore_whitespace;
chomp($r) if $ignore_whitespace;

is    ($r, $expect,                                    "Handle \@return keyword");
is    ($err, undef,                                    "Handle \@return keyword");

$src = read_file('t/inc/sass/comment.sass');
($r, $err) = CSS::Sass::sass2scss($src, SASS2SCSS_PRETTIFY_1 | SASS2SCSS_KEEP_COMMENT);
$r =~ s/[\r\n]+/\n/g if $ignore_whitespace;
$expect = read_file('t/inc/scss/comment-keep.scss');
$expect =~ s/[\r\n]+/\n/g if $ignore_whitespace;
chomp($expect) if $ignore_whitespace;
chomp($r) if $ignore_whitespace;

is    ($r, $expect,                                    "Handle \"keep_comment\" option");
is    ($err, undef,                                    "Handle \"keep_comment\" option");

$src = read_file('t/inc/sass/comment.sass');
($r, $err) = CSS::Sass::sass2scss($src, SASS2SCSS_PRETTIFY_1 | SASS2SCSS_CONVERT_COMMENT);
$r =~ s/[\r\n]+/\n/g if $ignore_whitespace;
$expect = read_file('t/inc/scss/comment-convert.scss');
$expect =~ s/[\r\n]+/\n/g if $ignore_whitespace;
chomp($expect) if $ignore_whitespace;
chomp($r) if $ignore_whitespace;

is    ($r, $expect,                                    "Handle \"convert_comment\" option");
is    ($err, undef,                                    "Handle \"convert_comment\" option");

$src = read_file('t/inc/sass/comment.sass');
($r, $err) = CSS::Sass::sass2scss($src, SASS2SCSS_PRETTIFY_1 | SASS2SCSS_KEEP_COMMENT | SASS2SCSS_CONVERT_COMMENT);
$r =~ s/[\r\n]+/\n/g if $ignore_whitespace;
$expect = read_file('t/inc/scss/comment-keep-convert.scss');
$expect =~ s/[\r\n]+/\n/g if $ignore_whitespace;
chomp($expect) if $ignore_whitespace;
chomp($r) if $ignore_whitespace;

is    ($r, $expect,                                    "Handle \"keep_comment|convert_comment\" option");
is    ($err, undef,                                    "Handle \"keep_comment|convert_comment\" option");

$src = read_file('t/inc/sass/comment.sass');
($r, $err) = CSS::Sass::sass2scss($src, SASS2SCSS_PRETTIFY_1 | SASS2SCSS_STRIP_COMMENT);
$r =~ s/[\r\n]+/\n/g if $ignore_whitespace;
$expect = read_file('t/inc/scss/comment-strip.scss');
$expect =~ s/[\r\n]+/\n/g if $ignore_whitespace;
chomp($expect) if $ignore_whitespace;
chomp($r) if $ignore_whitespace;

is    ($r, $expect,                                    "Handle \"strip_comment\" option");
is    ($err, undef,                                    "Handle \"strip_comment\" option");

