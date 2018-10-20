use strict;
use warnings;
use URI::Escape;
use Getopt::Long;
use JSON::MaybeXS qw(encode_json);

my (@infiles, @outfiles, $script, $lineofcode, $browse, $help);
unless ( GetOptions (
                        "script=s" => \$script,
                        "line|oneliner|code|c=s" => \$lineofcode,
                        "inputfiles=s"   => \@infiles,
                        "outputfiles|o=s"  => \@outfiles,
                        "browse"         => \$browse,
                        "help"        => \$help
                    )) 
                        {
                            print "GetOpt::Long returned errors (see above), available options:\n\n".help();
                            exit;
                        }
if ($help){ print help(); exit 0;}

my $json = {};
if ($lineofcode){
    $$json{cmdline} = "perl $lineofcode";
}
elsif ($script){
    open my $fh, '<', $script or die "unable to read $script!";
    while (<$fh>){
        $$json{script} .= $_ ;
    }
    $$json{script_fn} = $script;
    $$json{cmdline} = "perl $script";
}
else{
    die "Please feed at least one script using -script or a line of perl code via -code\n\n".help();
}
if ( $infiles[0] ){
    $$json{inputs}=[];
}
foreach my $in (@infiles){
    open my $fh, '<', $in or die "unable to read $in!";
    my $file = { fn => $in};
    
    while (<$fh>){
        $$file{text}.=$_;
    }
    push @{$$json{inputs}},$file;    
}
if ( $outfiles[0]){
    $$json{outputs} = \@outfiles ;
}

my $url = 'https://webperl.zero-g.net/democode/perleditor.html#'.(uri_escape( encode_json( $json ) ));
if ($browse){
    if ($^O =~/mswin32/i) {exec "start $url"}
    else{ exec "xdg-open $url"}
}
else{
    print $url;
}
####
sub help{
    return <<EOH;
$0 USAGE:

	--script file|--code line [--inputfile file [--inputfile file] --outputfile file [--outputfile file] --browse]
	
    $0 -script script.pl 
    $0 -script script.pl [ -inputfile file1.txt  -inputfile file2.txt -outputfile file3.txt -browse]
    $0 -code "-e 'print qq(Hello WebPerl!)'"
    $0 -code "-e 'print qq(Hello WebPerl!)'" [ -i infile1.txt -i infile2.txt  -o outfile3.txt -browse]    

	
	--script -s accept a perl program filename as only argument. 
        Both --script and --code make no sense: just specify one.
	
        --code -c is intended to be used to pass a oneliner. The executable name, aka perl, will be
	prepended automatically. Any perl switch must be explicitly passed also -e
	For example: 
	
	webperlizator.pl -code "-le 'print qq(Hello WebPerl!)'"
	webperlizator.pl -code "-lne 'print \"found a b\" if /b/' file1.txt" -i file1.txt -b
	
	Pay attention on quotes suitable for you OS.
	
	--inputfiles -i is for input files; more than one can be feed
	
	--outputfiles -o is for output file and more than one can be passed in
	
	--browse -b open the default browser, hopefully, pointing to the WebPerl right page
	
	--help -h prints this help

    
EOH
}
