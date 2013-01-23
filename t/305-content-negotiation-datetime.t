#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Fatal;

use DateTime;

BEGIN {
    use_ok('Web::Machine::Util::ContentNegotiation', 'choose_datetime');
}

ok(!defined( choose_datetime( [], DateTime->now ) ), '... got nothing back');
ok(!defined( choose_datetime( [ DateTime->new( year => 2012, month => 1, day => 1 ) ], DateTime->new( year => 2010, month => 1, day => 1 )) ), '... got nothing back');

=pod

We really want to use DateTime objects for comparisons and allow several
different string representations. This might be slower than we'd like, but
Datetime negotiation is a niche case anyway, so it might be okay.

=cut

done_testing;
