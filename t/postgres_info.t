#!/usr/bin/perl -w

# $Id: postgres_info.t,v 1.1 2002/06/27 19:57:35 david Exp $

use strict;
use Test::More tests => 21;
use constant SKIP => 17;

##############################################################################
# Make sure that we can use the stuff that's in our local lib directory.
BEGIN {
    if( $ENV{PERL_CORE} ) {
        chdir 't' if -d 't';
        @INC = ('../lib', 'lib');
    } else {
        unshift @INC, 't/lib', 'lib';
    }
}
chdir 't';
use EventTest;

##############################################################################
BEGIN { use_ok('App::Info::RDBMS::PostgreSQL') }

# Test info events.
ok( my $info = EventTest->new, "Create info EventTest" );
ok( my $pg = App::Info::RDBMS::PostgreSQL->new( on_info => $info ),
    "Got Object");
is( $info->message, "Looking for pg_config", "Check constructor info" );

SKIP: {
    # Skip tests?
    skip "PostgreSQL not installed", SKIP unless $pg->installed;

    # Check name.
    $pg->name;
    like($info->message, qr/^Executing `.*pg_config --version`$/,
         "Check name info" );
    $pg->name;
    ok( ! defined $info->message, "No info" );
    $pg->version;
    ok( ! defined $info->message, "Still No info" );

    # Check version.
    ok( $pg = App::Info::RDBMS::PostgreSQL->new( on_info => $info ),
        "Got Object 2");
    $info->message; # Throw away constructor message.
    $pg->version;
    like($info->message, qr/^Executing `.*pg_config --version`$/,
        "Check version info" );

    $pg->version;
    ok( ! defined $info->message, "No info" );
    $pg->major_version;
    ok( ! defined $info->message, "Still No info" );

    # Check major version.
    ok( $pg = App::Info::RDBMS::PostgreSQL->new( on_info => $info ),
        "Got Object 3");
    $info->message; # Throw away constructor message.
    $pg->major_version;
    like($info->message, qr/^Executing `.*pg_config --version`$/,
        "Check major info" );

    # Check minor version.
    ok( $pg = App::Info::RDBMS::PostgreSQL->new( on_info => $info ),
        "Got Object 4");
    $info->message; # Throw away constructor message.
    $pg->minor_version;
    like($info->message, qr/^Executing `.*pg_config --version`$/,
        "Check minor info" );

    # Check patch version.
    ok( $pg = App::Info::RDBMS::PostgreSQL->new( on_info => $info ),
        "Got Object 5");
    $info->message; # Throw away constructor message.
    $pg->patch_version;
    like($info->message, qr/^Executing `.*pg_config --version`$/,
        "Check patch info" );

    # Check dir methods.
    $pg->bin_dir;
    like( $info->message, qr/^Executing `.*pg_config --bindir`$/,
          "Check bin info" );
    $pg->inc_dir;
    like( $info->message, qr/^Executing `.*pg_config --includedir`$/,
        "Check inc info" );
    $pg->lib_dir;
    like( $info->message, qr/^Executing `.*pg_config --libdir`$/,
          "Check lib info" );
    $pg->so_lib_dir;
    like( $info->message, qr/^Executing `.*pg_config --pkglibdir`$/,
        "Check so lib info" );
}

__END__
