#!/usr/bin/perl -w

# $Id: errors.t 1268 2005-02-14 18:04:50Z david $

use strict;
use Test::More tests => 3;

BEGIN {
    use_ok 'App::Info' or die;
}


eval { App::Info->key_name };
ok my $err = $@, "Yes! Caught exception";
like $err,
  qr'App::Info is an abstract base class. Attempt to  call non-existent method App::Info::key_name',
  "and it's the right exception";

