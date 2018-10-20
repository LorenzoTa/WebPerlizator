# WebPerlizator
automate WebPerl page creation using a script or a line of perl code.
See WebPerl by hauxex at https://webperl.zero-g.net/
and the demo used by the present code at https://webperl.zero-g.net/democode/perleditor.html

webperlizator.pl USAGE:

        --script file|--code line [--inputfile file [--inputfile file] --outputfile file [--outputfile file] --browse]

    webperlizator.pl -script script.pl
    webperlizator.pl -script script.pl [ -inputfile file1.txt  -inputfile file2.txt -outputfile file3.txt -browse]
    webperlizator.pl -code "-e 'print qq(Hello WebPerl!)'"
    webperlizator.pl -code "-e 'print qq(Hello WebPerl!)'" [ -i infile1.txt -i infile2.txt  -o outfile3.txt -browse]



       --script -s accept a perl program filename as only argument. Both --script and --code make no sense: just specify one.

        --code -c is intended to be used to pass a oneliner. The executable name, aka perl, will be
        prepended automatically. Any perl switch must be explicitly passed also -e
        For example:

        webperlizator.pl -code "-le 'print qq(Hello WebPerl!)'"
        webperlizator.pl -code "-lne 'print "found a b" if /b/' file1.txt" -i file1.txt -b

        Pay attention on quotes suitable for you OS.

        --inputfiles -i is for input files; more than one can be feed

        --outputfiles -o is for output file and more than one can be passed in

        --browse -b open the default browser, hopefully, pointing to the WebPerl right page

        --help -h prints this help


