package N11;
use strict;
use warnings;

use parent 'Web::Machine::Resource';

sub allowed_methods        { [qw[ GET HEAD PUT POST ]] }
sub content_types_provided { [ { 'text/plain' => sub {} } ] }
sub languages_provided     { [qw[ en ]] }
sub charsets_provided      { [ { 'utf-8' => sub {} } ] }
sub resource_exists        { 0 }
sub previously_existed     { 1 }
sub allow_missing_post     { 1 }
sub post_is_create         { 1 }

sub content_types_accepted { [ { 'application/octet-stream' => sub { $_[1] } } ] }
sub create_path { 'foo' }

1;
