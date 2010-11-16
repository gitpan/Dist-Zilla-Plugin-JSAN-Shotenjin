
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  'build_requires' => {
    'Module::Build' => '0.3601'
  },
  'configure_requires' => {
    'Module::Build' => '0.3601'
  },
  'dist_abstract' => 'Run the "Shotenjin.Joosed" helper script for the javascript files with templates',
  'dist_author' => [
    'Nickolay Platonov <nplatonov@cpan.org>'
  ],
  'dist_name' => 'Dist-Zilla-Plugin-JSAN-Shotenjin',
  'dist_version' => '0.01',
  'license' => 'perl',
  'module_name' => 'Dist::Zilla::Plugin::JSAN::Shotenjin',
  'recommends' => {},
  'recursive_test_files' => 1,
  'requires' => {
    'Dist::Zilla' => '4.102343',
    'File::Find::Rule' => '0.28',
    'Getopt::LL' => '1.00',
    'Path::Class' => '0.16'
  },
  'script_files' => [
    'script/shotenjin.pl'
  ]
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
