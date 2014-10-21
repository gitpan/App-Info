#!/usr/bin/perl -w

# $Id: mypostgres.t 826 2004-11-08 17:35:06Z theory $

use strict;
use Test::More;

if (exists $ENV{APP_INFO_MAINTAINER}) {
    plan tests => 18;
} else {
    plan skip_all => "maintainer's internal tests.";
}

BEGIN { use_ok('App::Info::RDBMS::PostgreSQL') }
BEGIN { use_ok('App::Info::Handler::Carp') }

ok( my $pg = App::Info::RDBMS::PostgreSQL->new( on_error => 'confess' ),
    "Got Object");
isa_ok($pg, 'App::Info::RDBMS::PostgreSQL');
isa_ok($pg, 'App::Info::RDBMS');
isa_ok($pg, 'App::Info');
is( $pg->key_name, 'PostgreSQL', "Check key name" );

ok( $pg->installed, "PostgreSQL is installed" );
is( $pg->name, "PostgreSQL", "Get name" );
is( $pg->version, "8.0.0beta4", "Test Version" );
is( $pg->major_version, '8', "Test major version" );
is( $pg->minor_version, '0', "Test minor version" );
is( $pg->patch_version, '0', "Test patch version" );
is( $pg->lib_dir, '/usr/local/pgsql/lib', "Test lib dir" );
is( $pg->bin_dir, '/usr/local/pgsql/bin', "Test bin dir" );
is( $pg->so_lib_dir, '/usr/local/pgsql/lib', "Test so lib dir" );
is( $pg->inc_dir, "/usr/local/pgsql/include", "Test inc dir" );
is( $pg->configure, '', "Test configure" );
is( $pg->home_url, 'http://www.postgresql.org/', "Get home URL" );
is( $pg->download_url, 'http://www.postgresql.org/mirrors-ftp.html',
    "Get download URL" );
