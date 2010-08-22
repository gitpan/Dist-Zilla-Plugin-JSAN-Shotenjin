#!/usr/bin/perl

# ABSTRACT: embedd and escape template content 

use strict;
use warnings;


use Shotenjin::Embedder;

use Cwd;
use File::Find::Rule;
use Path::Class;
use Getopt::LL::Simple qw(
    --keep_whitespace|--kw
    --relative_cwd|--cwd
);


my $keep_whitespace     = $ARGV{'--keep_whitespace'};
my $relative_cwd        = $ARGV{'--relative_cwd'};
my $param               = $ARGV[0];


if ($param && -d $param) {
    
    Shotenjin::Embedder->process_dir($param, $keep_whitespace, $relative_cwd ? cwd() : undef);
    
} elsif ($param && -e $param) {
    
    Shotenjin::Embedder->process_file($param, $keep_whitespace, $relative_cwd ? cwd() : undef);
    
} else {
    die "Can't find input files to process, specify it as 1st argument\n(either single file or directory to scan)\n"
}


package shotenjin_embed;
BEGIN {
  $shotenjin_embed::VERSION = '0.01_02';
} #just to satisfy PodWeaver

1;
__END__
=pod

=head1 NAME

shotenjin_embed - embedd and escape template content 

=head1 VERSION

version 0.01_02

=head1 AUTHOR

Nickolay Platonov <nplatonov@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Nickolay Platonov.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

