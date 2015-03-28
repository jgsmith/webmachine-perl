#!/usr/bin/perl

use strict;
use warnings;
use FindBin;

use Test::More;
use Test::Fatal;

use Plack::Test;
use Plack::Util;

use HTTP::Request::Common;

BEGIN {
    if (!eval { require JSON::XS; 1 }) {
        plan skip_all => "JSON::XS is required for this test";
    }
    if (!eval { require Path::Class; Path::Class->import; 1 }) {
        plan skip_all => "Path::Class is required for this test";
    }
}

my $dir = file(__FILE__)->parent->parent->parent->subdir('examples')->subdir('yapc-talk-examples');

test_psgi
    Plack::Util::load_psgi( $dir->file('010-browser.psgi')->stringify ),
    sub {
        my $cb  = shift;

        {
            my $res = $cb->(GET "/" => ('Accept' => '*/*'));
            is($res->code, 200, '... got the expected status');
            is($res->header('Content-Type'), 'application/json', '... got the expected Content-Type header');
            is($res->header('Content-Length'), 32, '... got the expected Content-Length header');
            is_deeply(
                JSON::XS::decode_json( $res->content ),
                [ { 1 => "*/*" } ] ,
                '... got the expected content'
            );
        }

        {
            my $res = $cb->(GET "/" => ('Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'));
            is($res->code, 200, '... got the expected status');
            is($res->header('Content-Type'), 'application/json', '... got the expected Content-Type header');
            is($res->header('Content-Length'), 159, '... got the expected Content-Length header');
            is_deeply(
                JSON::XS::decode_json( $res->content ),
                [
                    { 1   => "text/html" },
                    { 1   => "application/xhtml+xml" },
                    { 0.9 => "application/xml" },
                    { 0.8 => "*/*" }
                ],
                '... got the expected content'
            );
        }
    };

done_testing;