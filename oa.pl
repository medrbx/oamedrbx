#! /usr/bin/perl

use Modern::Perl;
use Data::Dumper;
use FindBin qw( $Bin ) ;

use lib "$Bin";
use OpenAgenda;

my $eventData = {
    title => {
        fr => "Le jour de Toto"
    },
    description => {
        fr => "Toto champion du monde"
    },
    locationUid => "69680283",
    timings => [
        {
            begin => '2019-06-02T13:45:00+0200',
            end => '2019-06-02T15:45:00+0200'
        }
    ]
};

my $oa = OpenAgenda->new();
$oa->get_oa_access_token;
my $res = $oa->add_event($eventData);

print Dumper($res);