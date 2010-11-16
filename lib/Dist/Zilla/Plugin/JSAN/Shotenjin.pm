package Dist::Zilla::Plugin::JSAN::Shotenjin;
BEGIN {
  $Dist::Zilla::Plugin::JSAN::Shotenjin::VERSION = '0.01';
}

# ABSTRACT: Run the "Shotenjin.Joosed" helper script for the javascript files with templates

use Moose;
use Moose::Autobox;

use Cwd;
use Path::Class;

use Shotenjin::Embedder;

with 'Dist::Zilla::Role::FileMunger';


has 'process_list' => (
    is  => 'rw'
);


sub munge_files {
    my ($self) = @_;
    
    for my $file ($self->zilla->files->flatten) {
        
        my $content = $file->content;
        
        foreach my $entry (@{$self->process_list}) {
            
            if ($file->name =~ $entry->{ regex }) {
                
                $file->content(Shotenjin::Embedder->process_string($content, $entry->{ keep_whitespace }, $entry->{ cwd_as_base } ? cwd() : file($file->name)->dir))
            }
            
        } 
    };
}


sub BUILDARGS {
    my ($class, @arg) = @_;
    
    my %copy            = ref $arg[0] ? %{$arg[0]} : @arg;

    my $zilla           = delete $copy{ zilla };
    my $plugin_name     = delete $copy{ plugin_name };

    my @params;

    foreach my $entry (keys(%copy)) {
        
        my %options = map { $_ => 1 } (split m/,/, $copy{ $entry });
        
        my $keep_whitespace = $options{ kw } || $options{ keep_whitespace };
        my $cwd_as_base     = $options{ cwd } || $options{ cwd_as_base };
        
        push @params, { regex => qr/$entry/, keep_whitespace => $keep_whitespace, cwd_as_base => $cwd_as_base };
    }
    

    return {
        zilla           => $zilla,
        plugin_name     => $plugin_name,
        process_list    => @params > 0 ? \@params : [ { regex => qr/^lib\b/, keep_whitespace => 0, cwd_as_base => 1 } ],
    }
}

no Moose;
__PACKAGE__->meta->make_immutable();


1;



__END__
=pod

=head1 NAME

Dist::Zilla::Plugin::JSAN::Shotenjin - Run the "Shotenjin.Joosed" helper script for the javascript files with templates

=head1 VERSION

version 0.01

=head1 SYNOPSIS

In your F<dist.ini>:

    [JSAN::Shotenjin]
    
    lib/Digest              = cwd_as_base
    lib/Digest/MD5/Test     = 

=head1 DESCRIPTION

This plugin will move the "static" directory of your distribution into the "lib" folder, under its
distribution name. Please refer to L<Module::Build::JSAN::Installable> for details what is a "static" directory. 

Note, that the "static_dir" parameter by itself should be specified for the [JSAN] plugin, because its also 
needed for META.JSON generation.

=head1 BUGS

Please report any bugs or feature requests to L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Dist-Zilla-Plugin-JSAN> or
L<http://github.com/SamuraiJack/Dist-Zilla-Plugin-JSAN/issues>.  
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.

=head1 SOURCES

This module is stored in an open repository at the following address:

L<http://github.com/SamuraiJack/Dist-Zilla-Plugin-JSAN>

=head1 AUTHOR

Nickolay Platonov <nplatonov@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Nickolay Platonov.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

