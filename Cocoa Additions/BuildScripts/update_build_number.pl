use strict;
use warnings;

use FindBin;

=head1 update_build_number.pl

 Script to increment the bundle version by 1 in your Info.plist each time
 you build in Xcode. The number is encoded in base 62 to keep it to a
 reasonable length while maintaining readability.
 
=head1 Synopsis
 
 Put this script in the same directory as your $TARGET_NAME-Infoe.plist file
 (usually the root dir of the project, but you may have moved it).
 
 Make a new "Run Scripts" phase in your Xcode target (put it before the compile
 and copy resources phase), with /bin/sh as the shell and the script as:
 
   /usr/bin/perl update_build_number.pl
 
 If your info.plist and thus this script is in a subdirectory, put the relative
 path. Eg. I often create a Resources subdirectory for the info.plist etc.:
 
   /usr/bin/perl Resources/update_build_number.pl
 
 Now every time you do a build, the Bundle Version will increment by 1 (in base 62).
 
=head1 Note about Info.plist name and Xcode project versions
 
 Earlier versions of Xcode just named the file Info.plist without the Target Name
 prefix. You may also have renamed the file, or you might want to use a system
 installed version of this script. This script takes an optional argument specifying the relative
 path to the info.plist file - this saves hacking the script or having multiple copies.
 So your script phase could be something like:
 
   /usr/bin/perl /opt/bin/update_build_number.pl ${TARGET_NAME}-Info.plist
 
=head1 Author
 
 Mark Aufflick, Pumptheory Pty Ltd <mark@pumptheory.com>
 
=head1 See Also
 
=over 4
 
=item GitHub repository : L<https://github.com/aufflick/aufflick-cocoa-additions>
 
=back
 
=head1 Credits

=over 4

=item I snarfed the base 62 conversion from L<http://www.perlmonks.org/?node_id=27148>
 
=item PlistBuddy knowledge gained from http://davedelong.com/blog/2009/04/15/incrementing-build-numbers-xcode
 
=back
 
=cut

my $info_plist = $ARGV[0];
$info_plist ||= "$FindBin::Bin/$ENV{TARGET_NAME}-Info.plist";

my $plist_buddy = '/usr/libexec/PlistBuddy';

my @nums = (0..9,'a'..'z','A'..'Z');
my $index = 0;
my %nums = map {$_,$index++} @nums;

if (! -f $info_plist)
{
    die "Couldn't find info.plist file: '$info_plist'";
}

my $current_build = `$plist_buddy -c "Print CFBundleVersion" "$info_plist"`;
chomp $current_build;

my $new_build = to_base_62( from_base_62( $current_build ) + 1 );

my $ret = system(qq{$plist_buddy -c "Set CFBundleVersion $new_build" "$info_plist"});

exit($ret);

sub to_base_62
{
    my $number = shift;
    
    my $rep = ""; # this will be the end value.
    
    while( $number > 0 )
    {
        $rep = $nums[$number % 62] . $rep;
        $number = int( $number / 62 );
    }
    
    return $rep;
}

sub from_base_62
{
    my $rep = shift;
    
    my $number = 0;
    
    for( split //, $rep )
    {
        $number *= 62;
        die "bad base 62 character: '$_'" if ! exists $nums{$_};
        $number += $nums{$_};
    }
    
    return $number;
}
