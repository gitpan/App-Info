#!perl -w

# $Id: zpod.t 826 2004-11-08 17:35:06Z theory $

use strict;
use Test::More;
eval "use Test::Pod 1.20";
plan skip_all => "Test::Pod 1.20 required for testing POD" if $@;
all_pod_files_ok(all_pod_files('lib'));
