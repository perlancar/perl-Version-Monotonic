package Version::Monotonic;

# DATE
# VERSION

#IFUNBUILT
use strict;
use warnings;
#END IFUNBUILT

use Exporter qw(import);
our @EXPORT_OK = qw(
                       valid_version
                       inc_version
               );

our $re = qr/\A([1-9][0-9]*)\.([1-9][0-9]*)(\.0)?\z/;

sub valid_version {
    my $v = shift;
    $v =~ $re ? 1:0;
}

sub inc_version {
    my ($v, $inc_compat) = @_;

    my ($compat, $rel, $zero) = $v =~ $re
        or die "Invalid monotonic version '$v'";
    $compat++ if $inc_compat;
    $rel++;
    "$compat.$rel".($zero || "");
}

1;
# ABSTRACT: Utility routines related to monotonic versioning

=head1 SYNOPSIS

 use Version::Monotonic qw(
     valid_version
     inc_version
 );
 say valid_version("0.1");  # => 0
 say valid_version("1.01"); # => 0
 say valid_version("1.1");  # => 1

 say inc_version("1.9");    # => "1.10"
 say inc_version("1.9", 1); # => "2.10"


=head1 DESCRIPTION

This module provides utility routines related to monotonic versioning (see link
to the manifesto in L</"SEE ALSO">).


=head1 FUNCTIONS

None exported by default, but they are exportable.

=head2 valid_version($v) => bool

Check whether string C<$v> contains a valid monotonic version number.

=head2 inc_version($v, $inc_compat) => str

Return version number C<$v> incremented by one release. Die if C<$v> is invalid.


=head1 SEE ALSO

L<http://blog.appliedcompscilab.com/monotonic_versioning_manifesto/>

=cut
